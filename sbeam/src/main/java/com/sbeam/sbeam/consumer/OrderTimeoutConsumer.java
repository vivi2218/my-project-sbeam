package com.sbeam.sbeam.consumer;

import com.sbeam.sbeam.service.IMyorderService;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class OrderTimeoutConsumer {
    @Autowired
    private IMyorderService myorderService;

    @RabbitListener(queues = "orderTimeoutQueue")
    @RabbitHandler
    public void handleOrderTimeout(Map<String,Object> message){
        try{
            Integer orderId= (Integer) message.get("orderId");
            Long timestamp = (Long) message.get("timestamp");
            System.out.println("收到订单超时消息,订单ID:"+orderId);

            //处理订单取消
            myorderService.cancelOrderDueToTimeout(orderId);
        }catch (Exception e){
            System.out.println("处理订单超时消息失败: " + e.getMessage());
            //添加重试逻辑或者,记录日志
        }
    }
}
