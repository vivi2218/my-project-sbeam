package com.sbeam.sbeam.service;

import com.sbeam.sbeam.entity.Cart;
import com.sbeam.sbeam.entity.VO.OrderEvent;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * MQ消息发送器
 * 用于发送订单事件到MQ队列
 */
@Component
public class MqSender {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    /**
     * 发送订单创建事件到MQ队列
     * @param //
     */
    public void sendOrderEvent(Integer userId, List<Cart> cartList) {
        OrderEvent event = new OrderEvent();
        event.setUserId(userId);
        event.setCartList(cartList);
        //event.setPollingKey(pollingKey);
        rabbitTemplate.convertAndSend(
                "orderExc",
                "order.key",
                event
        );
        System.out.println("发送订单创建事件到MQ队列，用户ID: " + event.getUserId());
    }
}