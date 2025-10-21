package com.sbeam.sbeam.entity.VO;

public class GameProfileVO {
    private Integer gameProfileId;
    private String gameName;
    private String gameDescription;// 游戏简介
    private String gameDeveloper;// 游戏开发商
    private String gameTagName; // 标签（例如：动作, 冒险）
    private String gameConfig;// 游戏配置
    private String series;// 游戏系列

    public Integer getGameProfileId() {
        return gameProfileId;
    }

    public void setGameProfileId(Integer gameProfileId) {
        this.gameProfileId = gameProfileId;
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
}
