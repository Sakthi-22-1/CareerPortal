package com.career.model;

import java.sql.Timestamp;

/**
 * User - Model class representing a registered user.
 * 
 * Maps to the 'users' table in the career_portal database.
 * Used by UserDAO for registration and login operations.
 */
public class User {

    // ---- Fields matching the 'users' table columns ----
    private int id;
    private String name;
    private String email;
    private String password;
    private Timestamp createdAt;
    private int streak;

    // ---- Constructors ----

    /** Default no-argument constructor */
    public User() {
    }

    /** Constructor with all fields (useful when reading from DB) */
    public User(int id, String name, String email, String password, Timestamp createdAt, int streak) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
        this.streak = streak;
    }

    /** Constructor without id and createdAt (useful for registration) */
    public User(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // ---- Getters and Setters ----

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getStreak() {
        return streak;
    }

    public void setStreak(int streak) {
        this.streak = streak;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + ", email=" + email + "]";
    }
}
