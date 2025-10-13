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
@TableName("user_follow")
@ApiModel(value = "UserFollow对象", description = "")

public class UserFollow implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("关注ID")
    @TableId(value = "follow_id", type = IdType.AUTO)
    private Integer followId;

    @ApiModelProperty("用户ID")
    private Integer userId;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("关注时间")
    private LocalDateTime followTime;

    @ApiModelProperty("关注状态，0表示已关注，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
