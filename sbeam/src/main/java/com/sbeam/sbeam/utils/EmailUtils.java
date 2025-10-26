package com.sbeam.sbeam.utils;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

public class EmailUtils {

    public static void sendEmail(String to, String subject, String text) {
        // 创建 JavaMailSenderImpl
        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setHost("smtp.qq.com");
        sender.setPort(587); // STARTTLS
        sender.setUsername("861777592@qq.com"); // 发件人邮箱
        sender.setPassword("voojqutkszgibfci"); // QQ 授权码

        // 配置邮件属性
        Properties props = sender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // 开启 STARTTLS
        props.put("mail.smtp.starttls.required", "true"); // 强制使用 TLS
        props.put("mail.smtp.ssl.trust", "smtp.qq.com");

        // 构建邮件
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("861777592@qq.com"); // 必须与 username 一致
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);

        // 发送
        sender.send(message);
        System.out.println("✅ 邮件已发送到 " + to);
    }

    // 测试方法
    public static void main(String[] args) {
        sendEmail("收件人邮箱@qq.com", "测试邮件", "这是一封测试邮件内容");
    }
}
