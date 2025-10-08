package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
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
@TableName("game_profile")
@ApiModel(value = "GameProfile对象", description = "")
public class GameProfile implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("游戏详情ID")
    @TableId(value = "game_profile_id", type = IdType.AUTO)
    private Integer gameProfileId;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("游戏名称")
    private String gameName;

    @ApiModelProperty("游戏简介")
    private String gameDescription;

    @ApiModelProperty("游戏开发商")
    private String gameDeveloper;

    @ApiModelProperty("游戏标签名称")
    private String gameTagName;

    @ApiModelProperty("游戏配置")
    private String gameConfig;

    @ApiModelProperty("游戏系列")
    private String series;

    @ApiModelProperty("状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;
}
