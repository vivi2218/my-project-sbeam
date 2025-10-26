package com.sbeam.sbeam.util;

import com.sbeam.sbeam.entity.User;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import jakarta.annotation.PostConstruct;
import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Date;
import java.util.UUID;

@Component
public class JWTUtils {

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.expiration:3600}") // seconds
    private long expiration;

    private SecretKey key;

    private final RedisTemplate<String, Object> redisTemplate;

    public JWTUtils(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @PostConstruct
    public void init() {
        key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    // 返回原始 token（不带 Bearer 前缀）
    public String generateToken(User user) {
        long now = System.currentTimeMillis();
        String jti = UUID.randomUUID().toString();
        Claims claims = Jwts.claims()
                .setId(jti)
                .setSubject(String.valueOf(user.getUserId()))
                .setIssuedAt(new Date(now))
                .setExpiration(new Date(now + expiration * 1000 * 60 * 360));
        claims.put("username", user.getUserName());
        String token = Jwts.builder()
                .setClaims(claims)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();

        // 存 Redis：token:{jti} -> userId
        String tokenKey = "token:" + jti;
        redisTemplate.opsForValue().set(tokenKey, String.valueOf(user.getUserId()), Duration.ofSeconds(expiration));

        // 可选：记录 user -> jti（单设备登录场景）
        redisTemplate.opsForValue().set("user_token:" + user.getUserId(), jti, Duration.ofSeconds(expiration));
        return token;
    }

    public Jws<Claims> parseToken(String token) {
        return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
    }

    public boolean validateToken(String token) {
        try {
            Jws<Claims> jws = parseToken(token);
            String jti = jws.getBody().getId();
            String tokenKey = "token:" + jti;
            Object v = redisTemplate.opsForValue().get(tokenKey);
            return v != null;
        } catch (JwtException | IllegalArgumentException ex) {
            return false;
        }
    }

    public String getUserIdFromToken(String token) {
        try {
            Claims c = parseToken(token).getBody();
            return c.getSubject();
        } catch (Exception e) {
            return null;
        }
    }

    public void invalidateToken(String token) {
        try {
            Claims c = parseToken(token).getBody();
            String jti = c.getId();
            String tokenKey = "token:" + jti;
            redisTemplate.delete(tokenKey);
            // remove user_token if equals
            String uid = c.getSubject();
            Object cur = redisTemplate.opsForValue().get("user_token:" + uid);
            if (cur != null && cur.toString().equals(jti)) {
                redisTemplate.delete("user_token:" + uid);
            }
        } catch (Exception ignored) {}
    }

    // 可选：手动刷新（返回新 token）
    public String refreshToken(String oldToken, User user) {
        invalidateToken(oldToken);
        return generateToken(user);
    }



    public Long  getUserId(String token) {
        if (token == null || token.isEmpty()) {
            return null;
        }

        try {
            // 1 移除 Bearer 前缀
            if (token.startsWith("Bearer ")) {
                token = token.substring(7);
            }

            //  解析 Token
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();

            //  从 subject 中拿 userId
            return Long.valueOf(claims.getSubject());

        } catch (JwtException | IllegalArgumentException e) {
            System.out.println("JWT解析失败: " + e.getMessage());
            return null;
        }
    }

}