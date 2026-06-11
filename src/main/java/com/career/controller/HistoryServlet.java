package com.career.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.ResultDAO;
import com.career.model.Result;

/**
 * HistoryServlet - Displays the quiz history for the logged-in user.
 * URL: /history (GET)
 * 
 * Fetches all past quiz results for the current user from the database
 * and forwards them to history.jsp for display.
 */
@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Check if the user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            // User is not logged in - redirect to login page
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Step 2: Get the userId from the session
            int userId = (int) session.getAttribute("userId");

            // Step 3: Fetch all quiz results for this user from the database
            List<Result> results = ResultDAO.getResultsByUser(userId);

            // Step 4: Set the results as a request attribute
            request.setAttribute("results", results);

            // Step 5: Forward to the history JSP page
            request.getRequestDispatcher("history.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any database or unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "Failed to load quiz history. Please try again.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}
