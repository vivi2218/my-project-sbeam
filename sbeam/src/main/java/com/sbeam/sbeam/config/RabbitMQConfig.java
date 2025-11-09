package com.sbeam.sbeam.config;

import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableRabbit//开启对RabbitMQ的支持
public class RabbitMQConfig {

    //延时交换机
    @Bean
    public CustomExchange newDelayExchange() {
        Map<String, Object> args = new HashMap<>();
        args.put("x-delayed-type", "direct");//配置交换机类型
        return new CustomExchange("sbeam-delayed-exchange", "x-delayed-message", true, false, args);
    }
    //延时队列
    @Bean
    public Queue newDelayQueue() {
        return new Queue("sbeam-delayed-queue", true, false, false);
    }

    // 绑定
    @Bean
    public Binding bindingDelayedQueue() {
        return BindingBuilder.bind(newDelayQueue()).to(newDelayExchange()).with("key3").noargs();
    }
    // 创建一个取消超时检测
    // @Bean
    // public DirectExchange orderCancelExchange() {
    // return new DirectExchange("orderCancelExchange", true, false);
    // }
    //
    // @Bean
    // public Queue orderCancelQueue() {
    // return new Queue("orderCancelQueue", true);
    // }
    //
    // @Bean
    // public Binding bindingOrderCancel() {
    // return BindingBuilder.bind(orderCancelQueue())
    // .to(orderCancelExchange())
    // .with("order.cancel");
    // }

    @Bean
    public Jackson2JsonMessageConverter jsonMessageConverter() {
        return new Jackson2JsonMessageConverter();
    }

    // RabbitTemplate中要发送的数据 先转换成json格式
    @Bean
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory) {
        final RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
        // 设置Json转换器
        rabbitTemplate.setMessageConverter(jsonMessageConverter());
        return rabbitTemplate;
    }

    // 这部分是消息推送的相关配置
    // @Bean
    // public DirectExchange fourmExchange() {
    // return new DirectExchange("fourmExchange", true, false);
    // }

    // @Bean
    // public Queue fourmQueue() {
    // HashMap<String, Object> args = new HashMap<>();
    // args.put("x-dead-letter-exchange", "forumDLXExchange");
    // args.put("x-dead-letter-routing-key", "forum.dead");
    // args.put("x-message-ttl", 86400000);//1day
    // }
    // 系统通知
    @Bean
    public DirectExchange systemExchange() {
        return new DirectExchange("systemExc", true, false);
    }

    @Bean
    public Queue systemQueue() {
        HashMap<String, Object> args = new HashMap<>();
        args.put("x-dead-letter-exchange", "deadExchange");
        args.put("x-dead-letter-routing-key", "dead.system");
        return new Queue("systemQue",true,false,false,args);
    }

    @Bean
    public Binding systemBand(){
        return BindingBuilder.bind(systemQueue()).to(systemExchange()).with("system.key");
    }
    //评论
    @Bean
    public DirectExchange commentExchange() {
        return new DirectExchange("commentExc", true, false);
    }

    @Bean
    public Queue commentQueue() {
        HashMap<String, Object> args = new HashMap<>();
        args.put("x-dead-letter-exchange", "deadExchange");
        args.put("x-dead-letter-routing-key", "dead.comment");
        args.put("x-message-ttl", 604800000);//7天时间过期
        return new Queue("commentQue",true,false,false,args);
    }

    @Bean
    public Binding commentBand(){
        return BindingBuilder.bind(commentQueue()).to(commentExchange()).with("comment.key");
    }
    //点赞
    @Bean
    public DirectExchange likeExchange() {
        return new DirectExchange("likeExc", true, false);
    }

    @Bean
    public Queue likeQueue() {
        HashMap<String, Object> args = new HashMap<>();
        args.put("x-dead-letter-exchange", "deadExchange");
        args.put("x-dead-letter-routing-key", "dead.like");
        args.put("x-message-ttl", 86400000);//1天时间过期
        args.put("x-max-length", 99);
        args.put("x-overflow", "drop-head");
        return new Queue("likeQue",true,false,false,args);
    }

    @Bean
    public Binding likeBand(){
        return BindingBuilder.bind(likeQueue()).to(likeExchange()).with("like.key");
    }

    //创建订单交换机
    @Bean
    public DirectExchange orderExchange(){
        return new DirectExchange("orderExc",true,false);
    }
    @Bean
    public Queue orderQueue(){
        return new Queue("order_queue",true);
    }
    @Bean
    public Binding orderBinding(){
        return BindingBuilder.bind(orderQueue()).to(orderExchange()).with("order.key");
    }

}
