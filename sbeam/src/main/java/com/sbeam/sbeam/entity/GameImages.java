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
@TableName("game_images")
@ApiModel(value = "GameImages对象", description = "")

public class GameImages implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("游戏图片ID")
    @TableId(value = "image_id", type = IdType.AUTO)
    private Integer imageId;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("图片 URL")
    private String imageUrl;

    @ApiModelProperty("状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
