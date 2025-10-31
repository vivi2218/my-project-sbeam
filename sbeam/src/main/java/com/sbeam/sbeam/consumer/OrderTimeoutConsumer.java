package com.sbeam.sbeam.consumer;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rabbitmq.client.Channel;
import com.sbeam.sbeam.entity.Myorder;
import com.sbeam.sbeam.service.IMyorderService;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;

@Component
public class OrderTimeoutConsumer {
    @Autowired
    private IMyorderService myorderService;
    @Autowired
    private ObjectMapper objectMapper;  // 用于解析JSON

    @RabbitListener(queues = "sbeam-delayed-queue")
    @RabbitHandler
    public void handleOrderTimeout( Message message,Channel channel){
        try{
            // 解析消息体
            Map<String, Object> messageBody= objectMapper.readValue(message.getBody(), Map.class);
            Integer orderId = (Integer)messageBody.get("orderId");
            Long timestamp = (Long) messageBody.get("timestamp");

            //根据orderId查询订单,status=paid,则跳出取消服务
            Myorder myorder = myorderService.getById(orderId);
            if(myorder == null){
                System.out.println("订单不存在,ID:"+ orderId);
                return;
            }
            // 2. 校验订单状态（仅处理“未支付”的订单）
            if("paid".equals(myorder.getOrderStatus())){
                System.out.println("订单已支付,无需取消,ID:"+ orderId);
                return;
            }
            if("cancelled".equals(myorder.getOrderStatus())){
                System.out.println("订单已取消,ID:"+ orderId);
                return;
            }

            // 3. 执行取消逻辑（如关闭订单、释放库存等）
            //处理订单取消
            System.out.println("收到订单超时消息,开始处理...订单ID:"+orderId);
            myorderService.cancelOrderDueToTimeout(orderId);
            channel.basicAck(message.getMessageProperties().getDeliveryTag(),false);
        }catch (Exception e){
            System.out.println("处理订单超时消息失败: " + e.getMessage());
            //添加重试逻辑或者,记录日志
            try {//不确认消息重新投递
                channel.basicNack(message.getMessageProperties().getDeliveryTag(),false,true);
            } catch (IOException ex) {
                System.out.println("消息重试确认失败: " + ex.getMessage());
            }
        }
    }
}
