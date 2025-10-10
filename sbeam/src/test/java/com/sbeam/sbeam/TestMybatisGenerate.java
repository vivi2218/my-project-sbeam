package com.sbeam.sbeam;

import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.util.Collections;

public class TestMybatisGenerate {
    public static void main(String[] args) {
        FastAutoGenerator.create("jdbc:mysql://localhost:3308/sbeam?useSSL=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai", "root", "root")
                .globalConfig(builder -> {
                    builder.author("smith") // 设置作者
                            //.enableSwagger() // 开启 swagger 模式
                            .outputDir("D:\\sbeam\\sbeam\\sbeam\\src\\main\\java"); // 指定输出目录
                })
                .packageConfig(builder -> {
                    builder.parent("com.sbeam.sbeam") // 设置父包名
                            .moduleName("") // 设置父包模块名
                            .pathInfo(Collections.singletonMap(OutputFile.mapperXml, "D:\\sbeam\\sbeam\\sbeam\\src\\main\\resources\\com/sbeam/mapper")); // 设置mapperXml生成路径
                })
                .strategyConfig(builder -> {
                    builder.addInclude("cart")
                            .addInclude("comment") // 设置需要生成的表名
                            .addInclude("community") // 设置需要生成的表名
                            .addInclude("game") // 设置需要生成的表名
                            .addInclude("game_achievement") // 设置需要生成的表名
                            .addInclude("game_bundle") // 设置需要生成的表名
                            .addInclude("game_images") // 设置需要生成的表名
                            .addInclude("game_price_history") // 设置需要生成的表名
                            .addInclude("game_profile") // 设置需要生成的表名
                            .addInclude("game_tag") // 设置需要生成的表名
                            .addInclude("gift") // 设置需要生成的表名
                            .addInclude("historical_orders") // 设置需要生成的表名
                            .addInclude("message") // 设置需要生成的表名
                            .addInclude("myorder") // 设置需要生成的表名
                            .addInclude("order_details") // 设置需要生成的表名
                            .addInclude("payment_records") // 设置需要生成的表名
                            .addInclude("post") // 设置需要生成的表名
                            .addInclude("sales") // 设置需要生成的表名
                            .addInclude("tag") // 设置需要生成的表名
                            .addInclude("user") // 设置需要生成的表名
                            .addInclude("user_achievement") // 设置需要生成的表名
                            .addInclude("user_follow") // 设置需要生成的表名
                            .addInclude("user_profile") // 设置需要生成的表名
                            .addInclude("user_game_library") // 设置需要生成的表名






                            .addTablePrefix("tb_", "c_"); // 设置过滤表前缀
                })
                .templateEngine(new FreemarkerTemplateEngine()) // 使用Freemarker引擎模板，默认的是Velocity引擎模板
                .execute();
    }

}
