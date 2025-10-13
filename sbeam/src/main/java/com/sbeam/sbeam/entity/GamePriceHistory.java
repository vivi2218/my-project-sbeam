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
@TableName("game_price_history")
@ApiModel(value = "GamePriceHistory对象", description = "")

public class GamePriceHistory implements Serializable {

    private static final long serialVersionUID = 1L;


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

}
