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
@TableName("game_profile")
public class GameProfile implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 游戏详情ID
     */
    @TableId(value = "game_profile_id", type = IdType.AUTO)
    private Integer gameProfileId;

    /**
     * 游戏ID
     */
    private Integer gameId;

    /**
     * 游戏名称
     */
    private String gameName;

    /**
     * 游戏简介
     */
    private String gameDescription;

    /**
     * 游戏开发商
     */
    private String gameDeveloper;

    /**
     * 游戏标签名称
     */
    private String gameTagName;

    /**
     * 游戏配置
     */
    private String gameConfig;

    /**
     * 游戏系列
     */
    private String series;

    /**
     * 状态，0表示正常，1表示异常
     */
    private Integer status;

    /**
     * 版本控制
     */
    private Integer version;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;

    public Integer getGameProfileId() {
        return gameProfileId;
    }

    public void setGameProfileId(Integer gameProfileId) {
        this.gameProfileId = gameProfileId;
    }
    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }
    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }
    public String getGameDescription() {
        return gameDescription;
    }

    public void setGameDescription(String gameDescription) {
        this.gameDescription = gameDescription;
    }
    public String getGameDeveloper() {
        return gameDeveloper;
    }

    public void setGameDeveloper(String gameDeveloper) {
        this.gameDeveloper = gameDeveloper;
    }
    public String getGameTagName() {
        return gameTagName;
    }

    public void setGameTagName(String gameTagName) {
        this.gameTagName = gameTagName;
    }
    public String getGameConfig() {
        return gameConfig;
    }

    public void setGameConfig(String gameConfig) {
        this.gameConfig = gameConfig;
    }
    public String getSeries() {
        return series;
    }

    public void setSeries(String series) {
        this.series = series;
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
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "GameProfile{" +
            "gameProfileId=" + gameProfileId +
            ", gameId=" + gameId +
            ", gameName=" + gameName +
            ", gameDescription=" + gameDescription +
            ", gameDeveloper=" + gameDeveloper +
            ", gameTagName=" + gameTagName +
            ", gameConfig=" + gameConfig +
            ", series=" + series +
            ", status=" + status +
            ", version=" + version +
            ", createdAt=" + createdAt +
            ", updatedAt=" + updatedAt +
        "}";
    }
}
