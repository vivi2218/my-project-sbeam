package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
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
@TableName("user_profile")
@ApiModel(value = "UserProfile对象", description = "")
public class UserProfile implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("用户详情ID")
    @TableId(value = "user_profile_id", type = IdType.AUTO)
    private Integer userProfileId;

    @ApiModelProperty("用户ID")
    private Integer userId;

    @ApiModelProperty("年龄")
    private Integer age;

    @ApiModelProperty("性别")
    private String gender;

    @ApiModelProperty("生日")
    private LocalDate birthday;

    @ApiModelProperty("国家")
    private String country;

    @ApiModelProperty("个人简介")
    private String bio;

    @ApiModelProperty("用户设备")
    private String userDevice;

    @ApiModelProperty("头像 URL")
    private String avatarUrl;

    @ApiModelProperty("用户状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;
}
