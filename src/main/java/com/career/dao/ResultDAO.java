package com.career.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.career.model.Result;
import com.career.util.DBConnection;

/**
 * ResultDAO - Data Access Object for Result operations.
 * 
 * Handles saving quiz results, fetching a user's result history,
 * and building the leaderboard. All methods use PreparedStatement
 * to prevent SQL injection.
 */
public class ResultDAO {

    /**
     * Saves a quiz result to the database.
     * Called after a user completes a quiz and the score is calculated.
     * 
     * @param r the Result object with all scoring details
     * @return true if the result was saved successfully
     */
    public static boolean saveResult(Result r) {
        String sql = "INSERT INTO results (user_id, category, total_questions, correct_answers, "
                   + "wrong_answers, score_percentage, status, weak_topics) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, r.getUserId());
            ps.setString(2, r.getCategory());
            ps.setInt(3, r.getTotalQuestions());
            ps.setInt(4, r.getCorrectAnswers());
            ps.setInt(5, r.getWrongAnswers());
            ps.setDouble(6, r.getScorePercentage());
            ps.setString(7, r.getStatus());
            ps.setString(8, r.getWeakTopics());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            System.err.println("Error saving result: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves all quiz results for a specific user, ordered by most recent first.
     * Used to display a user's quiz history and performance over time.
     * 
     * @param userId the ID of the user
     * @return list of Result objects for the user, newest first
     */
    public static List<Result> getResultsByUser(int userId) {
        List<Result> results = new ArrayList<>();
        String sql = "SELECT * FROM results WHERE user_id = ? ORDER BY attempted_at DESC";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    results.add(extractResult(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error fetching results by user: " + e.getMessage());
            e.printStackTrace();
        }

        return results;
    }

    /**
     * Retrieves the top 10 results across all users for the leaderboard.
     * Joins with the users table to include the user's display name.
     * Results are ordered by highest score percentage first.
     * 
     * @return list of the top 10 Result objects (with userName populated)
     */
    public static List<Result> getLeaderboard() {
        List<Result> results = new ArrayList<>();
        String sql = "SELECT r.*, u.name AS user_name "
                   + "FROM results r "
                   + "JOIN users u ON r.user_id = u.id "
                   + "ORDER BY r.score_percentage DESC "
                   + "LIMIT 10";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                // Build the Result object from DB columns
                Result result = extractResult(rs);
                // Set the user's display name from the JOIN
                result.setUserName(rs.getString("user_name"));
                results.add(result);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching leaderboard: " + e.getMessage());
            e.printStackTrace();
        }

        return results;
    }

    // ---- Helper Method ----

    /**
     * Extracts a Result object from the current row of a ResultSet.
     * Does NOT set userName — that is only available in leaderboard queries.
     * 
     * @param rs the ResultSet positioned at a valid row
     * @return a fully populated Result object
     * @throws SQLException if a column cannot be read
     */
    private static Result extractResult(ResultSet rs) throws SQLException {
        Result result = new Result();
        result.setId(rs.getInt("id"));
        result.setUserId(rs.getInt("user_id"));
        result.setCategory(rs.getString("category"));
        result.setTotalQuestions(rs.getInt("total_questions"));
        result.setCorrectAnswers(rs.getInt("correct_answers"));
        result.setWrongAnswers(rs.getInt("wrong_answers"));
        result.setScorePercentage(rs.getDouble("score_percentage"));
        result.setStatus(rs.getString("status"));
        result.setWeakTopics(rs.getString("weak_topics"));
        result.setAttemptedAt(rs.getTimestamp("attempted_at"));
        return result;
    }
}
