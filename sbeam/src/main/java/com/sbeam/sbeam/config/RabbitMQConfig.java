package com.sbeam.sbeam.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;

@Configuration
public class RabbitMQConfig {
    @Bean
    public DirectExchange neworderExchange() {
        return new DirectExchange("orderExchange", true, false);
    }

    @Bean
    public Queue neworderQueue() {
        HashMap<String, Object> map = new HashMap<>();
        map.put("x-dead-letter-exchange", "orderDLXExchange"); // 设置死信交换机
        map.put("x-dead-letter-routing-key", "deadkey"); // 设置死信路由键
        map.put("x-message-ttl", 604800000); // 设置 TTL 为 7 天（毫秒）
        return new Queue("orderQueue", true, false, false, map);
    }

    @Bean
    public Binding binding() {
        return BindingBuilder.bind(neworderQueue()).to(neworderExchange()).with("orderkey");
    }

    // 4.创建死信交换机
    @Bean
    public DirectExchange newOrderDeadExchange() {
        return new DirectExchange("orderDLXExchange", true, false);
    }

    // 5.创建死信队列
    @Bean
    public Queue newOrderDeadQueue() {
        return new Queue("orderDLXQueue", true);
    }

    // 6.绑定
    @Bean
    public Binding bindingDead() {
        return BindingBuilder.bind(newOrderDeadQueue()).to(newOrderDeadExchange()).with("deadkey");
    }

    // 创建超时交换机
    @Bean
    public DirectExchange orderTimeoutExchange() {
        return new DirectExchange("orderTimeoutExchange", true, false);
    }

    // 创建一个超时队列
    @Bean
    public Queue orderTimeoutQueue() {
        return new Queue("orderTimeoutQueue", true);
    }

    // 绑定
    @Bean
    public Binding bindingOrderTimeout() {
        return BindingBuilder.bind(orderTimeoutQueue()).to(orderTimeoutExchange()).with("order.timeout");
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
}
