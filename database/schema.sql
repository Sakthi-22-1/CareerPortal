-- ============================================================
-- Smart Career Assessment Portal - Database Schema
-- ============================================================
-- This script creates the entire database structure and seeds
-- it with default data including an admin account and 50
-- realistic assessment questions across 5 categories.
-- ============================================================

-- Create and select the database
CREATE DATABASE IF NOT EXISTS career_portal;
USE career_portal;

-- ============================================================
-- TABLE: users
-- Stores registered user accounts
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100)  NOT NULL,
    email      VARCHAR(100)  NOT NULL UNIQUE,
    password   VARCHAR(255)  NOT NULL,
    created_at TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE: admin
-- Stores administrator accounts
-- ============================================================
CREATE TABLE IF NOT EXISTS admin (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50)  NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- ============================================================
-- TABLE: questions
-- Stores quiz questions with four options and a topic tag
-- ============================================================
CREATE TABLE IF NOT EXISTS questions (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    category       VARCHAR(50)  NOT NULL,
    question_text  TEXT         NOT NULL,
    option_a       VARCHAR(255) NOT NULL,
    option_b       VARCHAR(255) NOT NULL,
    option_c       VARCHAR(255) NOT NULL,
    option_d       VARCHAR(255) NOT NULL,
    correct_option CHAR(1)      NOT NULL,
    topic          VARCHAR(100) NOT NULL
);

-- ============================================================
-- TABLE: results
-- Stores quiz attempt results with weak-topic analysis
-- ============================================================
CREATE TABLE IF NOT EXISTS results (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT          NOT NULL,
    category         VARCHAR(50)  NOT NULL,
    total_questions  INT          NOT NULL,
    correct_answers  INT          NOT NULL,
    wrong_answers    INT          NOT NULL,
    score_percentage DOUBLE       NOT NULL,
    status           VARCHAR(10)  NOT NULL,
    weak_topics      TEXT,
    attempted_at     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ============================================================
-- SEED DATA: Default Admin Account
-- ============================================================
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');

-- ============================================================
-- SEED DATA: Java Questions (10)
-- ============================================================
INSERT INTO questions (category, question_text, option_a, option_b, option_c, option_d, correct_option, topic) VALUES
('Java', 'Which principle of OOP allows a subclass to provide a specific implementation of a method already defined in its superclass?',
 'Encapsulation', 'Polymorphism', 'Abstraction', 'Inheritance', 'B', 'OOP Concepts'),

('Java', 'What is the output of System.out.println(10 + 20 + "Hello" + 30 + 40)?',
 '30Hello3040', '1020Hello3040', '30Hello70', 'Compilation Error', 'A', 'String Handling'),

('Java', 'Which keyword is used to prevent a class from being inherited in Java?',
 'static', 'abstract', 'final', 'private', 'C', 'OOP Concepts'),

('Java', 'What is the default value of an int array element in Java?',
 '1', 'null', '0', 'undefined', 'C', 'Arrays'),

('Java', 'Which collection class allows duplicate elements and maintains insertion order?',
 'HashSet', 'TreeSet', 'ArrayList', 'HashMap', 'C', 'Collections Framework'),

('Java', 'What does the "this" keyword refer to in Java?',
 'The parent class object', 'The current class object', 'A static reference', 'The main method', 'B', 'OOP Concepts'),

('Java', 'Which exception is thrown when dividing an integer by zero?',
 'NullPointerException', 'NumberFormatException', 'ArithmeticException', 'ArrayIndexOutOfBoundsException', 'C', 'Exception Handling'),

('Java', 'What is the purpose of the "super" keyword in Java?',
 'To call a method in the same class', 'To refer to the parent class members', 'To create a new object', 'To define a static method', 'B', 'Inheritance'),

('Java', 'Which interface must a class implement to allow its objects to be sorted using Collections.sort()?',
 'Serializable', 'Cloneable', 'Comparable', 'Iterable', 'C', 'Collections Framework'),

('Java', 'What is the difference between == and .equals() when comparing String objects?',
 '== compares content, .equals() compares reference', '== compares reference, .equals() compares content', 'Both compare content', 'Both compare reference', 'B', 'String Handling');

-- ============================================================
-- SEED DATA: Aptitude Questions (10)
-- ============================================================
INSERT INTO questions (category, question_text, option_a, option_b, option_c, option_d, correct_option, topic) VALUES
('Aptitude', 'Find the next number in the series: 2, 6, 12, 20, 30, ?',
 '40', '42', '44', '36', 'B', 'Number Series'),

('Aptitude', 'A train 150 m long passes a pole in 15 seconds. What is the speed of the train in km/hr?',
 '36 km/hr', '40 km/hr', '45 km/hr', '30 km/hr', 'A', 'Speed and Distance'),

('Aptitude', 'If the ratio of boys to girls in a class is 3:5 and there are 40 students, how many boys are there?',
 '15', '20', '25', '12', 'A', 'Ratios and Proportions'),

('Aptitude', 'A can complete a work in 12 days and B can complete the same work in 18 days. In how many days will they finish it together?',
 '6.2 days', '7.2 days', '8.5 days', '9 days', 'B', 'Time and Work'),

('Aptitude', 'What is 35% of 800?',
 '240', '260', '280', '300', 'C', 'Percentages'),

('Aptitude', 'The average of first 10 natural numbers is:',
 '5', '5.5', '6', '6.5', 'B', 'Averages'),

('Aptitude', 'A shopkeeper buys an item for Rs.400 and sells it for Rs.500. What is the profit percentage?',
 '20%', '25%', '15%', '30%', 'B', 'Profit and Loss'),

('Aptitude', 'Find the simple interest on Rs.5000 at 8% per annum for 3 years.',
 'Rs.1000', 'Rs.1200', 'Rs.1500', 'Rs.800', 'B', 'Simple Interest'),

('Aptitude', 'If 6 men can do a piece of work in 20 days, how many men are needed to finish it in 12 days?',
 '8', '10', '12', '15', 'B', 'Time and Work'),

('Aptitude', 'A clock shows 3:15. What is the angle between the hour and minute hands?',
 '0°', '7.5°', '15°', '22.5°', 'B', 'Clocks');

-- ============================================================
-- SEED DATA: HTML/CSS Questions (10)
-- ============================================================
INSERT INTO questions (category, question_text, option_a, option_b, option_c, option_d, correct_option, topic) VALUES
('HTML/CSS', 'Which HTML5 element is used for navigation links?',
 '<navigate>', '<nav>', '<links>', '<menu>', 'B', 'Semantic HTML'),

('HTML/CSS', 'What CSS property is used to make text bold?',
 'text-style: bold', 'font-weight: bold', 'text-decoration: bold', 'font-style: bold', 'B', 'CSS Typography'),

('HTML/CSS', 'Which CSS selector targets an element with id="header"?',
 '.header', '#header', '*header', 'header', 'B', 'CSS Selectors'),

('HTML/CSS', 'What does the CSS box-sizing: border-box property do?',
 'Adds a border to all boxes', 'Includes padding and border in element total width and height', 'Removes the border from the element', 'Sets the box shadow', 'B', 'Box Model'),

('HTML/CSS', 'Which HTML attribute is used to specify an alternate text for an image?',
 'title', 'src', 'alt', 'longdesc', 'C', 'HTML Attributes'),

('HTML/CSS', 'What is the correct CSS syntax to make all <p> elements inside a <div> red?',
 'div.p { color: red; }', 'div > p { color: red; }', 'div + p { color: red; }', 'p div { color: red; }', 'B', 'CSS Selectors'),

('HTML/CSS', 'Which CSS property is used to create space between the element border and its content?',
 'margin', 'padding', 'spacing', 'gap', 'B', 'Box Model'),

('HTML/CSS', 'What is the purpose of the <meta charset="UTF-8"> tag?',
 'Sets the page language', 'Specifies the character encoding', 'Links to a stylesheet', 'Defines the viewport', 'B', 'HTML Meta Tags'),

('HTML/CSS', 'Which display property value makes an element behave like a flex container?',
 'display: block', 'display: inline', 'display: flex', 'display: grid', 'C', 'Flexbox'),

('HTML/CSS', 'What is the correct way to link an external CSS file in HTML?',
 '<style src="style.css">', '<css href="style.css">', '<link rel="stylesheet" href="style.css">', '<stylesheet>style.css</stylesheet>', 'C', 'HTML Attributes');

-- ============================================================
-- SEED DATA: SQL Questions (10)
-- ============================================================
INSERT INTO questions (category, question_text, option_a, option_b, option_c, option_d, correct_option, topic) VALUES
('SQL', 'Which SQL clause is used to filter rows returned by a query?',
 'ORDER BY', 'GROUP BY', 'WHERE', 'HAVING', 'C', 'Basic Queries'),

('SQL', 'What type of JOIN returns all rows from both tables, with NULLs where there is no match?',
 'INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'FULL OUTER JOIN', 'D', 'JOIN Operations'),

('SQL', 'Which aggregate function returns the number of rows in a table?',
 'SUM()', 'AVG()', 'COUNT()', 'TOTAL()', 'C', 'Aggregate Functions'),

('SQL', 'What is the purpose of the GROUP BY clause?',
 'To sort the result set', 'To filter rows before grouping', 'To group rows sharing a property for aggregate functions', 'To limit the number of results', 'C', 'Grouping and Aggregation'),

('SQL', 'Which SQL statement is used to update existing data in a table?',
 'MODIFY', 'ALTER', 'UPDATE', 'SET', 'C', 'DML Operations'),

('SQL', 'What does the HAVING clause do in SQL?',
 'Filters rows before grouping', 'Filters groups after GROUP BY', 'Sorts the result set', 'Joins two tables', 'B', 'Grouping and Aggregation'),

('SQL', 'Which constraint ensures that all values in a column are unique?',
 'PRIMARY KEY', 'FOREIGN KEY', 'UNIQUE', 'NOT NULL', 'C', 'Constraints'),

('SQL', 'What is a foreign key?',
 'A key used to encrypt data', 'A key that uniquely identifies each row', 'A field that refers to the primary key of another table', 'A key used for indexing', 'C', 'JOIN Operations'),

('SQL', 'Which SQL command is used to remove all rows from a table without logging individual row deletions?',
 'DELETE', 'DROP', 'TRUNCATE', 'REMOVE', 'C', 'DDL Operations'),

('SQL', 'What is a subquery in SQL?',
 'A query that runs in the background', 'A query nested inside another query', 'A query that modifies data', 'A query used only with JOINs', 'B', 'Subqueries');

-- ============================================================
-- SEED DATA: Communication Skills Questions (10)
-- ============================================================
INSERT INTO questions (category, question_text, option_a, option_b, option_c, option_d, correct_option, topic) VALUES
('Communication Skills', 'Which of the following is the most important element of effective verbal communication?',
 'Using complex vocabulary', 'Speaking loudly', 'Clarity and conciseness', 'Speaking quickly to save time', 'C', 'Verbal Communication'),

('Communication Skills', 'What is "active listening"?',
 'Listening while doing other tasks', 'Fully concentrating on the speaker and providing feedback', 'Listening only to respond', 'Hearing without paying attention', 'B', 'Listening Skills'),

('Communication Skills', 'In a professional email, which of the following is the best practice?',
 'Using all capital letters for emphasis', 'Including a clear subject line', 'Writing long paragraphs without breaks', 'Using informal abbreviations like LOL', 'B', 'Written Communication'),

('Communication Skills', 'What does non-verbal communication include?',
 'Only facial expressions', 'Body language, gestures, eye contact, and posture', 'Only hand gestures', 'Only tone of voice', 'B', 'Non-Verbal Communication'),

('Communication Skills', 'Which barrier to communication involves making assumptions about the speaker based on stereotypes?',
 'Physical barrier', 'Language barrier', 'Perceptual barrier', 'Emotional barrier', 'C', 'Communication Barriers'),

('Communication Skills', 'What is the best way to handle a disagreement during a team meeting?',
 'Raise your voice to make your point', 'Ignore the disagreement and stay silent', 'Listen to all perspectives and seek a compromise', 'Leave the meeting immediately', 'C', 'Interpersonal Skills'),

('Communication Skills', 'Which of the following is an example of positive body language during an interview?',
 'Crossing your arms', 'Avoiding eye contact', 'Maintaining eye contact and nodding', 'Looking at your phone', 'C', 'Non-Verbal Communication'),

('Communication Skills', 'What is the primary purpose of a "summary" at the end of a presentation?',
 'To introduce new topics', 'To reinforce key points and provide closure', 'To extend the presentation time', 'To confuse the audience', 'B', 'Presentation Skills'),

('Communication Skills', 'Which communication style is best suited for a formal business report?',
 'Casual and conversational', 'Formal and objective', 'Emotional and persuasive', 'Slang-filled and brief', 'B', 'Written Communication'),

('Communication Skills', 'What is "feedback" in the context of communication?',
 'Ignoring the message received', 'The response given by the receiver to the sender', 'Repeating the same message', 'Sending a message without expecting a reply', 'B', 'Verbal Communication');
