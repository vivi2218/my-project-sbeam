package com.sbeam.sbeam.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
public class RedisConfig {

    // 1. 配置 Redis 连接工厂（支持从配置文件读取地址和端口）
    @Bean
    public LettuceConnectionFactory redisConnectionFactory() {
        // 默认连接 localhost:6379，若有自定义配置，可在此修改
        // 例如：连接远程 Redis（192.168.1.100:6380）
        // return new LettuceConnectionFactory("192.168.1.100", 6380);

        // 推荐：从配置文件读取（需在 application.properties 中配置）
        // 无需手动 new，Spring 会自动根据配置文件参数初始化
        return new LettuceConnectionFactory();
    }

    // 2. 配置 RedisTemplate，解决序列化问题
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);

        // key 序列化：用 String 类型（必须，Redis 键通常是字符串）
        template.setKeySerializer(new StringRedisSerializer());
        template.setHashKeySerializer(new StringRedisSerializer());

        // value 序列化：用 JSON 序列化器（支持所有类型，包括 Integer、对象等）
        GenericJackson2JsonRedisSerializer jsonSerializer = new GenericJackson2JsonRedisSerializer();
        template.setValueSerializer(jsonSerializer);
        template.setHashValueSerializer(jsonSerializer);

        // 初始化参数
        template.afterPropertiesSet();
        return template;
    }
}