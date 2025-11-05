package com.sbeam.sbeam.service.impl;

import java.util.UUID;
import java.util.concurrent.TimeUnit;

import com.sbeam.sbeam.util.RedisLuaExecutor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.sbeam.sbeam.service.IdempotentTokenService;

@Service
public class IdempotentTokenServiceImpl implements IdempotentTokenService{

    @Autowired
    private RedisTemplate<String,Object> redisTemplate;
    @Autowired
    private RedisLuaExecutor redisLuaExecutor;

    private static final String PREFIX="idempotent:token:";

    @Override
    public String createToken(Integer userId) {
        String token = UUID.randomUUID().toString().replace("-", "");
        String key = PREFIX +token;

        // 绑定唯一value，保证安全性（格式：userId:uuid）
        String value = userId + ":" + UUID.randomUUID();

        redisTemplate.opsForValue().set(key, value,5,TimeUnit.MINUTES);
        return token + ":" + value;
    }

    /**
     * 校验token（使用Lua原子脚本，安全版）
     * @param token  前端传入的token
     * @param value  前端传入的value（userId:uuid）
     */
    @Override
    public boolean checkToken(String token,String value) {
        System.out.println("token:"+token);
        if (token==null||token.equals("")||value==null||value.equals("")) {
            System.out.println("token null or value null");
            return false;
        }
        String key = PREFIX +token;
        Object redisVal = redisTemplate.opsForValue().get(key);
        System.out.println("Redis中key = " + key);
        System.out.println("Redis中值 = " + redisVal);
        System.out.println("传入的value = " + value);
        //使用Lua执行原子检查  +  删除
        Long result = redisLuaExecutor.execute("script/check_and_del_token.lua",Long.class, key, value);
        System.out.println("Lua执行结果 = " + result);
        //返回1表示校验通过且已删除
        if (result != null && result == 1L) {
            System.out.println("✅ 幂等验证通过");
            return true;
        } else {
            System.out.println("❌ 幂等验证失败");
            return false;
        }
    }
}
