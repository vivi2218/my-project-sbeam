package com.sbeam.sbeam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author smith
 * @since 2025-10-07
 */
public class Post implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 帖子ID
     */
    @TableId(value = "post_id", type = IdType.AUTO)
    private Integer postId;

    /**
     * 社区ID
     */
    private Integer communityId;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 帖子标题
     */
    private String postTitle;

    /**
     * 帖子内容
     */
    private String postContent;

    /**
     * 父帖子ID
     */
    private Integer parentPostId;

    /**
     * 点赞数
     */
    private Integer likeCount;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;

    /**
     * 状态，0表示正常，1表示异常
     */
    private Integer status;

    /**
     * 版本控制
     */
    private Integer version;

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }
    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }
    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }
    public Integer getParentPostId() {
        return parentPostId;
    }

    public void setParentPostId(Integer parentPostId) {
        this.parentPostId = parentPostId;
    }
    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
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

    @Override
    public String toString() {
        return "Post{" +
            "postId=" + postId +
            ", communityId=" + communityId +
            ", userId=" + userId +
            ", postTitle=" + postTitle +
            ", postContent=" + postContent +
            ", parentPostId=" + parentPostId +
            ", likeCount=" + likeCount +
            ", createdAt=" + createdAt +
            ", updatedAt=" + updatedAt +
            ", status=" + status +
            ", version=" + version +
        "}";
    }
}
