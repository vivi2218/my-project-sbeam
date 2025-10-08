package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Getter
@Setter
@TableName("historical_orders")
@ApiModel(value = "HistoricalOrders对象", description = "")
public class HistoricalOrders implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("历史订单ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("订单ID")
    private Integer orderId;

    @ApiModelProperty("用户ID")
    private Integer userId;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("优惠ID")
    private Integer discountId;

    @ApiModelProperty("订单编号")
    private String orderNumber;

    @ApiModelProperty("原价")
    private BigDecimal originalPrice;

    @ApiModelProperty("最终价格")
    private BigDecimal finalPrice;

    @ApiModelProperty("订单日期")
    private LocalDateTime orderDate;

    @ApiModelProperty("订单状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;
}
