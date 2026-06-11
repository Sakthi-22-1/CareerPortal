<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="Smart Career Assessment Portal — Assess your skills, discover your strengths, and build your career with interactive quizzes." />
  <title>Smart Career Assessment Portal</title>
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
      <li><a href="index.jsp" class="active">Home</a></li>
      <li><a href="login.jsp">Login</a></li>
      <li><a href="register.jsp">Register</a></li>
      <li><a href="leaderboard.jsp">Leaderboard</a></li>
    </ul>
  </nav>

  <!-- Hero Section -->
  <section class="hero">
    <div class="hero-content animate-fade">
      <h1>Smart Career Assessment Portal</h1>
      <p>Assess your skills. Discover your strengths. Build your career.</p>
      <div class="hero-actions">
        <a href="register.jsp" class="btn btn-white btn-lg">🚀 Get Started</a>
        <a href="login.jsp" class="btn btn-ghost btn-lg">🔑 Login</a>
      </div>
    </div>
  </section>

  <!-- Features Section -->
  <section class="features container">
    <h2 class="section-title">Why Choose Us?</h2>
    <p class="section-subtitle">Everything you need to assess and grow your career skills</p>

    <div class="grid-4">
      <div class="card feature-card animate-on-scroll">
        <span class="feature-icon">📚</span>
        <h3>Quiz Categories</h3>
        <p>Multiple categories including Java, Aptitude, HTML/CSS, SQL, and Communication Skills.</p>
      </div>
      <div class="card feature-card animate-on-scroll">
        <span class="feature-icon">⚡</span>
        <h3>Instant Results</h3>
        <p>Get your scores immediately after completing a quiz with detailed performance breakdown.</p>
      </div>
      <div class="card feature-card animate-on-scroll">
        <span class="feature-icon">📊</span>
        <h3>Weak Area Analysis</h3>
        <p>Identify your weak topics and receive personalized recommendations for improvement.</p>
      </div>
      <div class="card feature-card animate-on-scroll">
        <span class="feature-icon">🏆</span>
        <h3>Leaderboard</h3>
        <p>Compete with peers and track your ranking on the global leaderboard.</p>
      </div>
    </div>
  </section>

  <!-- CTA Section -->
  <section class="container text-center" style="padding-bottom: 60px;">
    <div class="card-static" style="padding: 48px; background: linear-gradient(135deg, var(--primary-light), #ffffff);">
      <h2 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 12px;">Ready to Discover Your Strengths?</h2>
      <p style="color: var(--text-light); margin-bottom: 28px;">Join thousands of students who are building their careers with smart assessments.</p>
      <div class="hero-actions">
        <a href="register.jsp" class="btn btn-primary btn-lg">Create Free Account</a>
        <a href="leaderboard.jsp" class="btn btn-outline btn-lg">View Leaderboard</a>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="footer">
    <p>&copy; 2026 Smart Career Assessment Portal. All rights reserved.</p>
  </footer>

  <script src="js/script.js"></script>
</body>
</html>
