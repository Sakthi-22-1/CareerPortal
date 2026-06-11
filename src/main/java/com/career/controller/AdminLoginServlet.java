package com.career.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.AdminDAO;
import com.career.model.Admin;

/**
 * AdminLoginServlet - Handles admin login authentication.
 * URL: /adminLogin (POST)
 * 
 * Validates admin credentials against the database.
 * On success, creates a session with admin details and redirects to admin dashboard.
 */
@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Retrieve admin login form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Step 2: Validate that fields are not empty
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }

        try {
            // Step 3: Authenticate admin via DAO
            Admin admin = AdminDAO.login(username.trim(), password);

            if (admin != null) {
                // Step 4: Login successful - create a new session
                HttpSession session = request.getSession();
                session.setAttribute("adminId", admin.getId());
                session.setAttribute("adminUsername", admin.getUsername());

                // Redirect to the admin dashboard
                response.sendRedirect("adminDashboard");
            } else {
                // Login failed - invalid credentials
                request.setAttribute("error", "Invalid username or password.");
                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Handle any database or unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong. Please try again later.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}
