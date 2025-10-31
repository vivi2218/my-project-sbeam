package com.sbeam.sbeam.controller;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;

import com.sbeam.sbeam.entity.Game;
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
        SearchResponse<Game> response = client.search(s -> s
                        .index("games")
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
                                )
                        )
                        .size(10),
                Game.class
        );

        List<Map<String, Object>> results = new ArrayList<>();
        for (Hit<Game> hit : response.hits().hits()) {
            Game g = hit.source();
            if (g != null) {
                results.add(Map.of(
                        "gameId", g.getGameId(),
                        "gameName", g.getGameName(),
                        "gameOriginalPrice", g.getGameOriginalPrice()
                ));
            }
        }

        return results;
    }
}
