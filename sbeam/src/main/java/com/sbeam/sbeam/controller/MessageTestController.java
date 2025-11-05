package com.sbeam.sbeam.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.sbeam.sbeam.webSocket.MessagePushService;

@RestController
@RequestMapping("/test")
public class MessageTestController {

    @Autowired
    private MessagePushService messagePushService;

    
    @GetMapping("/push")
    public String pushMessage(@RequestParam String userId, @RequestParam String msg) {
        messagePushService.notifyUser(userId, msg);
        return "消息已发送到MQ -> userId=" + userId + "，内容=" + msg;
    }
}
