package com.sbeam.sbeam.controller;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;

import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.entity.Community;
import com.sbeam.sbeam.service.ICommunityService;
import com.sbeam.sbeam.service.IGameService;
import org.checkerframework.checker.fenum.qual.AwtAlphaCompositingRule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@CrossOrigin
@RequestMapping("search")
public class SearchController {

    private final ElasticsearchClient client;

    @Autowired
    private IGameService gameService;

    @Autowired
    private ICommunityService communityService;





    public SearchController(ElasticsearchClient client) {
        this.client = client;
    }
    @GetMapping("/search")
    public List<Map<String, Object>> search(@RequestParam String keyword) throws IOException {
        // 查询 games 和 communitys 两个索引
        SearchResponse<Map> response = client.search(s -> s
                        .index("games", "communities")
                        .query(q -> q
                                .bool(b -> b
                                        .should(sh -> sh
                                                .matchPhrasePrefix(m -> m
                                                        .field("gameName")
                                                        .query(keyword)
                                                )
                                        )
                                        .should(sh -> sh
                                                .wildcard(w -> w
                                                        .field("gameName.keyword")
                                                        .value("*" + keyword.toLowerCase() + "*")
                                                )
                                        )
                                        // 论坛社区名称和描述也支持搜索
                                        .should(sh -> sh
                                                .matchPhrasePrefix(m -> m
                                                        .field("communityName")
                                                        .query(keyword)
                                                )
                                        )
                                        .should(sh -> sh
                                                .wildcard(w -> w
                                                        .field("communityName.keyword")
                                                        .value("*" + keyword.toLowerCase() + "*")
                                                )
                                        )
                                        .should(sh -> sh
                                                .matchPhrasePrefix(m -> m
                                                        .field("communityDescription")
                                                        .query(keyword)
                                                )
                                        )
                                )
                        )
                        .size(10),
                Map.class
        );

        List<Map<String, Object>> results = new ArrayList<>();
        for (Hit<Map> hit : response.hits().hits()) {
            Map<String, Object> source = hit.source();
            if (source == null) continue;
            String index = hit.index();
            if ("games".equals(index)) {
                // 游戏类型
                results.add(Map.of(
                        "type", "game",
                        "gameId", source.get("gameId"),
                        "gameName", source.get("gameName"),
                        "gameOriginalPrice", source.get("gameOriginalPrice")
                ));
            } else if ("communities".equals(index)) {
                // 论坛类型
                results.add(Map.of(
                        "type", "community",
                        "communityId", source.get("communityId"),
                        "communityName", source.get("communityName"),
                        "communityDescription", source.get("communityDescription")
                ));
            }
        }
        return results;
    }




    @GetMapping
    public List<SearchResult> searchAll(@RequestParam String keyword) {
        List<SearchResult> results = new ArrayList<>();

        // 搜索游戏
        List<Game> games = gameService.lambdaQuery()
                .like(Game::getGameName, keyword)
                .eq(Game::getStatus, 0)
                .list();

        for (Game g : games) {
            results.add(new SearchResult(
                    "game",
                    g.getGameId(),
                    g.getGameName(),
                    "/gaming/" + g.getGameId() + ".jpg"
            ));
        }

        // 搜索社区
        List<Community> communities = communityService.lambdaQuery()
                .like(Community::getCommunityName, keyword)
                .list();

        for (Community c : communities) {
            results.add(new SearchResult(
                    "community",
                    c.getCommunityId(),
                    c.getCommunityName(),
                    null // 社区暂时没有图片
            ));
        }

        // 如果需要搜索帖子或其他类型，可以在这里继续添加

        return results;
    }

    // 内部 DTO
    public static class SearchResult {
        private String type; // game, community, post ...
        private Integer id;  // gameId 或 communityId
        private String name;
        private String imageUrl; // 游戏图片或社区头像

        public SearchResult(String type, Integer id, String name, String imageUrl) {
            this.type = type;
            this.id = id;
            this.name = name;
            this.imageUrl = imageUrl;
        }

        // getter & setter
        public String getType() { return type; }
        public void setType(String type) { this.type = type; }
        public Integer getId() { return id; }
        public void setId(Integer id) { this.id = id; }
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        public String getImageUrl() { return imageUrl; }
        public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    }
}
