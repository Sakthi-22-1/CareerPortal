<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.career.model.*" %>
<%
  // Admin session protection
  if (session.getAttribute("adminId") == null) {
      response.sendRedirect("admin-login.jsp");
      return;
  }
  String adminUser = (String) session.getAttribute("adminUsername");

  @SuppressWarnings("unchecked")
  List<Question> questions = (List<Question>) request.getAttribute("questions");
  if (questions == null) questions = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard — Career Portal</title>
  <link rel="stylesheet" href="css/style.css" />
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar navbar-admin">
    <div class="navbar-logo">
      <span>⚙️</span> Admin Panel
    </div>
    <ul class="navbar-links">
      <li><a href="adminDashboard" class="active">Dashboard</a></li>
      <li><span style="color: #ccc;">Welcome, <%= adminUser %></span></li>
      <li><a href="logout" class="btn-nav-logout">Logout</a></li>
    </ul>
  </nav>

  <div class="container">
    <div class="page-header animate-fade">
      <h1>⚙️ Admin Dashboard</h1>
      <p>Manage quiz questions — Add, Update, and Delete</p>
    </div>

    <!-- Add / Update Question Form -->
    <div class="card-static admin-form-card animate-slide" id="questionFormCard">
      <h3 id="formTitle">➕ Add New Question</h3>

      <form id="addQuestionForm" action="addQuestion" method="POST" data-validate="true">
        <div class="grid-2">
          <div class="form-group">
            <label for="category">Category</label>
            <select id="category" name="category" required>
              <option value="">-- Select Category --</option>
              <option value="Java">Java</option>
              <option value="Aptitude">Aptitude</option>
              <option value="HTML/CSS">HTML/CSS</option>
              <option value="SQL">SQL</option>
              <option value="Communication Skills">Communication Skills</option>
            </select>
          </div>
          <div class="form-group">
            <label for="topic">Topic (for Weak Area Analysis)</label>
            <input type="text" id="topic" name="topic" placeholder="e.g., OOP Concepts" required />
          </div>
        </div>

        <div class="form-group">
          <label for="questionText">Question Text</label>
          <textarea id="questionText" name="questionText" rows="3" placeholder="Enter the question..." required></textarea>
        </div>

        <div class="grid-2">
          <div class="form-group">
            <label for="optionA">Option A</label>
            <input type="text" id="optionA" name="optionA" placeholder="Option A" required />
          </div>
          <div class="form-group">
            <label for="optionB">Option B</label>
            <input type="text" id="optionB" name="optionB" placeholder="Option B" required />
          </div>
          <div class="form-group">
            <label for="optionC">Option C</label>
            <input type="text" id="optionC" name="optionC" placeholder="Option C" required />
          </div>
          <div class="form-group">
            <label for="optionD">Option D</label>
            <input type="text" id="optionD" name="optionD" placeholder="Option D" required />
          </div>
        </div>

        <div class="form-group" style="max-width: 200px;">
          <label for="correctOption">Correct Answer</label>
          <select id="correctOption" name="correctOption" required>
            <option value="">-- Select --</option>
            <option value="A">A</option>
            <option value="B">B</option>
            <option value="C">C</option>
            <option value="D">D</option>
          </select>
        </div>

        <button type="submit" class="btn btn-success btn-lg" id="addBtn">➕ Add Question</button>
      </form>

      <!-- Hidden Update Form (shown when editing) -->
      <form id="updateQuestionForm" action="updateQuestion" method="POST" style="display:none;" data-validate="true">
        <input type="hidden" id="updateId" name="id" />
        <div class="grid-2">
          <div class="form-group">
            <label for="updateCategory">Category</label>
            <select id="updateCategory" name="category" required>
              <option value="Java">Java</option>
              <option value="Aptitude">Aptitude</option>
              <option value="HTML/CSS">HTML/CSS</option>
              <option value="SQL">SQL</option>
              <option value="Communication Skills">Communication Skills</option>
            </select>
          </div>
          <div class="form-group">
            <label for="updateTopic">Topic</label>
            <input type="text" id="updateTopic" name="topic" required />
          </div>
        </div>

        <div class="form-group">
          <label for="updateQuestionText">Question Text</label>
          <textarea id="updateQuestionText" name="questionText" rows="3" required></textarea>
        </div>

        <div class="grid-2">
          <div class="form-group">
            <label for="updateOptionA">Option A</label>
            <input type="text" id="updateOptionA" name="optionA" required />
          </div>
          <div class="form-group">
            <label for="updateOptionB">Option B</label>
            <input type="text" id="updateOptionB" name="optionB" required />
          </div>
          <div class="form-group">
            <label for="updateOptionC">Option C</label>
            <input type="text" id="updateOptionC" name="optionC" required />
          </div>
          <div class="form-group">
            <label for="updateOptionD">Option D</label>
            <input type="text" id="updateOptionD" name="optionD" required />
          </div>
        </div>

        <div class="form-group" style="max-width: 200px;">
          <label for="updateCorrectOption">Correct Answer</label>
          <select id="updateCorrectOption" name="correctOption" required>
            <option value="A">A</option>
            <option value="B">B</option>
            <option value="C">C</option>
            <option value="D">D</option>
          </select>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-warning btn-lg">✏️ Update Question</button>
          <button type="button" class="btn btn-outline" onclick="cancelEdit()">Cancel</button>
        </div>
      </form>
    </div>

    <!-- All Questions Table -->
    <div class="card-static animate-slide">
      <h3>📋 All Questions (<%= questions.size() %> total)</h3>

      <% if (questions.isEmpty()) { %>
        <div class="empty-state" style="padding: 30px;">
          <span class="empty-icon">📭</span>
          <p>No questions found. Add your first question above!</p>
        </div>
      <% } else { %>
        <div class="table-responsive">
          <table class="data-table admin-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Category</th>
                <th>Question</th>
                <th>A</th>
                <th>B</th>
                <th>C</th>
                <th>D</th>
                <th>Ans</th>
                <th>Topic</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <%
                for (Question q : questions) {
                    // Truncate long text for table display
                    String shortQ = q.getQuestionText();
                    if (shortQ.length() > 50) shortQ = shortQ.substring(0, 50) + "...";
                    String shortA = q.getOptionA().length() > 20 ? q.getOptionA().substring(0, 20) + ".." : q.getOptionA();
                    String shortB = q.getOptionB().length() > 20 ? q.getOptionB().substring(0, 20) + ".." : q.getOptionB();
                    String shortC = q.getOptionC().length() > 20 ? q.getOptionC().substring(0, 20) + ".." : q.getOptionC();
                    String shortD = q.getOptionD().length() > 20 ? q.getOptionD().substring(0, 20) + ".." : q.getOptionD();
              %>
              <tr>
                <td><%= q.getId() %></td>
                <td><%= q.getCategory() %></td>
                <td title="<%= q.getQuestionText() %>"><%= shortQ %></td>
                <td title="<%= q.getOptionA() %>"><%= shortA %></td>
                <td title="<%= q.getOptionB() %>"><%= shortB %></td>
                <td title="<%= q.getOptionC() %>"><%= shortC %></td>
                <td title="<%= q.getOptionD() %>"><%= shortD %></td>
                <td><strong><%= q.getCorrectOption() %></strong></td>
                <td><%= q.getTopic() %></td>
                <td class="action-cell">
                  <button class="btn btn-sm btn-warning" onclick="editQuestion(
                    '<%= q.getId() %>',
                    '<%= q.getCategory() %>',
                    '<%= q.getQuestionText().replace("'", "\\'").replace("\"", "&quot;") %>',
                    '<%= q.getOptionA().replace("'", "\\'").replace("\"", "&quot;") %>',
                    '<%= q.getOptionB().replace("'", "\\'").replace("\"", "&quot;") %>',
                    '<%= q.getOptionC().replace("'", "\\'").replace("\"", "&quot;") %>',
                    '<%= q.getOptionD().replace("'", "\\'").replace("\"", "&quot;") %>',
                    '<%= q.getCorrectOption() %>',
                    '<%= q.getTopic().replace("'", "\\'") %>'
                  )">✏️ Edit</button>
                  <a href="deleteQuestion?id=<%= q.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this question?')">🗑️ Delete</a>
                </td>
              </tr>
              <% } %>
            </tbody>
          </table>
        </div>
      <% } %>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer">
    <p>&copy; 2026 Smart Career Assessment Portal. Admin Panel.</p>
  </footer>

  <script src="js/script.js"></script>
  <script>
    // Edit question — populate the update form
    function editQuestion(id, category, questionText, optA, optB, optC, optD, correct, topic) {
      // Hide add form, show update form
      document.getElementById('addQuestionForm').style.display = 'none';
      document.getElementById('updateQuestionForm').style.display = 'block';
      document.getElementById('formTitle').textContent = '✏️ Update Question #' + id;

      // Populate fields
      document.getElementById('updateId').value = id;
      document.getElementById('updateCategory').value = category;
      document.getElementById('updateQuestionText').value = questionText;
      document.getElementById('updateOptionA').value = optA;
      document.getElementById('updateOptionB').value = optB;
      document.getElementById('updateOptionC').value = optC;
      document.getElementById('updateOptionD').value = optD;
      document.getElementById('updateCorrectOption').value = correct;
      document.getElementById('updateTopic').value = topic;

      // Scroll to form
      document.getElementById('questionFormCard').scrollIntoView({ behavior: 'smooth' });
    }

    // Cancel edit — go back to add form
    function cancelEdit() {
      document.getElementById('addQuestionForm').style.display = 'block';
      document.getElementById('updateQuestionForm').style.display = 'none';
      document.getElementById('formTitle').textContent = '➕ Add New Question';
    }
  </script>
</body>
</html>
