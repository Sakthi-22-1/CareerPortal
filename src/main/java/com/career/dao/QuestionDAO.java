package com.career.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.career.model.Question;
import com.career.util.DBConnection;

/**
 * QuestionDAO - Data Access Object for Question operations.
 * 
 * Provides full CRUD functionality for quiz questions.
 * Used by both admin (manage questions) and user (take quiz) flows.
 * All methods use PreparedStatement to prevent SQL injection.
 */
public class QuestionDAO {

    /**
     * Retrieves all questions belonging to a specific category.
     * Used when a user starts a quiz for a chosen category.
     * 
     * @param category the quiz category (e.g., "Java", "SQL")
     * @return list of Question objects for that category
     */
    public static List<Question> getQuestionsByCategory(String category) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions WHERE category = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, category);

            try (ResultSet rs = ps.executeQuery()) {
                // Loop through all matching rows and build Question objects
                while (rs.next()) {
                    questions.add(extractQuestion(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error fetching questions by category: " + e.getMessage());
            e.printStackTrace();
        }

        return questions;
    }

    /**
     * Adds a new question to the database.
     * Used by the admin to create new quiz questions.
     * 
     * @param q the Question object to insert
     * @return true if the question was added successfully
     */
    public static boolean addQuestion(Question q) {
        String sql = "INSERT INTO questions (category, question_text, option_a, option_b, "
                   + "option_c, option_d, correct_option, topic) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, q.getCategory());
            ps.setString(2, q.getQuestionText());
            ps.setString(3, q.getOptionA());
            ps.setString(4, q.getOptionB());
            ps.setString(5, q.getOptionC());
            ps.setString(6, q.getOptionD());
            ps.setString(7, q.getCorrectOption());
            ps.setString(8, q.getTopic());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            System.err.println("Error adding question: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates an existing question in the database.
     * Used by the admin to edit quiz questions.
     * 
     * @param q the Question object with updated values (must have valid id)
     * @return true if the question was updated successfully
     */
    public static boolean updateQuestion(Question q) {
        String sql = "UPDATE questions SET category = ?, question_text = ?, option_a = ?, "
                   + "option_b = ?, option_c = ?, option_d = ?, correct_option = ?, topic = ? "
                   + "WHERE id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, q.getCategory());
            ps.setString(2, q.getQuestionText());
            ps.setString(3, q.getOptionA());
            ps.setString(4, q.getOptionB());
            ps.setString(5, q.getOptionC());
            ps.setString(6, q.getOptionD());
            ps.setString(7, q.getCorrectOption());
            ps.setString(8, q.getTopic());
            ps.setInt(9, q.getId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.err.println("Error updating question: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a question from the database by its ID.
     * Used by the admin to remove quiz questions.
     * 
     * @param id the ID of the question to delete
     * @return true if the question was deleted successfully
     */
    public static boolean deleteQuestion(int id) {
        String sql = "DELETE FROM questions WHERE id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, id);

            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting question: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves a single question by its ID.
     * Used by the admin when editing a specific question.
     * 
     * @param id the question ID
     * @return the Question object if found, null otherwise
     */
    public static Question getQuestionById(int id) {
        String sql = "SELECT * FROM questions WHERE id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractQuestion(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error fetching question by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Retrieves all questions from the database.
     * Used by the admin to view the complete question bank.
     * 
     * @return list of all Question objects
     */
    public static List<Question> getAllQuestions() {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                questions.add(extractQuestion(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error fetching all questions: " + e.getMessage());
            e.printStackTrace();
        }

        return questions;
    }

    // ---- Helper Method ----

    /**
     * Extracts a Question object from the current row of a ResultSet.
     * This avoids duplicating the mapping code in every method.
     * 
     * @param rs the ResultSet positioned at a valid row
     * @return a fully populated Question object
     * @throws SQLException if a column cannot be read
     */
    private static Question extractQuestion(ResultSet rs) throws SQLException {
        Question q = new Question();
        q.setId(rs.getInt("id"));
        q.setCategory(rs.getString("category"));
        q.setQuestionText(rs.getString("question_text"));
        q.setOptionA(rs.getString("option_a"));
        q.setOptionB(rs.getString("option_b"));
        q.setOptionC(rs.getString("option_c"));
        q.setOptionD(rs.getString("option_d"));
        q.setCorrectOption(rs.getString("correct_option"));
        q.setTopic(rs.getString("topic"));
        return q;
    }
}
