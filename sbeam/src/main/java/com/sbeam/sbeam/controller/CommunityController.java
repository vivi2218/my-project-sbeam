package com.sbeam.sbeam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sbeam.sbeam.entity.Comment;
import com.sbeam.sbeam.entity.Community;
import com.sbeam.sbeam.entity.Game;
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
    public Community getCommunityByName(@PathVariable String name) {
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

}
