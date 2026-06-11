package com.career.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.career.model.User;
import com.career.util.DBConnection;

/**
 * UserDAO - Data Access Object for User operations.
 * 
 * Handles user registration, login authentication, and
 * fetching user details by ID. All methods use PreparedStatement
 * to prevent SQL injection.
 */
public class UserDAO {

    /**
     * Registers a new user in the database.
     * 
     * @param user the User object containing name, email, and password
     * @return true if registration was successful, false otherwise
     */
    public static boolean register(User user) {
        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

        try (
            // Get a connection from our utility class
            Connection conn = DBConnection.getConnection();
            // Create a prepared statement to safely insert data
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            // Set the parameter values (index starts at 1)
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());

            // executeUpdate() returns the number of rows affected
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            // This can happen if the email already exists (UNIQUE constraint)
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Authenticates a user by email and password.
     * 
     * @param email    the user's email address
     * @param password the user's password
     * @return the User object if credentials match, null otherwise
     */
    public static User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, email);
            ps.setString(2, password);

            // Execute the query and check if a matching row exists
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Build and return a User object from the result set
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    user.setStreak(rs.getInt("streak"));
                    return user;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error during user login: " + e.getMessage());
            e.printStackTrace();
        }

        // No matching user found
        return null;
    }

    /**
     * Retrieves a user by their unique ID.
     * 
     * @param id the user's ID
     * @return the User object if found, null otherwise
     */
    public static User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    user.setStreak(rs.getInt("streak"));
                    return user;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error fetching user by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Updates the user's streak in the database.
     * 
     * @param userId the user's ID
     * @param newStreak the new streak value
     * @return true if updated successfully, false otherwise
     */
    public static boolean updateStreak(int userId, int newStreak) {
        String sql = "UPDATE users SET streak = ? WHERE id = ?";
        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, newStreak);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating streak: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
