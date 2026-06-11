<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  // Session protection — redirect to login if not logged in
  if (session.getAttribute("userId") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  String userName = (String) session.getAttribute("userName");
  int userStreak = 0;
  if (session.getAttribute("userStreak") != null) {
      userStreak = (int) session.getAttribute("userStreak");
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="Dashboard — Choose a quiz category to start." />
  <title>Dashboard — Career Portal</title>
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
      <li><a href="dashboard" class="active">Dashboard</a></li>
      <li><a href="history">History</a></li>
      <li><a href="streaks">Streaks</a></li>
      <li><a href="weakarea">Weak Areas</a></li>
      <li><a href="leaderboard">Leaderboard</a></li>
      <li><a href="contact.jsp">Contact</a></li>
      <li><a href="logout" class="btn-nav-logout">Logout</a></li>
    </ul>
  </nav>

  <div class="container">
    <!-- Welcome Section -->
    <div class="welcome-section animate-fade">
      <h1>Welcome, <%= userName %>! 👋
        <% if (userStreak > 0) { %>
            <span style="font-size: 0.6em; background: linear-gradient(135deg, #ff9800, #ff5722); color: white; padding: 6px 16px; border-radius: 20px; vertical-align: middle; margin-left: 15px; box-shadow: 0 4px 8px rgba(255, 87, 34, 0.3);">
              🔥 <%= userStreak %> Streak
            </span>
        <% } %>
      </h1>
      <p>Choose a quiz category below to test your skills. Each quiz has 10 questions with a 10-minute timer.</p>
    </div>

    <!-- Quiz Categories Grid -->
    <div class="grid-3 animate-slide">

      <!-- Java Card -->
      <div class="card category-card">
        <div class="category-accent" style="background: linear-gradient(135deg, #e65100, #f57c00);"></div>
        <span class="category-icon">☕</span>
        <h3>Java</h3>
        <p>Test your knowledge of Java programming — OOP, collections, exceptions, multithreading & more.</p>
        <a href="quiz?category=Java" class="btn btn-primary btn-block">🚀 Start Quiz</a>
      </div>

      <!-- Aptitude Card -->
      <div class="card category-card">
        <div class="category-accent" style="background: linear-gradient(135deg, #1565c0, #42a5f5);"></div>
        <span class="category-icon">🧮</span>
        <h3>Aptitude</h3>
        <p>Sharpen your logical reasoning and quantitative aptitude with number series, percentages & puzzles.</p>
        <a href="quiz?category=Aptitude" class="btn btn-primary btn-block">🚀 Start Quiz</a>
      </div>

      <!-- HTML/CSS Card -->
      <div class="card category-card">
        <div class="category-accent" style="background: linear-gradient(135deg, #2e7d32, #66bb6a);"></div>
        <span class="category-icon">🌐</span>
        <h3>HTML/CSS</h3>
        <p>Test your web development skills — HTML elements, CSS styling, layouts, flexbox & responsive design.</p>
        <a href="quiz?category=HTML/CSS" class="btn btn-primary btn-block">🚀 Start Quiz</a>
      </div>

      <!-- SQL Card -->
      <div class="card category-card">
        <div class="category-accent" style="background: linear-gradient(135deg, #6a1b9a, #ab47bc);"></div>
        <span class="category-icon">🗄️</span>
        <h3>SQL</h3>
        <p>Master your database querying skills — SELECT, JOIN, GROUP BY, subqueries & normalization.</p>
        <a href="quiz?category=SQL" class="btn btn-primary btn-block">🚀 Start Quiz</a>
      </div>

      <!-- Communication Skills Card -->
      <div class="card category-card">
        <div class="category-accent" style="background: linear-gradient(135deg, #00838f, #26c6da);"></div>
        <span class="category-icon">💬</span>
        <h3>Communication Skills</h3>
        <p>Assess your verbal and written communication — grammar, vocabulary, business writing & etiquette.</p>
        <a href="quiz?category=Communication Skills" class="btn btn-primary btn-block">🚀 Start Quiz</a>
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
