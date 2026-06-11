package com.career.model;

/**
 * Admin - Model class representing an administrator.
 * 
 * Maps to the 'admin' table in the career_portal database.
 * Used by AdminDAO for admin login authentication.
 */
public class Admin {

    // ---- Fields matching the 'admin' table columns ----
    private int id;
    private String username;
    private String password;

    // ---- Constructors ----

    /** Default no-argument constructor */
    public Admin() {
    }

    /** Constructor with all fields (useful when reading from DB) */
    public Admin(int id, String username, String password) {
        this.id = id;
        this.username = username;
        this.password = password;
    }

    /** Constructor without id (useful for login checks) */
    public Admin(String username, String password) {
        this.username = username;
        this.password = password;
    }

    // ---- Getters and Setters ----

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Admin [id=" + id + ", username=" + username + "]";
    }
}
