package com.sbeam.sbeam.service.impl;

import com.sbeam.sbeam.entity.Community;
import com.sbeam.sbeam.entity.UserCommunity;
import com.sbeam.sbeam.mapper.CommunityMapper;
import com.sbeam.sbeam.repository.UserCommunityRepository;
import com.sbeam.sbeam.service.ICommunityService;
import com.sbeam.sbeam.util.Result;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import io.jsonwebtoken.io.IOException;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@Service
public class CommunityServiceImpl extends ServiceImpl<CommunityMapper, Community> implements ICommunityService {
    @Autowired
    private CommunityMapper communityMapper;
    @Autowired
    private ElasticsearchClient esClient;
    @Autowired
    private UserCommunityRepository userCommunityRepository;

    @Override
    public List<Community> getAllCommunity() {
        return communityMapper.selectList(null);
    }

    @Override
    public List<Community> getByName(String name) {
        return communityMapper.getByName(name);
    }

    @Override
    public void syncAllCommunitiesToEs() {
        List<Community> communities = communityMapper.selectList(null); // 从数据库取全部社区
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        for (Community community : communities) {
            try {
                Map<String, Object> doc = new HashMap<>();
                doc.put("communityId", community.getCommunityId());
                doc.put("communityName", community.getCommunityName());
                doc.put("communityDescription", community.getCommunityDescription());
                doc.put("status", community.getStatus());
                doc.put("version", community.getVersion());
                doc.put("createdAt",
                        community.getCreatedAt() != null ? community.getCreatedAt().format(formatter) : null);
                doc.put("updatedAt",
                        community.getUpdatedAt() != null ? community.getUpdatedAt().format(formatter) : null);

                esClient.index(idx -> idx
                        .index("communities") // Elasticsearch 索引名
                        .id(String.valueOf(community.getCommunityId()))
                        .document(doc));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void addUserToCommunity(String userId, String communityId) {
        UserCommunity userCommunity = new UserCommunity();
        userCommunity.setUserId(userId);
        userCommunity.setCommunityId(communityId);


        userCommunityRepository.save(userCommunity);
    }

    @Override
    public List<Community> getCommunitiesByUserId(String userId) {
        List<String> communityIds = userCommunityRepository.findAll().stream()
                .filter(uc -> uc.getUserId().equals(userId))
                .map(UserCommunity::getCommunityId)
                .toList();
        List<Community> communities = new ArrayList<>();
        for (String communityId : communityIds) {
            Community community = communityMapper.selectById(communityId);
            if (community != null) {
                communities.add(community);
            }
        }
        return communities;
    }

}
