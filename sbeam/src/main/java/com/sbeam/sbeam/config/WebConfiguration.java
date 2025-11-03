package com.sbeam.sbeam.config;

import com.sbeam.sbeam.security.AuthInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sbeam.sbeam.interceptor.AutoIdempotentInterceptor;

@EnableWebMvc
@Configuration
public class WebConfiguration implements WebMvcConfigurer {
    @Autowired
    private AutoIdempotentInterceptor autoIdempotentInterceptor;
    @Autowired
    private AuthInterceptor authInterceptor;


    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(autoIdempotentInterceptor)
                .addPathPatterns("/testorder/**");
                //权限控制拦截器配置
        registry.addInterceptor(authInterceptor).addPathPatterns("/**")
                //排除登录注册等公开接口
                .excludePathPatterns("/auth/**","/test/**");
    }

}


