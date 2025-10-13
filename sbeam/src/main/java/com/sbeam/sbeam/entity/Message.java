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
@ApiModel(value = "Message对象", description = "")

public class Message implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("消息ID")
    @TableId(value = "message_id", type = IdType.AUTO)
    private Integer messageId;

    @ApiModelProperty("发件人ID")
    private Integer senderId;

    @ApiModelProperty("收件人ID")
    private Integer receiverId;

    @ApiModelProperty("消息内容")
    private String content;

    @ApiModelProperty("发送时间")
    private LocalDateTime sentTime;

    @ApiModelProperty("状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;
}
