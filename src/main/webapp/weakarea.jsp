<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.career.model.*" %>
<%
  // Session protection
  if (session.getAttribute("userId") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  String userName = (String) session.getAttribute("userName");

  // Get weak areas map from WeakAreaServlet
  @SuppressWarnings("unchecked")
  Map<String, Integer> weakAreas = (Map<String, Integer>) request.getAttribute("weakAreas");
  if (weakAreas == null) weakAreas = new LinkedHashMap<>();

  // Find max frequency for severity scaling
  int maxFreq = 0;
  for (int v : weakAreas.values()) {
      if (v > maxFreq) maxFreq = v;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Weak Area Analysis — Career Portal</title>
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
      <li><a href="history">History</a></li>
      <li><a href="streaks">Streaks</a></li>
      <li><a href="weakarea" class="active">Weak Areas</a></li>
      <li><a href="leaderboard">Leaderboard</a></li>
      <li><a href="contact.jsp">Contact</a></li>
      <li><a href="logout" class="btn-nav-logout">Logout</a></li>
    </ul>
  </nav>

  <div class="container">
    <div class="page-header animate-fade">
      <h1>📊 Weak Area Analysis</h1>
      <p>Based on your quiz attempts, here are the topics you need to improve, <%= userName %></p>
    </div>

    <% if (weakAreas.isEmpty()) { %>
      <div class="card-static empty-state animate-slide">
        <span class="empty-icon">🎉</span>
        <h3>No Weak Areas Found</h3>
        <p>Either you haven't taken any quizzes yet, or you got everything right! Keep it up!</p>
        <a href="dashboard" class="btn btn-primary">🚀 Take a Quiz</a>
      </div>
    <% } else { %>
      <div class="grid-2 animate-slide">
        <%
          for (Map.Entry<String, Integer> entry : weakAreas.entrySet()) {
              String topic = entry.getKey();
              int frequency = entry.getValue();

              // Severity level: high (>= 3), medium (2), low (1)
              String severityClass = "severity-low";
              String severityLabel = "Low";
              String severityIcon = "🟡";
              if (frequency >= 3) {
                  severityClass = "severity-high";
                  severityLabel = "High";
                  severityIcon = "🔴";
              } else if (frequency >= 2) {
                  severityClass = "severity-medium";
                  severityLabel = "Medium";
                  severityIcon = "🟠";
              }
        %>
          <div class="card weak-area-card <%= severityClass %>">
            <div class="weak-area-header">
              <span class="severity-badge"><%= severityIcon %> <%= severityLabel %> Priority</span>
              <span class="frequency-count">Appeared <%= frequency %> time(s)</span>
            </div>
            <h3><%= topic %></h3>
            <p class="improvement-msg">💡 You need to improve your <strong><%= topic %></strong> concepts. Practice more questions in this area.</p>
            <div class="progress-bar-container">
              <div class="progress-bar <%= severityClass %>" style="width: <%= maxFreq > 0 ? (frequency * 100 / maxFreq) : 0 %>%"></div>
            </div>
          </div>
        <% } %>
      </div>

      <div class="card-static improvement-tips animate-slide">
        <h3>💪 How to Improve</h3>
        <ul class="tips-list">
          <li>🔁 <strong>Practice Regularly</strong> — Take quizzes in your weak categories frequently.</li>
          <li>📖 <strong>Study Concepts</strong> — Review the theory behind each weak topic.</li>
          <li>📝 <strong>Take Notes</strong> — Write down key concepts and formulas.</li>
          <li>👥 <strong>Discuss with Peers</strong> — Teaching others helps solidify knowledge.</li>
        </ul>
      </div>
    <% } %>

    <div class="page-actions">
      <a href="dashboard" class="btn btn-outline">← Back to Dashboard</a>
      <a href="history" class="btn btn-primary">📜 View History</a>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer">
    <p>&copy; 2026 Smart Career Assessment Portal. All rights reserved.</p>
  </footer>

  <script src="js/script.js"></script>
</body>
</html>
