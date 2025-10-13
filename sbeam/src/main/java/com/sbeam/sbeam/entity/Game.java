package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
<<<<<<< HEAD
=======
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
>>>>>>> origin/sub3

/**
 * <p>
 * 
 * </p>
 *
<<<<<<< HEAD
 * @author smith
 * @since 2025-10-07
 */
=======
 * @author yourname
 * @since 2025-10-09
 */
@Getter
@Setter
@ApiModel(value = "Game对象", description = "")
>>>>>>> origin/sub3
public class Game implements Serializable {

    private static final long serialVersionUID = 1L;

<<<<<<< HEAD
    /**
     * 游戏ID
     */
    @TableId(value = "game_id", type = IdType.AUTO)
    private Integer gameId;

    /**
     * 游戏名称
     */
    private String gameName;

    /**
     * 游戏原始价格
     */
    private BigDecimal gameOriginalPrice;

    /**
     * 游戏发行日期
     */
    private LocalDate releaseDate;

    /**
     * 游戏状态,0表示可获取,1表示下架
     */
    private Integer status;

    /**
     * 主图片 URL
     */
    private String mainImageUrl;

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
    public LocalDate getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(LocalDate releaseDate) {
        this.releaseDate = releaseDate;
    }
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getMainImageUrl() {
        return mainImageUrl;
    }

    public void setMainImageUrl(String mainImageUrl) {
        this.mainImageUrl = mainImageUrl;
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
        return "Game{" +
            "gameId=" + gameId +
            ", gameName=" + gameName +
            ", gameOriginalPrice=" + gameOriginalPrice +
            ", releaseDate=" + releaseDate +
            ", status=" + status +
            ", mainImageUrl=" + mainImageUrl +
            ", version=" + version +
            ", createdAt=" + createdAt +
            ", updatedAt=" + updatedAt +
        "}";
    }
=======
    @ApiModelProperty("游戏ID")
    @TableId(value = "game_id", type = IdType.AUTO)
    private Integer gameId;

    @ApiModelProperty("游戏名称")
    private String gameName;

    @ApiModelProperty("游戏原始价格")
    private BigDecimal gameOriginalPrice;

    @ApiModelProperty("游戏发行日期")
    private LocalDate releaseDate;

    @ApiModelProperty("游戏状态,0表示可获取,1表示下架")
    private Integer status;

    @ApiModelProperty("主图片 URL")
    private String mainImageUrl;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;
>>>>>>> origin/sub3
}
