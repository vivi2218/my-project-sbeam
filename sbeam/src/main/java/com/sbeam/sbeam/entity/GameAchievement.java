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
@TableName("game_achievement")
@ApiModel(value = "GameAchievement对象", description = "")

public class GameAchievement implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("成就ID")
    @TableId(value = "achievement_id", type = IdType.AUTO)
    private Integer achievementId;

    @ApiModelProperty("游戏名称")
    private String gameName;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("成就名称")
    private String achievementName;

    @ApiModelProperty("成就描述")
    private String achievementDescription;

    @ApiModelProperty("状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
