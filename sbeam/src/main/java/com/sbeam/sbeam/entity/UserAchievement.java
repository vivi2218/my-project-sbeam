package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author smith
 * @since 2025-10-07
 */
@TableName("user_achievement")
public class UserAchievement implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户成就ID
     */
    @TableId(value = "user_achievement_id", type = IdType.AUTO)
    private Integer userAchievementId;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 成就ID
     */
    private Integer achievementId;

    /**
     * 达成日期
     */
    private LocalDateTime achievedAt;

    /**
     * 状态，0表示正常，1表示异常
     */
    private Integer status;

    /**
     * 版本控制
     */
    private Integer version;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;

    public Integer getUserAchievementId() {
        return userAchievementId;
    }

    public void setUserAchievementId(Integer userAchievementId) {
        this.userAchievementId = userAchievementId;
    }
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    public Integer getAchievementId() {
        return achievementId;
    }

    public void setAchievementId(Integer achievementId) {
        this.achievementId = achievementId;
    }
    public LocalDateTime getAchievedAt() {
        return achievedAt;
    }

    public void setAchievedAt(LocalDateTime achievedAt) {
        this.achievedAt = achievedAt;
    }
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "UserAchievement{" +
            "userAchievementId=" + userAchievementId +
            ", userId=" + userId +
            ", achievementId=" + achievementId +
            ", achievedAt=" + achievedAt +
            ", status=" + status +
            ", version=" + version +
            ", updatedAt=" + updatedAt +
        "}";
    }
}
