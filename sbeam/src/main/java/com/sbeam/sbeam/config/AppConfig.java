package com.sbeam.sbeam.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class AppConfig {

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();  // 创建一个 RestTemplate 实例并作为 Bean 注册到 Spring 容器
    }
}
