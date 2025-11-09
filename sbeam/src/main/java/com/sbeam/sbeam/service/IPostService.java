package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.Post;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * 
 * @author yourname
 * @since 2025-10-09
 */
public interface IPostService {

    List<MogoPost> getAllPosts();

    MogoPost getById(String id);

    boolean save(MogoPost entity);

    List<MogoPost> getReply(String id);

    MogoPost addReply(String id, MogoPost reply);
    
    /**
     * 点赞帖子
     * @param id 帖子ID
     * @return 点赞后的帖子对象
     */
    MogoPost likePost(String id);
    
    /**
     * 根据社区ID获取帖子列表
     * @param communityId 社区ID
     * @return 帖子列表
     */
    List<MogoPost> getPostsByCommunityId(Integer communityId);

    List<MogoPost> getPostsByUserId(String userId);

}
