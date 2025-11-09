package com.sbeam.sbeam.controller;

import java.util.List;

import com.sbeam.sbeam.entity.*;
import com.sbeam.sbeam.repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.service.ICommunityService;
import com.sbeam.sbeam.service.IGameService;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author yourname
 * @since 2025-10-09
 */
@RestController
@RequestMapping("/community")
@CrossOrigin
public class CommunityController {
    @Autowired
    private ICommunityService communityService;
    @Autowired
    private IGameService gameService;
    @Autowired
    private PostRepository postRepository;

    @GetMapping("id/{id}")
    public Community getCommunityById(@PathVariable Integer id) {
        return communityService.getById(id);
    }

    @GetMapping
    public List<Community> getAllCommunity() {
        return communityService.getAllCommunity();
    }

    @PostMapping
    public boolean createCommunity(@RequestBody Community entity) {
        return communityService.save(entity);
    }

    @GetMapping("name/{name}")
    public List<Community> getCommunityByName(@PathVariable String name) {
        return communityService.getByName(name);
    }

    @PostMapping("/syncEs")
    public void syncAllCommunitiesToEs() {
        communityService.syncAllCommunitiesToEs();
    }

    // @PostMapping("/quickAdd")
    public void quickAdd(){
        List<Game> games = gameService.listAllGames();
        for (Game game : games) {
            Community community = new Community();
            community.setCommunityName(game.getGameName());
            community.setCommunityDescription("这是" + game.getGameName() + "的讨论组!");
            communityService.save(community);
        }
    }

    @PostMapping("/join/{communityId}")
    public void join(@PathVariable String communityId, @RequestParam String userId) {
        communityService.addUserToCommunity(userId, communityId);
    }

    @GetMapping("/user/{userId}")
    public List<Community> getCommunitiesByUserId(@PathVariable String userId) {
        return communityService.getCommunitiesByUserId(userId);
    }

    /**
     * 根据社区名称查询帖子（MongoDB版本）
     */
    @GetMapping("/getbycname")
    public List<MogoPost> getAllPostByCName(@RequestParam String communityName) {
        // 调用Repository的方法（Spring Data自动实现查询）
        return postRepository.findByCommunityName(communityName);
    }
}
