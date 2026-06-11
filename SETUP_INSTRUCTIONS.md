# Smart Career Assessment Portal — Setup Instructions

## Prerequisites
- **JDK 8 or higher** (JDK 11 recommended)
- **Apache Tomcat 9** (download from https://tomcat.apache.org/download-90.cgi)
- **MySQL 8.0+** (download from https://dev.mysql.com/downloads/installer/)
- **MySQL Connector/J** (download from https://dev.mysql.com/downloads/connector/j/ — choose "Platform Independent" ZIP)
- **Eclipse IDE for Enterprise Java** or **IntelliJ IDEA Ultimate/Community**

---

## Step 1: Set Up the Database

1. Open **MySQL Command Line** or **MySQL Workbench**.
2. Run the database script:
   ```sql
   source d:/quiz project/database/schema.sql;
   ```
   Or copy-paste the contents of `database/schema.sql` into MySQL Workbench and execute.

3. Verify the tables were created:
   ```sql
   USE career_portal;
   SHOW TABLES;
   ```
   You should see: `admin`, `questions`, `results`, `users`

4. Verify sample data:
   ```sql
   SELECT COUNT(*) FROM questions;  -- Should be 50
   SELECT * FROM admin;              -- Should show admin/admin123
   ```

---

## Step 2: Configure Database Connection

Open `src/main/java/com/career/util/DBConnection.java` and update the credentials:

```java
private static final String URL = "jdbc:mysql://localhost:3306/career_portal";
private static final String USER = "root";          // ← Change if needed
private static final String PASSWORD = "";           // ← Change to your MySQL password
```

---

## Step 3A: Setup in Eclipse

### Create the Project
1. Open Eclipse → **File → New → Dynamic Web Project**
2. Project name: `SmartCareerPortal`
3. Target runtime: Select **Apache Tomcat v9.0** (configure if not already added)
4. Click **Finish**

### Add Source Files
1. Copy the contents of `src/main/java/` into Eclipse's `Java Resources/src/` folder
2. Copy the contents of `src/main/webapp/` into Eclipse's `WebContent/` folder
   - `WEB-INF/web.xml` → `WebContent/WEB-INF/web.xml`
   - `css/style.css` → `WebContent/css/style.css`
   - `js/script.js` → `WebContent/js/script.js`
   - All `.jsp` files → `WebContent/` (root of WebContent)

### Add MySQL Connector JAR
1. Download `mysql-connector-j-8.x.x.jar` from MySQL website
2. Copy the JAR file into `WebContent/WEB-INF/lib/` folder
3. Right-click the JAR → **Build Path → Add to Build Path**

### Add Servlet API
1. Right-click project → **Properties → Java Build Path → Libraries**
2. Click **Add Library → Server Runtime → Apache Tomcat v9.0**
3. Click **Apply and Close**

### Run the Project
1. Right-click project → **Run As → Run on Server**
2. Select **Apache Tomcat v9.0**
3. Click **Finish**
4. Open browser: **http://localhost:8080/SmartCareerPortal/**

---

## Step 3B: Setup in IntelliJ IDEA

### Create the Project
1. Open IntelliJ → **File → New → Project**
2. Select **Java Enterprise** (Ultimate) or create a plain Java project
3. Select **Web Application** under frameworks
4. Set project SDK to JDK 8+
5. Application Server: Configure **Tomcat 9**
6. Click **Create**

### For IntelliJ Community Edition (Manual Setup)
1. Create a new Java project
2. Manually configure the folder structure as shown in this project
3. Add Tomcat's `servlet-api.jar` to project libraries
4. Use the **Smart Tomcat** plugin for deployment

### Add Source Files
1. Copy `src/main/java/` contents into `src/` directory
2. Copy `src/main/webapp/` contents into `web/` directory (IntelliJ's default)

### Add Dependencies
1. **File → Project Structure → Libraries**
2. Click **+** → **Java** → Navigate to and add:
   - `mysql-connector-j-8.x.x.jar`
   - Tomcat's `servlet-api.jar` (found in `TOMCAT_HOME/lib/`)

### Configure Deployment
1. **Run → Edit Configurations → + → Tomcat Server → Local**
2. Configure Tomcat Home directory
3. In **Deployment** tab: Click **+** → **Artifact** → Select the WAR exploded artifact
4. Set Application context to `/SmartCareerPortal`

### Run the Project
1. Click the **Run** button (green play icon)
2. IntelliJ will open browser automatically
3. Navigate to: **http://localhost:8080/SmartCareerPortal/**

---

## Step 4: Test the Application

### Test User Flow
1. Open **http://localhost:8080/SmartCareerPortal/**
2. Click **Get Started** → Fill registration form → Click **Register**
3. Login with your registered email and password
4. On Dashboard, click **Start Quiz** for any category
5. Answer the questions (timer runs for 10 minutes)
6. Click **Submit** → View results
7. Navigate to **History** to see past attempts
8. Navigate to **Weak Areas** to see improvement suggestions
9. Check **Leaderboard** for top scores
10. Visit **Contact** page to see support options

### Test Admin Flow
1. Go to **http://localhost:8080/SmartCareerPortal/admin-login.jsp**
2. Login with: **Username:** `admin` | **Password:** `admin123`
3. Add a new question using the form
4. Edit an existing question
5. Delete a question (confirm dialog will appear)
6. Logout

---

## Project Structure Overview

```
SmartCareerPortal/
│
├── database/
│   └── schema.sql                 ← Run this first in MySQL
│
├── src/main/java/com/career/
│   ├── util/
│   │   └── DBConnection.java      ← JDBC connection (update credentials here)
│   ├── model/
│   │   ├── User.java              ← User data model
│   │   ├── Question.java          ← Question data model
│   │   ├── Result.java            ← Result data model
│   │   └── Admin.java             ← Admin data model
│   ├── dao/
│   │   ├── UserDAO.java           ← User database operations
│   │   ├── QuestionDAO.java       ← Question CRUD operations
│   │   ├── ResultDAO.java         ← Result storage & retrieval
│   │   └── AdminDAO.java          ← Admin authentication
│   └── controller/
│       ├── RegisterServlet.java    ← POST /register
│       ├── LoginServlet.java       ← POST /login
│       ├── LogoutServlet.java      ← GET /logout
│       ├── DashboardServlet.java   ← GET /dashboard
│       ├── QuizServlet.java        ← GET /quiz?category=X
│       ├── SubmitQuizServlet.java  ← POST /submitQuiz
│       ├── HistoryServlet.java     ← GET /history
│       ├── WeakAreaServlet.java    ← GET /weakarea
│       ├── LeaderboardServlet.java ← GET /leaderboard
│       ├── AdminLoginServlet.java  ← POST /adminLogin
│       ├── AdminDashboardServlet.java ← GET /adminDashboard
│       ├── AddQuestionServlet.java ← POST /addQuestion
│       ├── UpdateQuestionServlet.java ← POST /updateQuestion
│       └── DeleteQuestionServlet.java ← GET /deleteQuestion?id=X
│
└── src/main/webapp/
    ├── WEB-INF/web.xml            ← Deployment descriptor
    ├── css/style.css              ← All styles
    ├── js/script.js               ← Client-side validation & timer
    ├── index.jsp                  ← Landing page
    ├── register.jsp               ← Registration form
    ├── login.jsp                  ← User login
    ├── dashboard.jsp              ← Quiz categories
    ├── quiz.jsp                   ← Quiz with timer
    ├── result.jsp                 ← Score & results
    ├── history.jsp                ← Past attempts
    ├── weakarea.jsp               ← Improvement suggestions
    ├── leaderboard.jsp            ← Top scorers
    ├── contact.jsp                ← Support contacts
    ├── admin-login.jsp            ← Admin login
    └── admin-dashboard.jsp        ← Question management
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| `ClassNotFoundException: com.mysql.cj.jdbc.Driver` | Make sure `mysql-connector-j-8.x.x.jar` is in `WEB-INF/lib/` |
| `Access denied for user 'root'@'localhost'` | Update username/password in `DBConnection.java` |
| `Unknown database 'career_portal'` | Run `schema.sql` in MySQL first |
| `404 Not Found` for servlets | Ensure `@WebServlet` annotations are correct and project is deployed |
| `500 Internal Server Error` | Check Tomcat console/logs for stack trace |
| JSP compilation error | Ensure `servlet-api.jar` is in build path |
| Port 8080 already in use | Change Tomcat port in `server.xml` or stop the conflicting process |

---

## Default Login Credentials

| Role | Email/Username | Password |
|------|----------------|----------|
| Admin | admin | admin123 |
| Test User | (register a new user) | (your password) |

---

## Technologies Used
- **Frontend:** HTML5, CSS3, JavaScript, JSP
- **Backend:** Java Servlets (javax.servlet)
- **Database:** MySQL 8.0
- **Connectivity:** JDBC (MySQL Connector/J)
- **Server:** Apache Tomcat 9
- **Architecture:** MVC (Model-View-Controller)
