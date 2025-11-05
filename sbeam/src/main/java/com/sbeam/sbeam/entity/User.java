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
<
 * @author yourname
 * @since 2025-10-09
 */
@Getter
@Setter
@ApiModel(value = "User对象", description = "")

public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    // 新增 Steam 账号相关字段
    @ApiModelProperty("Steam ID")
    private String steamId;


    @ApiModelProperty("用户ID")
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer userId;

    @ApiModelProperty("用户名")
    private String userName;

    @ApiModelProperty("用户邮箱")
    private String email;

    @ApiModelProperty("用户密码")
    private String password;

    @ApiModelProperty("注册时间")
    private LocalDateTime registerTime;

    @ApiModelProperty("用户状态，0表示正常，1表示异常")
    private Integer status;

    @ApiModelProperty("手机号")
    private Long phoneNumber;

    @ApiModelProperty("用户角色（游客、普通用户、管理员）")
    private String role;

    @ApiModelProperty("版本控制")
    private Integer version;

    @ApiModelProperty("创建时间")
    private LocalDateTime createdAt;

    @ApiModelProperty("更新时间")
    private LocalDateTime updatedAt;

}
