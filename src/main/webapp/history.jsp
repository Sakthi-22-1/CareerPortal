<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.career.model.*" %>
<%
  // Session protection
  if (session.getAttribute("userId") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  String userName = (String) session.getAttribute("userName");
  List<Result> results = (List<Result>) request.getAttribute("results");
  if (results == null) results = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Quiz History — Career Portal</title>
  <link rel="stylesheet" href="css/style.css" />
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar">
    <div class="navbar-logo">
      <span>🎯</span> Career Portal
    </div>
    <button class="hamburger" aria-label="Toggle navigation">
      <span></span><span></span><span></span>
    </button>
    <ul class="navbar-links">
      <li><a href="dashboard">Dashboard</a></li>
      <li><a href="history" class="active">History</a></li>
      <li><a href="streaks">Streaks</a></li>
      <li><a href="weakarea">Weak Areas</a></li>
      <li><a href="leaderboard">Leaderboard</a></li>
      <li><a href="contact.jsp">Contact</a></li>
      <li><a href="logout" class="btn-nav-logout">Logout</a></li>
    </ul>
  </nav>

  <div class="container">
    <div class="page-header animate-fade">
      <h1>📜 Quiz History</h1>
      <p>View all your previous quiz attempts, <%= userName %></p>
    </div>

    <% if (results.isEmpty()) { %>
      <div class="card-static empty-state animate-slide">
        <span class="empty-icon">📭</span>
        <h3>No Quiz Attempts Yet</h3>
        <p>You haven't taken any quizzes yet. Start one from the dashboard!</p>
        <a href="dashboard" class="btn btn-primary">🚀 Go to Dashboard</a>
      </div>
    <% } else { %>
      <div class="card-static animate-slide">
        <div class="table-responsive">
          <table class="data-table">
            <thead>
              <tr>
                <th>#</th>
                <th>Category</th>
                <th>Total</th>
                <th>Correct</th>
                <th>Wrong</th>
                <th>Score %</th>
                <th>Status</th>
                <th>Date</th>
              </tr>
            </thead>
            <tbody>
              <%
                int count = 0;
                for (Result r : results) {
                    count++;
                    boolean passed = "PASS".equals(r.getStatus());
              %>
              <tr>
                <td><strong><%= count %></strong></td>
                <td><%= r.getCategory() %></td>
                <td><%= r.getTotalQuestions() %></td>
                <td class="text-success"><%= r.getCorrectAnswers() %></td>
                <td class="text-danger"><%= r.getWrongAnswers() %></td>
                <td><strong><%= String.format("%.1f", r.getScorePercentage()) %>%</strong></td>
                <td>
                  <span class="status-badge <%= passed ? "status-pass" : "status-fail" %>">
                    <%= r.getStatus() %>
                  </span>
                </td>
                <td><%= r.getAttemptedAt() != null ? r.getAttemptedAt().toString().substring(0, 16) : "N/A" %></td>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>
      </div>
    <% } %>

    <div class="page-actions">
      <a href="dashboard" class="btn btn-outline">← Back to Dashboard</a>
      <a href="weakarea" class="btn btn-primary">📊 View Weak Areas</a>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer">
    <p>&copy; 2026 Smart Career Assessment Portal. All rights reserved.</p>
  </footer>

  <script src="js/script.js"></script>
</body>
</html>
