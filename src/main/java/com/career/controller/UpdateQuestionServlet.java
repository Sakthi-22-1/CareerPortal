package com.career.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.career.dao.QuestionDAO;
import com.career.model.Question;

/**
 * UpdateQuestionServlet - Handles updating an existing question.
 * URL: /updateQuestion (POST)
 * 
 * Retrieves all question fields (including the question ID) from the form,
 * creates an updated Question object, and saves it via QuestionDAO.
 */
@WebServlet("/updateQuestion")
public class UpdateQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1: Check if the admin is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        try {
            // Step 2: Retrieve all question fields from the form (including id)
            int id = Integer.parseInt(request.getParameter("id"));
            String category = request.getParameter("category");
            String questionText = request.getParameter("questionText");
            String optionA = request.getParameter("optionA");
            String optionB = request.getParameter("optionB");
            String optionC = request.getParameter("optionC");
            String optionD = request.getParameter("optionD");
            String correctOption = request.getParameter("correctOption");
            String topic = request.getParameter("topic");

            // Step 3: Create a Question object and set all fields
            Question question = new Question();
            question.setId(id);
            question.setCategory(category);
            question.setQuestionText(questionText);
            question.setOptionA(optionA);
            question.setOptionB(optionB);
            question.setOptionC(optionC);
            question.setOptionD(optionD);
            question.setCorrectOption(correctOption);
            question.setTopic(topic);

            // Step 4: Update the question in the database
            QuestionDAO.updateQuestion(question);

            // Step 5: Redirect back to the admin dashboard
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
