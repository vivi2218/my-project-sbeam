package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
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
@ApiModel(value = "Game对象", description = "")

public class Game implements Serializable {

    private static final long serialVersionUID = 1L;


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

}
