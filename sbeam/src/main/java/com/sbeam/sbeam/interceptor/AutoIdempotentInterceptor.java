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
        String token=request.getHeader("formtoken");
        if(!(handler instanceof HandlerMethod)) return true;
        HandlerMethod handlerMethod=(HandlerMethod) handler;
        AutoIdempotent annotation = handlerMethod.getMethod().getAnnotation(AutoIdempotent.class);
        if (annotation != null) {
            return idempotentTokenService.checkToken(token);
        }
        return true;
    }
    
}
