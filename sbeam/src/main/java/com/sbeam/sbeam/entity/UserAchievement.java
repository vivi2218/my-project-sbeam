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
@TableName("user_achievement")
@ApiModel(value = "UserAchievement对象", description = "")

public class UserAchievement implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("用户成就ID")
    @TableId(value = "user_achievement_id", type = IdType.AUTO)
    private Integer userAchievementId;

    @ApiModelProperty("用户ID")
    private Integer userId;

    @ApiModelProperty("成就ID")
    private Integer achievementId;

    @ApiModelProperty("达成日期")
    private LocalDateTime achievedAt;

    @ApiModelProperty("状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
