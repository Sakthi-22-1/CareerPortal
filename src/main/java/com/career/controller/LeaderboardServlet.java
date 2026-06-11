package com.career.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.ResultDAO;
import com.career.model.Result;

/**
 * LeaderboardServlet - Displays the leaderboard ranking.
 * URL: /leaderboard (GET)
 * 
 * Fetches the leaderboard data (top scorers) from the database
 * and forwards it to leaderboard.jsp for display.
 */
@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Step 1: Fetch leaderboard data from the database
            List<Result> leaderboard = ResultDAO.getLeaderboard();

            // Step 2: Set the leaderboard as a request attribute
            request.setAttribute("leaderboard", leaderboard);

            // Step 3: Forward to the leaderboard JSP page
            request.getRequestDispatcher("leaderboard.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any database or unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "Failed to load leaderboard. Please try again.");
            request.getRequestDispatcher("leaderboard.jsp").forward(request, response);
        }
    }
}
