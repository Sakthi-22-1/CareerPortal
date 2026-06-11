package com.career.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.ResultDAO;
import com.career.model.Result;

/**
 * WeakAreaServlet - Analyzes and displays the user's weak areas.
 * URL: /weakarea (GET)
 * 
 * Aggregates weak topics from all quiz results for the current user.
 * Counts the frequency of each weak topic and passes the data to weakarea.jsp.
 */
@WebServlet("/weakarea")
public class WeakAreaServlet extends HttpServlet {
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

            // Step 3: Fetch all quiz results for this user
            List<Result> results = ResultDAO.getResultsByUser(userId);

            // Step 4: Aggregate weak topics and count their frequency
            // Map key = topic name, Map value = number of times it appeared as weak
            Map<String, Integer> weakAreas = new LinkedHashMap<>();

            for (Result result : results) {
                String weakTopics = result.getWeakTopics();

                // Skip if no weak topics for this result
                if (weakTopics == null || weakTopics.trim().isEmpty()) {
                    continue;
                }

                // Split comma-separated topics and count each one
                String[] topics = weakTopics.split(",");
                for (String topic : topics) {
                    String trimmedTopic = topic.trim();
                    if (!trimmedTopic.isEmpty()) {
                        // Increment the count for this topic (default to 0 if first time)
                        weakAreas.put(trimmedTopic, weakAreas.getOrDefault(trimmedTopic, 0) + 1);
                    }
                }
            }

            // Step 5: Set the weak areas map and results as request attributes
            request.setAttribute("weakAreas", weakAreas);
            request.setAttribute("results", results);

            // Step 6: Forward to the weak area JSP page
            request.getRequestDispatcher("weakarea.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any database or unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "Failed to load weak area analysis. Please try again.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}
