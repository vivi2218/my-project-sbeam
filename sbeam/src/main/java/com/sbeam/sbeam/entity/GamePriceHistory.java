package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
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
@TableName("game_price_history")
=======
 * @author yourname
 * @since 2025-10-09
 */
@Getter
@Setter
@TableName("game_price_history")
@ApiModel(value = "GamePriceHistory对象", description = "")
>>>>>>> origin/sub3
public class GamePriceHistory implements Serializable {

    private static final long serialVersionUID = 1L;

<<<<<<< HEAD
    /**
     * 记录ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 游戏ID
     */
    private Integer gameId;

    /**
     * 原价
     */
    private BigDecimal originalPrice;

    /**
     * 史低价格
     */
    private BigDecimal lowestPrice;

    /**
     * 史低时间
     */
    private LocalDateTime lowestPriceTime;

    /**
     * 近史低价格
     */
    private BigDecimal recentLowestPrice;

    /**
     * 近史低时间
     */
    private LocalDateTime recentLowestPriceTime;

    /**
     * 当前价格
     */
    private BigDecimal currentPrice;

    /**
     * 下次折扣价格
     */
    private BigDecimal nextDiscountPrice;

    /**
     * 下次折扣时间
     */
    private LocalDateTime nextDiscountTime;

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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }
    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }
    public BigDecimal getLowestPrice() {
        return lowestPrice;
    }

    public void setLowestPrice(BigDecimal lowestPrice) {
        this.lowestPrice = lowestPrice;
    }
    public LocalDateTime getLowestPriceTime() {
        return lowestPriceTime;
    }

    public void setLowestPriceTime(LocalDateTime lowestPriceTime) {
        this.lowestPriceTime = lowestPriceTime;
    }
    public BigDecimal getRecentLowestPrice() {
        return recentLowestPrice;
    }

    public void setRecentLowestPrice(BigDecimal recentLowestPrice) {
        this.recentLowestPrice = recentLowestPrice;
    }
    public LocalDateTime getRecentLowestPriceTime() {
        return recentLowestPriceTime;
    }

    public void setRecentLowestPriceTime(LocalDateTime recentLowestPriceTime) {
        this.recentLowestPriceTime = recentLowestPriceTime;
    }
    public BigDecimal getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(BigDecimal currentPrice) {
        this.currentPrice = currentPrice;
    }
    public BigDecimal getNextDiscountPrice() {
        return nextDiscountPrice;
    }

    public void setNextDiscountPrice(BigDecimal nextDiscountPrice) {
        this.nextDiscountPrice = nextDiscountPrice;
    }
    public LocalDateTime getNextDiscountTime() {
        return nextDiscountTime;
    }

    public void setNextDiscountTime(LocalDateTime nextDiscountTime) {
        this.nextDiscountTime = nextDiscountTime;
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
        return "GamePriceHistory{" +
            "id=" + id +
            ", gameId=" + gameId +
            ", originalPrice=" + originalPrice +
            ", lowestPrice=" + lowestPrice +
            ", lowestPriceTime=" + lowestPriceTime +
            ", recentLowestPrice=" + recentLowestPrice +
            ", recentLowestPriceTime=" + recentLowestPriceTime +
            ", currentPrice=" + currentPrice +
            ", nextDiscountPrice=" + nextDiscountPrice +
            ", nextDiscountTime=" + nextDiscountTime +
            ", status=" + status +
            ", version=" + version +
            ", createdAt=" + createdAt +
            ", updatedAt=" + updatedAt +
        "}";
    }
=======
    @ApiModelProperty("记录ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("原价")
    private BigDecimal originalPrice;

    @ApiModelProperty("史低价格")
    private BigDecimal lowestPrice;

    @ApiModelProperty("史低时间")
    private LocalDateTime lowestPriceTime;

    @ApiModelProperty("近史低价格")
    private BigDecimal recentLowestPrice;

    @ApiModelProperty("近史低时间")
    private LocalDateTime recentLowestPriceTime;

    @ApiModelProperty("当前价格")
    private BigDecimal currentPrice;

    @ApiModelProperty("下次折扣价格")
    private BigDecimal nextDiscountPrice;

    @ApiModelProperty("下次折扣时间")
    private LocalDateTime nextDiscountTime;

    @ApiModelProperty("状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;
>>>>>>> origin/sub3
}
