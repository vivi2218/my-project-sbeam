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
@ApiModel(value = "Community对象", description = "")

public class Community implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty("社区ID")
    @TableId(value = "community_id", type = IdType.AUTO)
    private Integer communityId;

    @ApiModelProperty("社区名称")
    private String communityName;

    @ApiModelProperty("社区描述")
    private String communityDescription;

    @ApiModelProperty("状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
