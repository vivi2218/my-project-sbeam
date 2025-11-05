package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author smith
 * @since 2025-10-31
 */
@TableName("order_history")
public class OrderHistory implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 历史订单id
     */
    @TableId(value = "order_history_id",type = IdType.AUTO)
    private Integer orderHistoryId;

    /**
     * 订单ID
     */
    private Integer orderId;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 购物车ID
     */
    private Integer cartId;

    /**
     * 订单编号
     */
    private String orderNumber;

    /**
     * 订单原始价格
     */
    private BigDecimal originalPrice;

    /**
     * 订单最终价格
     */
    private BigDecimal finalPrice;

    /**
     * 订单日期
     */
    private LocalDateTime orderDate;

    /**
     * 订单状态
     */
    private String orderStatus;

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

    /**
     * 迁移的时间
     */
    private LocalDateTime addTime;

    public Integer getOrderHistoryId() {
        return orderHistoryId;
    }

    public void setOrderHistoryId(Integer orderHistoryId) {
        this.orderHistoryId = orderHistoryId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    public BigDecimal getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = finalPrice;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
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

    public LocalDateTime getAddTime() {
        return addTime;
    }

    public void setAddTime(LocalDateTime addTime) {
        this.addTime = addTime;
    }

    @Override
    public String toString() {
        return "OrderHistory{" +
            "orderHistoryId = " + orderHistoryId +
            ", orderId = " + orderId +
            ", userId = " + userId +
            ", cartId = " + cartId +
            ", orderNumber = " + orderNumber +
            ", originalPrice = " + originalPrice +
            ", finalPrice = " + finalPrice +
            ", orderDate = " + orderDate +
            ", orderStatus = " + orderStatus +
            ", status = " + status +
            ", version = " + version +
            ", createdAt = " + createdAt +
            ", updatedAt = " + updatedAt +
            ", addTime = " + addTime +
        "}";
    }
}
