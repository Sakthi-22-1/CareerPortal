package com.career.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.QuestionDAO;
import com.career.model.Question;

/**
 * AdminDashboardServlet - Displays the admin dashboard with all questions.
 * URL: /adminDashboard (GET)
 * 
 * Checks if the admin is logged in (session contains adminId).
 * Fetches all questions from the database and forwards to admin-dashboard.jsp.
 */
@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Check if the admin has an active session
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            // Admin is not logged in - redirect to admin login page
            response.sendRedirect("admin-login.jsp");
            return;
        }

        try {
            // Step 2: Fetch all questions from the database
            List<Question> questions = QuestionDAO.getAllQuestions();

            // Step 3: Set the questions as a request attribute
            request.setAttribute("questions", questions);

            // Step 4: Forward to the admin dashboard JSP
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any database or unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "Failed to load questions. Please try again.");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        }
    }
}
