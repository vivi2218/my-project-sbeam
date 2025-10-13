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
@TableName("game_bundle")
=======
 * @author yourname
 * @since 2025-10-09
 */
@Getter
@Setter
@TableName("game_bundle")
@ApiModel(value = "GameBundle对象", description = "")
>>>>>>> origin/sub3
public class GameBundle implements Serializable {

    private static final long serialVersionUID = 1L;

<<<<<<< HEAD
    /**
     * 捆绑包ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 捆绑包名称
     */
    private String bundleName;

    /**
     * 游戏ID
     */
    private Integer gameId;

    /**
     * 优惠策略
     */
    private String discountPolicy;

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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    public String getBundleName() {
        return bundleName;
    }

    public void setBundleName(String bundleName) {
        this.bundleName = bundleName;
    }
    public Integer getGameId() {
        return gameId;
    }

    public void setGameId(Integer gameId) {
        this.gameId = gameId;
    }
    public String getDiscountPolicy() {
        return discountPolicy;
    }

    public void setDiscountPolicy(String discountPolicy) {
        this.discountPolicy = discountPolicy;
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
        return "GameBundle{" +
            "id=" + id +
            ", bundleName=" + bundleName +
            ", gameId=" + gameId +
            ", discountPolicy=" + discountPolicy +
            ", status=" + status +
            ", version=" + version +
            ", createdAt=" + createdAt +
            ", updatedAt=" + updatedAt +
        "}";
    }
=======
    @ApiModelProperty("捆绑包ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("捆绑包名称")
    private String bundleName;

    @ApiModelProperty("游戏ID")
    private Integer gameId;

    @ApiModelProperty("优惠策略")
    private String discountPolicy;

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
