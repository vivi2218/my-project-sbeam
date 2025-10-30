package com.sbeam.sbeam.service;

import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;

import io.jsonwebtoken.io.IOException;
import jakarta.websocket.Session;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnOpen;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("ws/{userId}")
@Component
public class WebSocketServer {
    private static final ConcurrentHashMap<String, Session> SEESIONMAP = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("userId") String userId) {
        SEESIONMAP.put(userId, session);
        System.out.println(userId + "已经连接");
    }

    @OnClose
    public void OnClose(Session session, @PathParam("serId") String userId) {
        SEESIONMAP.remove(userId);
        System.out.println(userId + "已经断开");
    }

    @OnError
    public void OnClose(Session session, Throwable error) {

        System.out.println("发生错误" + error.getMessage());
    }

    public static void sendToUser(String userId, String message) {
        Session session = SEESIONMAP.get(userId);
        if (session != null && session.isOpen()) {
            try {
                session.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            } catch (java.io.IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        } else {
            System.out.println("用户 " + userId + " 不在线");
        }
    }

}
