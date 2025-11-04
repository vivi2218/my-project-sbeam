package com.sbeam.sbeam.webSocket;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessagePushService {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    /**
     * 发送消息到 RabbitMQ
     * @param userId 接收方ID
     * @param content 消息内容
     */
    public void notifyUser(String userId, String content) {
        String message = userId + ":" + content;
        // 发送到交换机 commentExc，路由键 comment.key
        rabbitTemplate.convertAndSend("commentExc", "comment.key", message);
        System.out.println("消息已发送到 RabbitMQ -> " + message);
    }
}
