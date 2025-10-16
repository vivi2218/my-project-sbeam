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
@ApiModel(value = "Sales对象", description = "")

public class Sales implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("优惠ID")
    @TableId(value = "sales_id", type = IdType.AUTO)
    private Integer salesId;

    @ApiModelProperty("优惠名称")
    private String salesName;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("优惠描述")
    private String description;

    @ApiModelProperty("折扣率")
    private BigDecimal discountRate;

    @ApiModelProperty("优惠开始时间")
    private LocalDateTime startTime;

    @ApiModelProperty("优惠结束时间")
    private LocalDateTime endTime;

    @ApiModelProperty("状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
