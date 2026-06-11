<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.career.model.*" %>
<%
  // Leaderboard is public — no session check needed
  @SuppressWarnings("unchecked")
  List<Result> leaderboard = (List<Result>) request.getAttribute("leaderboard");
  if (leaderboard == null) leaderboard = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="Leaderboard — See the top scorers on Smart Career Assessment Portal." />
  <title>Leaderboard — Career Portal</title>
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
      <%
        // Show different nav depending on login state
        if (session.getAttribute("userId") != null) {
      %>
        <li><a href="dashboard">Dashboard</a></li>
        <li><a href="history">History</a></li>
      <li><a href="streaks">Streaks</a></li>
        <li><a href="weakarea">Weak Areas</a></li>
        <li><a href="leaderboard" class="active">Leaderboard</a></li>
        <li><a href="contact.jsp">Contact</a></li>
        <li><a href="logout" class="btn-nav-logout">Logout</a></li>
      <% } else { %>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="login.jsp">Login</a></li>
        <li><a href="register.jsp">Register</a></li>
        <li><a href="leaderboard" class="active">Leaderboard</a></li>
      <% } %>
    </ul>
  </nav>

  <div class="container">
    <div class="page-header animate-fade">
      <h1>🏆 Leaderboard</h1>
      <p>Top scoring students across all quiz categories</p>
    </div>

    <% if (leaderboard.isEmpty()) { %>
      <div class="card-static empty-state animate-slide">
        <span class="empty-icon">🏅</span>
        <h3>No Scores Yet</h3>
        <p>Be the first to take a quiz and get on the leaderboard!</p>
        <a href="register.jsp" class="btn btn-primary">🚀 Get Started</a>
      </div>
    <% } else { %>
      <div class="card-static animate-slide">
        <div class="table-responsive">
          <table class="data-table leaderboard-table">
            <thead>
              <tr>
                <th>Rank</th>
                <th>Name</th>
                <th>Category</th>
                <th>Score</th>
                <th>Percentage</th>
              </tr>
            </thead>
            <tbody>
              <%
                int rank = 0;
                for (Result r : leaderboard) {
                    rank++;
                    String medal = "";
                    String rowClass = "";
                    if (rank == 1) { medal = "🥇"; rowClass = "rank-gold"; }
                    else if (rank == 2) { medal = "🥈"; rowClass = "rank-silver"; }
                    else if (rank == 3) { medal = "🥉"; rowClass = "rank-bronze"; }
                    else { medal = String.valueOf(rank); }
              %>
              <tr class="<%= rowClass %>">
                <td class="rank-cell"><span class="rank-badge"><%= medal %></span></td>
                <td><strong><%= r.getUserName() != null ? r.getUserName() : "Unknown" %></strong></td>
                <td><%= r.getCategory() %></td>
                <td><%= r.getCorrectAnswers() %>/<%= r.getTotalQuestions() %></td>
                <td><strong><%= String.format("%.1f", r.getScorePercentage()) %>%</strong></td>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>
      </div>
    <% } %>

    <div class="page-actions">
      <%
        if (session.getAttribute("userId") != null) {
      %>
        <a href="dashboard" class="btn btn-outline">← Back to Dashboard</a>
      <% } else { %>
        <a href="index.jsp" class="btn btn-outline">← Back to Home</a>
      <% } %>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer">
    <p>&copy; 2026 Smart Career Assessment Portal. All rights reserved.</p>
  </footer>

  <script src="js/script.js"></script>
</body>
</html>
