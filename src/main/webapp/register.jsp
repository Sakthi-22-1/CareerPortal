<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="Create your account on Smart Career Assessment Portal." />
  <title>Register — Career Portal</title>
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
      <li><a href="index.jsp">Home</a></li>
      <li><a href="login.jsp">Login</a></li>
      <li><a href="register.jsp" class="active">Register</a></li>
    </ul>
  </nav>

  <div class="container">
    <div class="card-static auth-card animate-slide">
      <span class="auth-icon">📝</span>
      <h2>Create Account</h2>
      <p class="auth-subtitle">Join the portal and start assessing your skills</p>

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">⚠️ <%= request.getAttribute("error") %></div>
      <% } %>
      <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">✅ <%= request.getAttribute("success") %></div>
      <% } %>

      <form action="register" method="POST" data-validate="true" id="registerForm">
        <div class="form-group">
          <label for="name">Full Name</label>
          <input type="text" id="name" name="name" placeholder="Enter your full name" required />
        </div>
        <div class="form-group">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email" placeholder="Enter your email" required />
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="Create a password" required />
        </div>
        <button type="submit" class="btn btn-primary btn-block btn-lg">🚀 Register</button>
      </form>

      <div class="auth-footer">
        Already have an account? <a href="login.jsp">Login here</a>
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
