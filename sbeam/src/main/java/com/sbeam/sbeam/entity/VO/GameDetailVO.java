package com.sbeam.sbeam.entity.VO;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class GameDetailVO {
    private Integer gameId;
    private String gameName;
    private BigDecimal gameOriginalPrice;
    private LocalDateTime releaseDate;
    private String mainImageUrl;
    private List<String> gameImages;
    private List<GameBundleVO> gameBundles;
    private List<GamePriceHistoryVO> priceHistory;
    private List<GameAchievementVO> gameAchievements;
    private GameProfileVO gameProfile;

    public GameProfileVO getGameProfile() {
        return gameProfile;
    }

    public void setGameProfile(GameProfileVO gameProfile) {
        this.gameProfile = gameProfile;
    }

    private boolean isUserFollowed;

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

    public BigDecimal getGameOriginalPrice() {
        return gameOriginalPrice;
    }

    public void setGameOriginalPrice(BigDecimal gameOriginalPrice) {
        this.gameOriginalPrice = gameOriginalPrice;
    }

    public LocalDateTime getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(LocalDateTime releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getMainImageUrl() {
        return mainImageUrl;
    }

    public void setMainImageUrl(String mainImageUrl) {
        this.mainImageUrl = mainImageUrl;
    }

    public List<String> getGameImages() {
        return gameImages;
    }

    public void setGameImages(List<String> gameImages) {
        this.gameImages = gameImages;
    }

    public List<GameBundleVO> getGameBundles() {
        return gameBundles;
    }

    public void setGameBundles(List<GameBundleVO> gameBundles) {
        this.gameBundles = gameBundles;
    }

    public List<GamePriceHistoryVO> getPriceHistory() {
        return priceHistory;
    }

    public void setPriceHistory(List<GamePriceHistoryVO> priceHistory) {
        this.priceHistory = priceHistory;
    }

    public List<GameAchievementVO> getGameAchievements() {
        return gameAchievements;
    }

    public void setGameAchievements(List<GameAchievementVO> gameAchievements) {
        this.gameAchievements = gameAchievements;
    }

    public boolean isUserFollowed() {
        return isUserFollowed;
    }

    public void setUserFollowed(boolean userFollowed) {
        isUserFollowed = userFollowed;
    }

}
