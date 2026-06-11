package com.career.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.career.model.StreakHistory;
import com.career.util.DBConnection;

public class StreakDAO {

    public static boolean addStreakRecord(StreakHistory streakHistory) {
        String sql = "INSERT INTO streak_history (user_id, streak_date, streak_count, action_type) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, streakHistory.getUserId());
            ps.setDate(2, streakHistory.getStreakDate());
            ps.setInt(3, streakHistory.getStreakCount());
            ps.setString(4, streakHistory.getActionType());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<StreakHistory> getStreakHistoryByUser(int userId) {
        List<StreakHistory> historyList = new ArrayList<>();
        String sql = "SELECT * FROM streak_history WHERE user_id = ? ORDER BY streak_date DESC, created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StreakHistory history = new StreakHistory();
                    history.setId(rs.getInt("id"));
                    history.setUserId(rs.getInt("user_id"));
                    history.setStreakDate(rs.getDate("streak_date"));
                    history.setStreakCount(rs.getInt("streak_count"));
                    history.setActionType(rs.getString("action_type"));
                    history.setCreatedAt(rs.getTimestamp("created_at"));
                    historyList.add(history);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return historyList;
    }
}
