package com.sbeam.sbeam.webSocket;

import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

import org.bouncycastle.jcajce.provider.asymmetric.dsa.DSASigner.stdDSA;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.io.IOException;
import jakarta.websocket.Session;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnOpen;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/ws/{userId}")
@Component
public class WebSocketServer {
    private static final ConcurrentHashMap<String, Session> SEESIONMAP = new ConcurrentHashMap<>();
    private static RedisTemplate<String, String> redisTemplate;

    @Autowired
    public void setRedisTemplate(RedisTemplate<String, String> redisTemplate) {
        WebSocketServer.redisTemplate = redisTemplate;
    }

    @OnOpen
    public void onOpen(Session session, @PathParam("userId") String userId) {
        SEESIONMAP.put(userId, session);
        System.out.println(userId + "已经连接");
        sendPendingMessages(userId);
    }

    @OnClose
    public void onClose(Session session, @PathParam("userId") String userId) {
        SEESIONMAP.remove(userId);
        System.out.println(userId + "已经断开");
    }

    @OnError
    public void onError(Session session, Throwable error) {

        System.out.println("发生错误" + error.getMessage());
    }

    public static void sendToUser(String userId, String message) {
        Session session = SEESIONMAP.get(userId);
        if (session != null && session.isOpen()) {
            try {
                session.getBasicRemote().sendText(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("用户 " + userId + " 不在线");
            // 把消息丢入redis
            redisTemplate.opsForList().rightPush(userId + ":pendingMessages", message);
        }
    }

    public static void sendPendingMessages(String userId) {
        List<String> messages = redisTemplate.opsForList().range(userId + ":pendingMessages", 0, -1);
        if (messages != null && !messages.isEmpty()) {
            for (String msg : messages) {
                sendToUser(userId, msg);
                redisTemplate.opsForList().remove(userId + ":pendingMessages", 1, msg);
            }
        }
    }

}
