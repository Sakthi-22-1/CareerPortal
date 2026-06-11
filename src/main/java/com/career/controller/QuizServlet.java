package com.career.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.QuestionDAO;
import com.career.model.Question;

/**
 * QuizServlet - Loads quiz questions for a given category.
 * URL: /quiz (GET)
 * 
 * Retrieves the 'category' parameter, fetches questions from the database,
 * and forwards them to quiz.jsp for display.
 */
@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {
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

        // Step 2: Get the quiz category from the request parameter
        String category = request.getParameter("category");

        try {
            // Step 3: Fetch questions for the selected category from the database
            List<Question> questions = QuestionDAO.getQuestionsByCategory(category);

            // Step 4: Set the questions and category as request attributes
            request.setAttribute("questions", questions);
            request.setAttribute("category", category);

            // Step 5: Forward to the quiz JSP page
            request.getRequestDispatcher("quiz.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any database errors
            e.printStackTrace();
            request.setAttribute("error", "Failed to load quiz questions. Please try again.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}
