package com;

import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.util.Collections;

public class mbt {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/sbeam?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai";
        String user = "root";
        String password = "8888";
        String projectPath = System.getProperty("D:\\code\\sbeam\\sbeam\\sbeam");

        FastAutoGenerator.create(url, user, password)
                .globalConfig(builder -> builder.author("yourname")
                        .enableSwagger()
                        .fileOverride() // 是否覆盖已有文件
                        .outputDir("D:\\code\\sbeam\\sbeam\\sbeam\\src\\main\\java"))
                .packageConfig(builder -> builder.parent("com.sbeam.sbeam")
                        .entity("entity")
                        .mapper("mapper")
                        .service("service")
                        .serviceImpl("service.impl")
                        .controller("controller")
                // 如果你的 mybatis-plus 版本没有 OutputFile.mapperXml 常量，省略 pathInfo 或改为正确常量
                )
                .strategyConfig(builder -> builder
                        .addInclude("cart", "comment", "community", "game", "game_achievement", "game_bundle",
                                "game_images", "game_price_history", "game_profile", "game_tag", "gift",
                                "historical_orders", "message", "myorder", "order_details", "payment_records", "post",
                                "sales", "tag", "user", "user_achievement", "user_follow", "user_game_library",
                                "user_profile") // 指定要生成的表，改为你的表名或用 scanner 获取
                        .entityBuilder().enableLombok()
                        .controllerBuilder().enableRestStyle()
                        .mapperBuilder().enableMapperAnnotation())
                .templateEngine(new FreemarkerTemplateEngine()) // 使用 Freemarker，或改为 VelocityTemplateEngine()
                .execute();
    }
}