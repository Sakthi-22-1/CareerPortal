package com.career.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.UserDAO;
import com.career.model.User;

/**
 * LoginServlet - Handles user login authentication.
 * URL: /login (POST)
 * 
 * Validates user credentials against the database.
 * On success, creates a session with user details and redirects to dashboard.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Retrieve login form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Step 2: Validate that fields are not empty
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            // Step 3: Authenticate user via DAO
            User user = UserDAO.login(email.trim(), password);

            if (user != null) {
                // Step 4: Login successful - create a new session
                HttpSession session = request.getSession();
                session.setAttribute("userId", user.getId());
                session.setAttribute("userName", user.getName());
                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("userStreak", user.getStreak());

                // Redirect to the dashboard page
                response.sendRedirect("dashboard");
            } else {
                // Login failed - invalid credentials
                request.setAttribute("error", "Invalid email or password. Please try again.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Handle any database or unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong. Please try again later.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
