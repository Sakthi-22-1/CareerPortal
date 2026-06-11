package com.career.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.career.model.Admin;
import com.career.util.DBConnection;

/**
 * AdminDAO - Data Access Object for Admin operations.
 * 
 * Handles admin login authentication. Uses PreparedStatement
 * to prevent SQL injection attacks.
 */
public class AdminDAO {

    /**
     * Authenticates an admin by username and password.
     * 
     * @param username the admin's username
     * @param password the admin's password
     * @return the Admin object if credentials match, null otherwise
     */
    public static Admin login(String username, String password) {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";

        try (
            // Get a connection from our utility class
            Connection conn = DBConnection.getConnection();
            // Create a prepared statement with the login query
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            // Set the username and password parameters safely
            ps.setString(1, username);
            ps.setString(2, password);

            // Execute the query
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Credentials matched — build and return an Admin object
                    Admin admin = new Admin();
                    admin.setId(rs.getInt("id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setPassword(rs.getString("password"));
                    return admin;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error during admin login: " + e.getMessage());
            e.printStackTrace();
        }

        // No matching admin found — login failed
        return null;
    }
}
