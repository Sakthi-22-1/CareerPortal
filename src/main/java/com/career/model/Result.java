package com.career.model;

import java.sql.Timestamp;

/**
 * Result - Model class representing a quiz attempt result.
 * 
 * Maps to the 'results' table in the career_portal database.
 * Tracks scores, pass/fail status, and weak topics identified
 * during the quiz for performance analytics.
 * 
 * The 'userName' field is NOT stored in the database — it is
 * populated via a JOIN with the users table for leaderboard display.
 */
public class Result {

    // ---- Fields matching the 'results' table columns ----
    private int id;
    private int userId;
    private String category;
    private int totalQuestions;
    private int correctAnswers;
    private int wrongAnswers;
    private double scorePercentage;
    private String status;          // "Pass" or "Fail"
    private String weakTopics;      // Comma-separated list of weak topic names
    private Timestamp attemptedAt;

    // ---- Extra field for leaderboard display (not in DB) ----
    private String userName;

    // ---- Constructors ----

    /** Default no-argument constructor */
    public Result() {
    }

    /** Constructor with all DB fields (useful when reading from DB) */
    public Result(int id, int userId, String category, int totalQuestions,
                  int correctAnswers, int wrongAnswers, double scorePercentage,
                  String status, String weakTopics, Timestamp attemptedAt) {
        this.id = id;
        this.userId = userId;
        this.category = category;
        this.totalQuestions = totalQuestions;
        this.correctAnswers = correctAnswers;
        this.wrongAnswers = wrongAnswers;
        this.scorePercentage = scorePercentage;
        this.status = status;
        this.weakTopics = weakTopics;
        this.attemptedAt = attemptedAt;
    }

    /** Constructor without id and attemptedAt (useful for saving new results) */
    public Result(int userId, String category, int totalQuestions,
                  int correctAnswers, int wrongAnswers, double scorePercentage,
                  String status, String weakTopics) {
        this.userId = userId;
        this.category = category;
        this.totalQuestions = totalQuestions;
        this.correctAnswers = correctAnswers;
        this.wrongAnswers = wrongAnswers;
        this.scorePercentage = scorePercentage;
        this.status = status;
        this.weakTopics = weakTopics;
    }

    // ---- Getters and Setters ----

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(int totalQuestions) {
        this.totalQuestions = totalQuestions;
    }

    public int getCorrectAnswers() {
        return correctAnswers;
    }

    public void setCorrectAnswers(int correctAnswers) {
        this.correctAnswers = correctAnswers;
    }

    public int getWrongAnswers() {
        return wrongAnswers;
    }

    public void setWrongAnswers(int wrongAnswers) {
        this.wrongAnswers = wrongAnswers;
    }

    public double getScorePercentage() {
        return scorePercentage;
    }

    public void setScorePercentage(double scorePercentage) {
        this.scorePercentage = scorePercentage;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getWeakTopics() {
        return weakTopics;
    }

    public void setWeakTopics(String weakTopics) {
        this.weakTopics = weakTopics;
    }

    public Timestamp getAttemptedAt() {
        return attemptedAt;
    }

    public void setAttemptedAt(Timestamp attemptedAt) {
        this.attemptedAt = attemptedAt;
    }

    /** Get the user's display name (populated via JOIN, not stored in DB) */
    public String getUserName() {
        return userName;
    }

    /** Set the user's display name (used when building leaderboard results) */
    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "Result [id=" + id + ", userId=" + userId + ", category=" + category
                + ", score=" + scorePercentage + "%, status=" + status + "]";
    }
}
