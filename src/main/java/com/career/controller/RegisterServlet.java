package com.career.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.UserDAO;
import com.career.model.User;

/**
 * RegisterServlet - Handles new user registration.
 * URL: /register (POST)
 * 
 * Collects name, email, and password from the registration form,
 * validates them, and saves the user to the database via UserDAO.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Step 2: Validate that no fields are empty
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            // Set error message and send user back to registration page
            request.setAttribute("error", "All fields are required. Please fill in all fields.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            // Step 3: Create a User object and set the fields
            User user = new User();
            user.setName(name.trim());
            user.setEmail(email.trim());
            user.setPassword(password);

            // Step 4: Call DAO to register the user in the database
            boolean isRegistered = UserDAO.register(user);

            if (isRegistered) {
                // Registration successful - forward to login page with success message
                request.setAttribute("success", "Registration successful! Please login.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                // Registration failed (e.g., duplicate email)
                request.setAttribute("error", "Registration failed. Email may already be registered.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Handle any database or unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong. Please try again later.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
