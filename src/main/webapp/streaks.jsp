<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.career.model.StreakHistory" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
  // Session protection
  if (session.getAttribute("userId") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  
  List<StreakHistory> streakHistory = (List<StreakHistory>) request.getAttribute("streakHistory");
  SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy"); // e.g., 11 June 2026
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Streak History — Career Portal</title>
  <link rel="stylesheet" href="css/style.css" />
  <style>
    .streak-container {
      max-width: 800px;
      margin: 40px auto;
      padding: 0 20px;
    }
    .streak-header {
      text-align: center;
      margin-bottom: 30px;
    }
    .streak-card {
      background: white;
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 15px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 4px 6px rgba(0,0,0,0.05);
      border-left: 6px solid #ccc;
      transition: transform 0.2s;
    }
    .streak-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 12px rgba(0,0,0,0.1);
    }
    .streak-increased {
      border-left-color: #ff9800;
    }
    .streak-lost {
      border-left-color: #f44336;
    }
    .streak-date {
      font-size: 1.1rem;
      font-weight: 600;
      color: #333;
    }
    .streak-info {
      display: flex;
      flex-direction: column;
    }
    .streak-count-badge {
      font-size: 1.2rem;
      font-weight: bold;
      padding: 5px 15px;
      border-radius: 20px;
      background: #fff3e0;
      color: #e65100;
    }
    .streak-count-lost {
      background: #ffebee;
      color: #c62828;
    }
    .empty-state {
      text-align: center;
      padding: 50px;
      background: white;
      border-radius: 12px;
      color: #666;
    }
  </style>
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
      <li><a href="streaks" class="active">Streaks</a></li>
      <li><a href="weakarea">Weak Areas</a></li>
      <li><a href="leaderboard">Leaderboard</a></li>
      <li><a href="logout" class="btn-nav-logout">Logout</a></li>
    </ul>
  </nav>

  <div class="streak-container animate-fade">
    <div class="streak-header">
      <h1>🔥 Your Streak History</h1>
      <p>View your streak progress Date, Month, and Year wise.</p>
    </div>

    <% if (streakHistory == null || streakHistory.isEmpty()) { %>
      <div class="empty-state">
        <h2>No Streaks Yet!</h2>
        <p>Start taking quizzes to build your streak. You need at least 5 correct answers to earn a streak point.</p>
        <br>
        <a href="dashboard" class="btn btn-primary">Take a Quiz</a>
      </div>
    <% } else { %>
      
      <% for (StreakHistory record : streakHistory) { 
           boolean isIncreased = "INCREASED".equals(record.getActionType());
           String formattedDate = dateFormat.format(record.getStreakDate());
      %>
        <div class="streak-card <%= isIncreased ? "streak-increased" : "streak-lost" %>">
          <div class="streak-info">
            <span class="streak-date">📅 <%= formattedDate %></span>
            <span style="color: #666; font-size: 0.9rem; margin-top: 5px;">
              <%= isIncreased ? "Quiz Passed - Streak Maintained!" : "Quiz Failed - Streak Broken" %>
            </span>
          </div>
          <div>
            <span class="streak-count-badge <%= !isIncreased ? "streak-count-lost" : "" %>">
              <%= isIncreased ? "🔥 " + record.getStreakCount() + " Streak" : "🧊 Lost" %>
            </span>
          </div>
        </div>
      <% } %>

    <% } %>
  </div>

  <footer class="footer" style="margin-top: auto;">
    <p>&copy; 2026 Smart Career Assessment Portal. All rights reserved.</p>
  </footer>

</body>
</html>
