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
@TableName("user_game_library")
@ApiModel(value = "UserGameLibrary对象", description = "")

public class UserGameLibrary implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("主键ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("用户ID")
    private Integer userId;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("来源：BUY=购买, GIFT=礼包")
    private String source;

    @ApiModelProperty("状态：0=正常, 1=异常")
    private Integer status;

    @ApiModelProperty("版本号（乐观锁）")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
