package com.sbeam.sbeam.entity.VO;

public class GameLibraryVO {
    private Integer gameId;
    private String gameName;
    private String mainImageUrl;
    private String source;

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

    public String getMainImageUrl() {
        return mainImageUrl;
    }

    public void setMainImageUrl(String mainImageUrl) {
        this.mainImageUrl = mainImageUrl;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    @Override
    public String toString() {
        return "GameLibraryVO{" +
                "gameId=" + gameId +
                ", gameName='" + gameName + '\'' +
                ", mainImageUrl='" + mainImageUrl + '\'' +
                ", source='" + source + '\'' +
                '}';
    }
}
