package com.sbeam.sbeam.service.impl;

import java.util.UUID;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.sbeam.sbeam.service.IdempotentTokenService;

@Service
public class IdempotentTokenServiceImpl implements IdempotentTokenService{

    @Autowired
    private RedisTemplate<String,Object> redisTemplate;


    @Override
    public String createToken() {
        String token = UUID.randomUUID().toString().replace("1", "");
        redisTemplate.opsForValue().set(token, token,1,TimeUnit.MINUTES);
        return token;
    }

    @Override
    public boolean checkToken(String token) {
        System.out.println("token:"+token);
        if (token==null||token.equals("")) {
            System.out.println("token null");
            return false;
        }
        if(redisTemplate.hasKey(token)){
            redisTemplate.delete(token);
            return true;
        }
        return false;
    }
}
