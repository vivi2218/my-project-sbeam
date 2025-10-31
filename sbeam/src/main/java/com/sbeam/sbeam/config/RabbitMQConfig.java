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
    public CustomExchange newDelayExchange(){
        Map<String, Object> args = new HashMap<>();
        args.put("x-delayed-type","direct");//配置交换机类型
        return new CustomExchange("sbeam-delayed-exchange","x-delayed-message",true,false,args);
    }
    //延时队列
    @Bean
    public Queue newDelayQueue(){
        return new Queue("sbeam-delayed-queue",true,false,false);
    }
    //绑定
    @Bean
    public Binding bindingDelayedQueue(){
        return BindingBuilder.bind(newDelayQueue()).to(newDelayExchange()).with("key3").noargs();
    }


    @Bean
    public Jackson2JsonMessageConverter jsonMessageConverter(){
        return new Jackson2JsonMessageConverter();
    }
    //RabbitTemplate中要发送的数据 先转换成json格式
    @Bean
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory){
        final RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
        //设置Json转换器
        rabbitTemplate.setMessageConverter(jsonMessageConverter());
        return rabbitTemplate;
    }
}
