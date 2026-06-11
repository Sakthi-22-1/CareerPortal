<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String userName = (String) session.getAttribute("userName");
  boolean loggedIn = (session.getAttribute("userId") != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="Contact Support — Smart Career Assessment Portal." />
  <title>Contact Support — Career Portal</title>
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
      <% if (loggedIn) { %>
        <li><a href="dashboard">Dashboard</a></li>
        <li><a href="history">History</a></li>
        <li><a href="weakarea">Weak Areas</a></li>
        <li><a href="leaderboard">Leaderboard</a></li>
        <li><a href="contact.jsp" class="active">Contact</a></li>
        <li><a href="logout" class="btn-nav-logout">Logout</a></li>
      <% } else { %>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="login.jsp">Login</a></li>
        <li><a href="register.jsp">Register</a></li>
        <li><a href="contact.jsp" class="active">Contact</a></li>
      <% } %>
    </ul>
  </nav>

  <div class="container">
    <div class="page-header animate-fade">
      <h1>📞 Contact Support</h1>
      <p>Need help? Reach out to our support team</p>
    </div>

    <div class="grid-3 animate-slide">
      <!-- Phone Support -->
      <div class="card contact-card">
        <span class="contact-icon">📞</span>
        <h3>Call Support</h3>
        <p>Speak directly with our support team for immediate assistance.</p>
        <p class="contact-detail">+1 (234) 567-890</p>
        <a href="tel:+1234567890" class="btn btn-primary btn-block" id="callSupportBtn">📱 Call Now</a>
      </div>

      <!-- Email Support -->
      <div class="card contact-card">
        <span class="contact-icon">✉️</span>
        <h3>Email Support</h3>
        <p>Send us an email and we'll get back to you within 24 hours.</p>
        <p class="contact-detail">support@careerportal.com</p>
        <a href="mailto:support@careerportal.com?subject=Support Request" class="btn btn-success btn-block" id="emailSupportBtn">📧 Send Email</a>
      </div>

      <!-- Office Address -->
      <div class="card contact-card">
        <span class="contact-icon">📍</span>
        <h3>Visit Us</h3>
        <p>Come visit our office during business hours.</p>
        <p class="contact-detail">123 Career Lane, Tech City</p>
        <span class="btn btn-outline btn-block">🕐 Mon-Fri, 9AM - 6PM</span>
      </div>
    </div>

    <!-- FAQ Section -->
    <div class="card-static animate-slide" style="margin-top: 30px;">
      <h3>❓ Frequently Asked Questions</h3>
      <div class="faq-list">
        <div class="faq-item">
          <h4>How do I reset my password?</h4>
          <p>Contact our support team via email or phone and we'll help you reset your password.</p>
        </div>
        <div class="faq-item">
          <h4>How many times can I attempt a quiz?</h4>
          <p>You can attempt each quiz as many times as you like. All attempts are saved in your history.</p>
        </div>
        <div class="faq-item">
          <h4>What is the passing score?</h4>
          <p>The passing score is 40%. Score above 40% to pass the quiz.</p>
        </div>
        <div class="faq-item">
          <h4>How is the leaderboard calculated?</h4>
          <p>The leaderboard shows the top 10 highest scores across all users and categories.</p>
        </div>
      </div>
    </div>

    <div class="page-actions">
      <% if (loggedIn) { %>
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
