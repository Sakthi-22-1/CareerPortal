package com.career.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.QuestionDAO;

/**
 * DeleteQuestionServlet - Handles deleting a question from the database.
 * URL: /deleteQuestion (GET)
 * 
 * Receives a question ID as a parameter, verifies admin session,
 * deletes the question via QuestionDAO, and redirects to admin dashboard.
 */
@WebServlet("/deleteQuestion")
public class DeleteQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Check if the admin is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            // Admin is not logged in - redirect to admin login page
            response.sendRedirect("admin-login.jsp");
            return;
        }

        try {
            // Step 2: Get the question ID from the request parameter
            int id = Integer.parseInt(request.getParameter("id"));

            // Step 3: Delete the question from the database
            QuestionDAO.deleteQuestion(id);

            // Step 4: Redirect back to the admin dashboard
            response.sendRedirect("adminDashboard");

        } catch (NumberFormatException e) {
            // Handle invalid question ID format
            e.printStackTrace();
            response.sendRedirect("adminDashboard");
        } catch (Exception e) {
            // Handle any database or unexpected errors
            e.printStackTrace();
            response.sendRedirect("adminDashboard");
        }
    }
}
