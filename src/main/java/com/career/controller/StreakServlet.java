package com.career.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.StreakDAO;
import com.career.model.StreakHistory;

@WebServlet("/streaks")
public class StreakServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");
            List<StreakHistory> streakHistory = StreakDAO.getStreakHistoryByUser(userId);

            request.setAttribute("streakHistory", streakHistory);
            request.getRequestDispatcher("streaks.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load streaks.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}
