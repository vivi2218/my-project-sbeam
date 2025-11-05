package com.sbeam.sbeam.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import com.sbeam.sbeam.service.IdempotentTokenService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@Component
public class AutoIdempotentInterceptor implements HandlerInterceptor{
    @Autowired
    private IdempotentTokenService idempotentTokenService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        System.out.println("正在执行拦截器AutoIdempotentInterceptor 。。。。。。。 ");
        String token=request.getHeader("formtoken");
        String value = request.getHeader("formvalue");
        System.out.println("拦截器中获得的formToken：" + token);
        System.out.println("拦截器中获得的formvalue：" + value);

        if(!(handler instanceof HandlerMethod)) return true;
        HandlerMethod handlerMethod=(HandlerMethod) handler;
        AutoIdempotent annotation = handlerMethod.getMethod().getAnnotation(AutoIdempotent.class);
        if (annotation != null) {
            return idempotentTokenService.checkToken(token,value);
        }
        return true;//放行
    }
    
}
