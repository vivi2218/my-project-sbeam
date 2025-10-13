package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
@ApiModel(value = "Cart对象", description = "")

public class Cart implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("购物车ID")
    @TableId(value = "cart_id", type = IdType.AUTO)
    private Integer cartId;

    @ApiModelProperty("用户ID")
    private Integer userId;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("游戏名称")
    private String gameName;

    @ApiModelProperty("游戏加入购物车时的价格")
    private BigDecimal gamePrice;

    @ApiModelProperty("折扣ID")
    private Integer salesId;

    @ApiModelProperty("购物车状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
