package com.sbeam.sbeam.webSocket;

import com.sbeam.sbeam.webSocket.WebSocketServer;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class MessageConsumer {

    /**
     * 监听系统通知队列
     */
    @RabbitListener(queues = "systemQue")
    public void handleSystemMessage(String message) {
        System.out.println("接收到系统通知：" + message);
        // 这里可以反序列化 message 得到 userId
        // 简单起见我们假设消息是 "userId:内容"
        String[] parts = message.split(":", 2);
        if (parts.length == 2) {
            String userId = parts[0];
            String content = parts[1];
            WebSocketServer.sendToUser(userId, "[系统通知] " + content);
        }
    }

    /**
     * 监听评论通知队列
     */
    @RabbitListener(queues = "commentQue")
    public void handleCommentMessage(String message) {
        System.out.println("接收到评论消息：" + message);
        String[] parts = message.split(":", 2);
        if (parts.length == 2) {
            String userId = parts[0];
            String content = parts[1];
            WebSocketServer.sendToUser(userId, "[评论提醒] " + content);
        }
    }

    /**
     * 监听点赞通知队列
     */
    @RabbitListener(queues = "likeQue")
    public void handleLikeMessage(String message) {
        System.out.println("接收到点赞消息：" + message);
        String[] parts = message.split(":", 2);
        if (parts.length == 2) {
            String userId = parts[0];
            String content = parts[1];
            WebSocketServer.sendToUser(userId, "[点赞提醒] " + content);
        }
    }
}
