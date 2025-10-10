package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author smith
 * @since 2025-10-07
 */
public class Sales implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 优惠ID
     */
    @TableId(value = "sales_id", type = IdType.AUTO)
    private Integer salesId;

    /**
     * 优惠名称
     */
    private String salesName;

    /**
     * 游戏ID
     */
    private Integer gameId;

    /**
     * 优惠描述
     */
    private String description;

    /**
     * 折扣率
     */
    private BigDecimal discountRate;

    /**
     * 优惠开始时间
     */
    private LocalDateTime startTime;

    /**
     * 优惠结束时间
     */
    private LocalDateTime endTime;

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

    public Integer getSalesId() {
        return salesId;
    }

    public void setSalesId(Integer salesId) {
        this.salesId = salesId;
    }
    public String getSalesName() {
        return salesName;
    }

    public void setSalesName(String salesName) {
        this.salesName = salesName;
    }
    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public BigDecimal getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(BigDecimal discountRate) {
        this.discountRate = discountRate;
    }
    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }
    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
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
        return "Sales{" +
            "salesId=" + salesId +
            ", salesName=" + salesName +
            ", gameId=" + gameId +
            ", description=" + description +
            ", discountRate=" + discountRate +
            ", startTime=" + startTime +
            ", endTime=" + endTime +
            ", status=" + status +
            ", version=" + version +
            ", createdAt=" + createdAt +
            ", updatedAt=" + updatedAt +
        "}";
    }
}
