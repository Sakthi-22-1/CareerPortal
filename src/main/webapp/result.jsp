<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  // Session protection
  if (session.getAttribute("userId") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  // Get result data from SubmitQuizServlet
  Integer totalQuestions = (Integer) request.getAttribute("totalQuestions");
  Integer correctAnswers = (Integer) request.getAttribute("correctAnswers");
  Integer wrongAnswers = (Integer) request.getAttribute("wrongAnswers");
  Double scorePercentage = (Double) request.getAttribute("scorePercentage");
  String status = (String) request.getAttribute("status");
  String weakTopics = (String) request.getAttribute("weakTopics");
  String category = (String) request.getAttribute("category");
  Integer currentStreak = (Integer) request.getAttribute("currentStreak");
  Boolean streakIncreased = (Boolean) request.getAttribute("streakIncreased");

  if (totalQuestions == null) {
      response.sendRedirect("dashboard");
      return;
  }

  boolean passed = "PASS".equals(status);
  String scoreFormatted = String.format("%.1f", scorePercentage);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Result — Career Portal</title>
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
      <li><a href="history">History</a></li>
      <li><a href="streaks">Streaks</a></li>
      <li><a href="weakarea">Weak Areas</a></li>
      <li><a href="logout" class="btn-nav-logout">Logout</a></li>
    </ul>
  </nav>

  <div class="container">
    <div class="result-card animate-fade">

      <!-- Status Badge -->
      <div class="result-status-badge <%= passed ? "badge-pass" : "badge-fail" %>">
        <%= passed ? "🎉 PASSED" : "😞 FAILED" %>
      </div>

      <h1>Quiz Result: <%= category %></h1>

      <!-- Score Circle -->
      <div class="score-circle-wrapper">
        <div class="score-circle <%= passed ? "score-pass" : "score-fail" %>">
          <span class="score-value"><%= scoreFormatted %>%</span>
          <span class="score-label">Score</span>
        </div>
      </div>

      <!-- Streak Notification -->
      <% if (currentStreak != null) { %>
          <div class="streak-notification" style="margin: 20px 0; padding: 15px; border-radius: 12px; text-align: center; background: <%= (streakIncreased != null && streakIncreased) ? "linear-gradient(135deg, #ff9800, #ff5722)" : "#f5f5f5" %>; color: <%= (streakIncreased != null && streakIncreased) ? "white" : "#333" %>; box-shadow: 0 4px 10px rgba(0,0,0,0.1);">
            <% if (streakIncreased != null && streakIncreased) { %>
                <h2 style="margin: 0; font-size: 1.5rem;">🔥 Streak Increased!</h2>
                <p style="margin: 5px 0 0 0;">You are on a <strong><%= currentStreak %></strong> quiz streak!</p>
            <% } else { %>
                <h2 style="margin: 0; font-size: 1.2rem; color: #d32f2f;">🧊 Streak Lost</h2>
                <p style="margin: 5px 0 0 0;">You need at least 5 correct answers to maintain a streak. Try again!</p>
            <% } %>
          </div>
      <% } %>


      <!-- Stats Grid -->
      <div class="result-stats">
        <div class="stat-item">
          <span class="stat-icon">📋</span>
          <span class="stat-number"><%= totalQuestions %></span>
          <span class="stat-label">Total Questions</span>
        </div>
        <div class="stat-item stat-correct">
          <span class="stat-icon">✅</span>
          <span class="stat-number"><%= correctAnswers %></span>
          <span class="stat-label">Correct</span>
        </div>
        <div class="stat-item stat-wrong">
          <span class="stat-icon">❌</span>
          <span class="stat-number"><%= wrongAnswers %></span>
          <span class="stat-label">Wrong</span>
        </div>
      </div>

      <!-- Weak Topics -->
      <% if (weakTopics != null && !weakTopics.trim().isEmpty()) { %>
        <div class="weak-topics-section">
          <h3>📊 Areas to Improve</h3>
          <div class="weak-topic-tags">
            <%
              String[] topics = weakTopics.split(",");
              for (String topic : topics) {
                  topic = topic.trim();
                  if (!topic.isEmpty()) {
            %>
              <span class="weak-tag">⚠️ <%= topic %></span>
            <%
                  }
              }
            %>
          </div>
        </div>
      <% } %>

      <!-- Action Buttons -->
      <div class="result-actions">
        <a href="dashboard" class="btn btn-primary">🏠 Back to Dashboard</a>
        <a href="quiz?category=<%= category %>" class="btn btn-warning">🔄 Try Again</a>
        <a href="history" class="btn btn-outline">📜 View History</a>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer">
    <p>&copy; 2026 Smart Career Assessment Portal. All rights reserved.</p>
  </footer>

  <script src="js/script.js"></script>
</body>
</html>
