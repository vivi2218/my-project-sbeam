package com.sbeam.sbeam.util;

import org.springframework.core.io.ClassPathResource;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Component
public class RedisLuaExecutor {


    private final StringRedisTemplate stringRedisTemplate;

    public RedisLuaExecutor(StringRedisTemplate stringRedisTemplate) {
        this.stringRedisTemplate = stringRedisTemplate;
    }

    /**
     * 执行Lua脚本（单key版）
     * @param scriptPath 脚本路径（classpath 下）
     * @param resultType 返回类型（例如 Long.class、Boolean.class）
     * @param key Redis键
     * @param args 可变参数，对应 ARGV
     */
    public <T> T execute(String scriptPath, Class<T> resultType, String key, Object... args) {
        // 把所有参数强制转为字符串
        String[] stringArgs = Arrays.stream(args)
                .map(Object::toString)
                .toArray(String[]::new);
        return execute(scriptPath, resultType, Collections.singletonList(key), stringArgs);
    }

    /**
     * 执行Lua脚本（多key版）
     * @param scriptPath 脚本路径（classpath 下）
     * @param resultType 返回类型（例如 Long.class、Boolean.class）
     * @param keys Redis键列表
     * @param args 可变参数，对应 ARGV
     */
    public <T> T execute(String scriptPath, Class<T> resultType, List<String> keys, Object... args) {
        DefaultRedisScript<T> script = new DefaultRedisScript<>();
        script.setLocation(new ClassPathResource(scriptPath));
        script.setResultType(resultType);
        return stringRedisTemplate.execute(script, keys, args);
    }
}