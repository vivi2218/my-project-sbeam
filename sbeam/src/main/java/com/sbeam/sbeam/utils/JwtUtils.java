package com.sbeam.sbeam.utils;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;

public class JwtUtils {
    private static final String SECRET = "ChangeThisVerySecretAndLongEnough1234567890";
    private static final long EXPIRATION = 3600_000; // 1小时

    public static String generateToken(Integer userId, String username) {
        return Jwts.builder()
                .setSubject(String.valueOf(userId))
                .claim("username", username)
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION))
                .signWith(SignatureAlgorithm.HS256, SECRET)
                .compact();
    }

    // 解析 token
    public static Long getUserId(String token) {
        return Long.parseLong(Jwts.parser().setSigningKey(SECRET)
                .parseClaimsJws(token)
                .getBody()
                .getSubject());
    }
}
