package com.career.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

/**
 * LogoutServlet - Handles user logout.
 * URL: /logout (GET)
 * 
 * Invalidates the current session and redirects the user to the login page.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Get the current session (if it exists)
        HttpSession session = request.getSession(false);

        // Step 2: Invalidate the session to log the user out
        if (session != null) {
            session.invalidate();
        }

        // Step 3: Redirect to the login page
        response.sendRedirect("login.jsp");
    }
}
