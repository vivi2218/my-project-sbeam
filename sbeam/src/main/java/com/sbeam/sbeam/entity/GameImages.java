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
@TableName("game_images")
=======
 * @author yourname
 * @since 2025-10-09
 */
@Getter
@Setter
@TableName("game_images")
@ApiModel(value = "GameImages对象", description = "")
>>>>>>> origin/sub3
public class GameImages implements Serializable {

    private static final long serialVersionUID = 1L;

<<<<<<< HEAD
    /**
     * 游戏图片ID
     */
    @TableId(value = "image_id", type = IdType.AUTO)
    private Integer imageId;

    /**
     * 游戏ID
     */
    private Integer gameId;

    /**
     * 图片 URL
     */
    private String imageUrl;

    /**
     * 状态，0表示正常，1表示异常
     */
    private Integer status;

    /**
     * 版本控制
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

    public Integer getImageId() {
        return imageId;
    }

    public void setImageId(Integer imageId) {
        this.imageId = imageId;
    }
    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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
        return "GameImages{" +
            "imageId=" + imageId +
            ", gameId=" + gameId +
            ", imageUrl=" + imageUrl +
            ", status=" + status +
            ", version=" + version +
            ", createdAt=" + createdAt +
            ", updatedAt=" + updatedAt +
        "}";
    }
=======
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
>>>>>>> origin/sub3
}
