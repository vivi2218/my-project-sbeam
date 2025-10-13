package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
<<<<<<< HEAD
=======
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
>>>>>>> origin/sub3

/**
 * <p>
 * 
 * </p>
 *
<<<<<<< HEAD
 * @author smith
 * @since 2025-10-07
 */
@TableName("user_game_library")
=======
 * @author yourname
 * @since 2025-10-09
 */
@Getter
@Setter
@TableName("user_game_library")
@ApiModel(value = "UserGameLibrary对象", description = "")
>>>>>>> origin/sub3
public class UserGameLibrary implements Serializable {

    private static final long serialVersionUID = 1L;

<<<<<<< HEAD
    /**
     * 主键ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 游戏ID
     */
    private Integer gameId;

    /**
     * 来源：BUY=购买, GIFT=礼包
     */
    private String source;

    /**
     * 状态：0=正常, 1=异常
     */
    private Integer status;

    /**
     * 版本号（乐观锁）
     */
    private Integer version;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }
    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "UserGameLibrary{" +
            "id=" + id +
            ", userId=" + userId +
            ", gameId=" + gameId +
            ", source=" + source +
            ", status=" + status +
            ", version=" + version +
            ", createdAt=" + createdAt +
            ", updatedAt=" + updatedAt +
        "}";
    }
=======
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
>>>>>>> origin/sub3
}
