package com.career.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.QuestionDAO;
import com.career.dao.ResultDAO;
import com.career.model.Question;
import com.career.model.Result;
import com.career.model.User;
import com.career.model.StreakHistory;
import com.career.dao.UserDAO;
import com.career.dao.StreakDAO;

/**
 * SubmitQuizServlet - Processes quiz answers and calculates the score.
 * URL: /submitQuiz (POST)
 * 
 * Compares user's answers with correct answers from the database,
 * calculates score percentage, determines pass/fail status,
 * identifies weak topics, saves the result, and forwards to result.jsp.
 */
@WebServlet("/submitQuiz")
public class SubmitQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Check if the user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Step 2: Get userId from session and category from form
            int userId = (int) session.getAttribute("userId");
            String category = request.getParameter("category");

            // Step 3: Get all questions for this category to know total count
            List<Question> questions = QuestionDAO.getQuestionsByCategory(category);
            int totalQuestions = questions.size();

            // Step 4: Initialize counters
            int correctAnswers = 0;
            int wrongAnswers = 0;

            // Use a LinkedHashSet to maintain insertion order and avoid duplicate topics
            Set<String> weakTopicSet = new LinkedHashSet<>();

            // Step 5: Loop through each question and compare answers
            for (int i = 1; i <= totalQuestions; i++) {
                // Get the user's selected answer for this question (e.g., answer_1, answer_2, ...)
                String userAnswer = request.getParameter("answer_" + i);

                // Get the actual question from the database by its ID
                Question question = questions.get(i - 1);
                Question dbQuestion = QuestionDAO.getQuestionById(question.getId());

                if (dbQuestion != null) {
                    // Compare user's answer with the correct option
                    if (userAnswer != null && userAnswer.equals(dbQuestion.getCorrectOption())) {
                        correctAnswers++;
                    } else {
                        wrongAnswers++;
                        // Add the topic of the wrong answer to weak topics
                        if (dbQuestion.getTopic() != null && !dbQuestion.getTopic().trim().isEmpty()) {
                            weakTopicSet.add(dbQuestion.getTopic().trim());
                        }
                    }
                }
            }

            // Step 6: Calculate score percentage
            double scorePercentage = 0;
            if (totalQuestions > 0) {
                scorePercentage = ((double) correctAnswers / totalQuestions) * 100;
            }

            // Step 7: Determine pass or fail status (40% is passing threshold)
            String status = scorePercentage >= 40 ? "PASS" : "FAIL";

            // Step 8: Build weak topics as a comma-separated string
            String weakTopics = String.join(", ", weakTopicSet);

            // Step 8.5: Handle Streak logic
            User currentUser = UserDAO.getUserById(userId);
            int currentStreak = (currentUser != null) ? currentUser.getStreak() : 0;
            boolean streakIncreased = false;

            // Minimum count to earn a streak is 5 correct answers
            if (correctAnswers >= 5) {
                currentStreak++;
                streakIncreased = true;
            } else {
                currentStreak = 0; // Reset streak if failed to get min score
            }
            
            // Save streak to DB and Session
            UserDAO.updateStreak(userId, currentStreak);
            session.setAttribute("userStreak", currentStreak);

            // Insert Streak History Record
            java.sql.Date sqlDate = new java.sql.Date(System.currentTimeMillis());
            StreakHistory history = new StreakHistory(userId, sqlDate, currentStreak, streakIncreased ? "INCREASED" : "LOST");
            StreakDAO.addStreakRecord(history);

            // Step 9: Save the result to the database
            Result result = new Result();
            result.setUserId(userId);
            result.setCategory(category);
            result.setTotalQuestions(totalQuestions);
            result.setCorrectAnswers(correctAnswers);
            result.setWrongAnswers(wrongAnswers);
            result.setScorePercentage(scorePercentage);
            result.setStatus(status);
            result.setWeakTopics(weakTopics);

            ResultDAO.saveResult(result);

            // Step 10: Set attributes for the result page
            request.setAttribute("totalQuestions", totalQuestions);
            request.setAttribute("correctAnswers", correctAnswers);
            request.setAttribute("wrongAnswers", wrongAnswers);
            request.setAttribute("scorePercentage", scorePercentage);
            request.setAttribute("status", status);
            request.setAttribute("weakTopics", weakTopics);
            request.setAttribute("category", category);
            request.setAttribute("currentStreak", currentStreak);
            request.setAttribute("streakIncreased", streakIncreased);

            // Step 11: Forward to result page
            request.getRequestDispatcher("result.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any database or unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "Failed to submit quiz. Please try again.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}
