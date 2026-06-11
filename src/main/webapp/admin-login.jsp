<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Login — Career Portal</title>
  <link rel="stylesheet" href="css/style.css" />
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar">
    <div class="navbar-logo">
      <span>🎯</span> Career Portal
    </div>
    <ul class="navbar-links">
      <li><a href="index.jsp">Home</a></li>
      <li><a href="login.jsp">User Login</a></li>
    </ul>
  </nav>

  <div class="container">
    <div class="card-static auth-card animate-slide">
      <span class="auth-icon">🔐</span>
      <h2>Admin Login</h2>
      <p class="auth-subtitle">Access the admin dashboard to manage questions</p>

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">⚠️ <%= request.getAttribute("error") %></div>
      <% } %>

      <form action="adminLogin" method="POST" data-validate="true" id="adminLoginForm">
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" name="username" placeholder="Enter admin username" required />
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="Enter admin password" required />
        </div>
        <button type="submit" class="btn btn-primary btn-block btn-lg">🔓 Admin Login</button>
      </form>

      <div class="auth-footer">
        <a href="login.jsp">← Back to User Login</a>
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
