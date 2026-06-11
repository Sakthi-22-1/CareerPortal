package com.career.model;

import java.sql.Date;
import java.sql.Timestamp;

public class StreakHistory {
    private int id;
    private int userId;
    private Date streakDate;
    private int streakCount;
    private String actionType;
    private Timestamp createdAt;

    public StreakHistory() {
    }

    public StreakHistory(int userId, Date streakDate, int streakCount, String actionType) {
        this.userId = userId;
        this.streakDate = streakDate;
        this.streakCount = streakCount;
        this.actionType = actionType;
    }

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

    public Date getStreakDate() {
        return streakDate;
    }

    public void setStreakDate(Date streakDate) {
        this.streakDate = streakDate;
    }

    public int getStreakCount() {
        return streakCount;
    }

    public void setStreakCount(int streakCount) {
        this.streakCount = streakCount;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
