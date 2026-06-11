package com.career.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

/**
 * DashboardServlet - Displays the user dashboard.
 * URL: /dashboard (GET)
 * 
 * Checks if the user is logged in (session contains userId).
 * If not logged in, redirects to the login page.
 * Otherwise, forwards to dashboard.jsp.
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Check if the user has an active session
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            // User is not logged in - redirect to login page
            response.sendRedirect("login.jsp");
            return;
        }

        // Step 2: User is logged in - forward to the dashboard JSP
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
