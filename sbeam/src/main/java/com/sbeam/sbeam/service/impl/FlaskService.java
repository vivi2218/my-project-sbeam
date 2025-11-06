package com.sbeam.sbeam.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;

import java.util.HashMap;
import java.util.Map;

@Service
public class FlaskService {

    @Autowired
    private RestTemplate restTemplate;

    private final String FLASK_API_URL = "http://localhost:5000/recommend";  // Flask 服务地址

    // 调用 Flask 的推荐接口
    public Map<String, Object> getRecommendations(Long userId) {
        // 准备请求数据
        Map<String, Object> requestData = new HashMap<>();
        requestData.put("user_id", userId);  // 发送用户 ID 给 Flask 服务

        // 创建请求头
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);  // 设置请求头为 JSON

        // 创建请求体
        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(requestData, headers);

        // 发送 POST 请求到 Flask 服务
        ResponseEntity<Map> responseEntity = restTemplate.exchange(
                FLASK_API_URL, HttpMethod.POST, requestEntity, Map.class
        );

        // 获取 Flask 返回的推荐结果
        return responseEntity.getBody();
    }
}
