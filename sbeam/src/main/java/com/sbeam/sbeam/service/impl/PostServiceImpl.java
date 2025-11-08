package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Community;
import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.Post;
import com.sbeam.sbeam.mapper.PostMapper;
import com.sbeam.sbeam.repository.PostRepository;
import com.sbeam.sbeam.service.ICommunityService;
import com.sbeam.sbeam.service.IPostService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class PostServiceImpl implements IPostService {

    // @Autowired
    // private PostMapper postMapper;

    @Autowired
    private PostRepository postRepository;

    @Override
    public List<MogoPost> getAllPosts() {
        return postRepository.findAll();
    }

    @Override
    public MogoPost getById(String id) {
        return postRepository.findById(id).orElse(null);
    }

    @Override
    public boolean save(MogoPost entity) {
        postRepository.save(entity);
        return true;
    }

    @Override
    public List<MogoPost> getReply(String id) {
        return postRepository.findByParentPostId(id);
    }

    @Override
    public MogoPost addReply( String id, MogoPost reply) {
        List<MogoPost> all = postRepository.findAll();
        for (MogoPost root : all) {
            MogoPost parent = findMygoPostById(root, id);
            if (parent != null) {
                if (parent.getReplies() == null)
                    parent.setReplies(new ArrayList<>());
                if (reply.getUserId() == null)
                    reply.setUserId(UUID.randomUUID().toString());
                parent.getReplies().add(reply);
                postRepository.save(root);
                return reply;
            }
        }
        return null;
    }
    
    @Override
    public MogoPost likePost(String id) {
        // 查找帖子
        MogoPost post = postRepository.findById(id).orElse(null);
        if (post != null) {
            // 获取当前点赞数并加1
            try {
                int currentLikes = Integer.parseInt(post.getLikeCount() != null ? post.getLikeCount() : "0");
                post.setLikeCount(String.valueOf(currentLikes + 1));
                // 保存更新后的帖子
                postRepository.save(post);
            } catch (NumberFormatException e) {
                // 如果点赞数格式错误，重置为1
                post.setLikeCount("1");
                postRepository.save(post);
            }
        }
        return post;
    }

    private MogoPost findMygoPostById(MogoPost parent, String id) {
        if (parent.getPostId() != null && parent.getPostId().equals(id)) {
            return parent;
        }
        if (parent.getReplies() != null) {
            for (MogoPost reply : parent.getReplies()) {
                MogoPost found = findMygoPostById(reply, id);// 对每一个子节点再次遍历
                if (found != null) {
                    return found;
                }
            }
        }
        return null;
    }

    @Autowired
    private ICommunityService communityService;

    @Override
    public List<MogoPost> getPostsByCommunityId(Integer communityId) {
        // 先通过communityId获取社区信息，得到社区名称
        Community community = communityService.getById(communityId);
        if (community == null) {
            return new ArrayList<>(); // 如果社区不存在，返回空列表
        }
        
        // 使用社区名称查询相关帖子
        return postRepository.findByCommunityName(community.getCommunityName());
    }

    @Override
    public List<MogoPost> getPostsByUserId(String userId) {
        return postRepository.findByUserId(userId);
    }



}
