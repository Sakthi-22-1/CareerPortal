<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.career.model.*" %>
<%
  // Session protection
  if (session.getAttribute("userId") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  // Get questions and category from QuizServlet
  List<Question> questions = (List<Question>) request.getAttribute("questions");
  String category = (String) request.getAttribute("category");
  if (questions == null || questions.isEmpty()) {
      response.sendRedirect("dashboard");
      return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Quiz: <%= category %> — Career Portal</title>
  <link rel="stylesheet" href="css/style.css" />
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar">
    <div class="navbar-logo">
      <span>🎯</span> Career Portal
    </div>
    <ul class="navbar-links">
      <li><a href="dashboard">Dashboard</a></li>
      <li><a href="logout" class="btn-nav-logout">Logout</a></li>
    </ul>
  </nav>

  <!-- Timer Bar -->
  <div class="timer-bar" id="timerBar">
    <span>⏱️ Time Remaining: <strong id="timerDisplay">10:00</strong></span>
  </div>

  <div class="container">
    <div class="quiz-header animate-fade">
      <h1>📝 <%= category %> Quiz</h1>
      <p><%= questions.size() %> Questions • 10 Minutes • Choose the best answer</p>
    </div>

    <form action="submitQuiz" method="POST" id="quizForm">
      <input type="hidden" name="category" value="<%= category %>" />

      <%
        int qNum = 0;
        for (Question q : questions) {
            qNum++;
      %>
        <div class="card quiz-question animate-slide" id="question-<%= qNum %>">
          <div class="question-number">Question <%= qNum %> of <%= questions.size() %></div>
          <h3 class="question-text"><%= q.getQuestionText() %></h3>

          <div class="quiz-options">
            <label class="quiz-option" id="opt-<%= q.getId() %>-A">
              <input type="radio" name="answer_<%= qNum %>" value="A" />
              <span class="option-marker">A</span>
              <span class="option-text"><%= q.getOptionA() %></span>
            </label>
            <label class="quiz-option" id="opt-<%= q.getId() %>-B">
              <input type="radio" name="answer_<%= qNum %>" value="B" />
              <span class="option-marker">B</span>
              <span class="option-text"><%= q.getOptionB() %></span>
            </label>
            <label class="quiz-option" id="opt-<%= q.getId() %>-C">
              <input type="radio" name="answer_<%= qNum %>" value="C" />
              <span class="option-marker">C</span>
              <span class="option-text"><%= q.getOptionC() %></span>
            </label>
            <label class="quiz-option" id="opt-<%= q.getId() %>-D">
              <input type="radio" name="answer_<%= qNum %>" value="D" />
              <span class="option-marker">D</span>
              <span class="option-text"><%= q.getOptionD() %></span>
            </label>
          </div>
        </div>
      <% } %>

      <div class="quiz-submit-section">
        <button type="submit" class="btn btn-primary btn-lg" id="submitQuizBtn">📩 Submit Quiz</button>
        <p class="quiz-submit-note">Make sure you've answered all questions before submitting.</p>
      </div>
    </form>
  </div>

  <!-- Footer -->
  <footer class="footer">
    <p>&copy; 2026 Smart Career Assessment Portal. All rights reserved.</p>
  </footer>

  <script src="js/script.js"></script>
  <script>
    // Start the quiz timer (10 minutes)
    if (typeof startQuizTimer === 'function') {
      startQuizTimer(10, 'timerDisplay', 'quizForm');
    }
  </script>
</body>
</html>
