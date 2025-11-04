package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.MogoPost;
import com.sbeam.sbeam.entity.Post;
import com.sbeam.sbeam.mapper.PostMapper;
import com.sbeam.sbeam.repository.PostRepository;
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



}
