package com.sbeam.sbeam.controller;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;

import com.sbeam.sbeam.entity.Game;
import com.sbeam.sbeam.entity.Community;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin
@RequestMapping("search")
public class SearchController {

    private final ElasticsearchClient client;


    public SearchController(ElasticsearchClient client) {
        this.client = client;
    }
    @GetMapping
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
}
