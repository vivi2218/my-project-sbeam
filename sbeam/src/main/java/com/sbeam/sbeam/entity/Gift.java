package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
@ApiModel(value = "Gift对象", description = "")

public class Gift implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("礼物ID")
    @TableId(value = "gift_id", type = IdType.AUTO)
    private Integer giftId;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("赠送者ID")
    private Integer user1Id;

    @ApiModelProperty("接收者ID")
    private Integer user2Id;

    @ApiModelProperty("寄语")
    private String message;

    @ApiModelProperty("状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
