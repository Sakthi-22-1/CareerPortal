package com.career.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - Utility class for database connectivity.
 * 
 * Provides a static method to obtain a JDBC connection to the
 * career_portal MySQL database. All DAO classes use this utility
 * to get their database connections.
 */
public class DBConnection {

    // ---- Database configuration constants ----
    private static final String URL      = "jdbc:mysql://localhost:3306/career_portal";
    private static final String USER     = "root";
    private static final String PASSWORD = "Sakthi@9360540023";

    /**
     * Returns a new Connection object to the career_portal database.
     * 
     * Usage example:
     *   Connection conn = DBConnection.getConnection();
     *
     * @return a java.sql.Connection to the MySQL database
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Step 1: Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Step 2: Establish the connection
            connection = DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException e) {
            // Driver JAR is missing from the classpath
            System.err.println("MySQL JDBC Driver not found. "
                    + "Make sure mysql-connector-java is in your classpath.");
            e.printStackTrace();
        } catch (SQLException e) {
            // Connection failed (wrong URL, credentials, or DB is down)
            System.err.println("Database connection failed. "
                    + "Check URL, username, password, and MySQL service status.");
            e.printStackTrace();
        }
        return connection;
    }
}
