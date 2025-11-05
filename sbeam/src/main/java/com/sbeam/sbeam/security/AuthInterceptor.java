// package com.sbeam.sbeam.security;

// import com.sbeam.sbeam.util.JWTUtils;
// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpServletResponse;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;
// import org.springframework.web.method.HandlerMethod;
// import org.springframework.web.servlet.HandlerInterceptor;

// import java.io.IOException;

// @Component
// public class AuthInterceptor implements HandlerInterceptor {
//     @Autowired
//     private JWTUtils jwtUtils;

//     @Override
//     public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//             throws Exception {
//         // 从请求头获取token
//         String auth = request.getHeader("Authorization");
//         if (auth == null || !auth.startsWith("Bearer ")) {
//             return setUnauthorizedResponse(response);
//         }
//         String token = auth.substring(7);// "Bearer "
//         if (!jwtUtils.validateToken(token)) {
//             return setUnauthorizedResponse(response);
//         }

//         // 检查方法是否有AdminRequired注解
//         if (handler instanceof HandlerMethod) {
//             HandlerMethod handlerMethod = (HandlerMethod) handler;
//             AdminRequired adminRequired = handlerMethod.getMethodAnnotation(AdminRequired.class);
//             if (adminRequired != null) {
//                 // 需要管理员权限，验证用户角色
//                 String role = jwtUtils.getUserRoleFromToken(token);
//                 if (!"admin".equals(role)) {
//                     return setForbiddenResponse(response);

//                 }
//             }
//         }
//         return true;
//     }

//     private boolean setForbiddenResponse(HttpServletResponse response) throws IOException {
//         response.setStatus(HttpServletResponse.SC_FORBIDDEN);
//         response.setContentType("application/json");
//         response.getWriter().write("{\"code\": 403, \"msg\": \"权限不足\"}");
//         return false;
//     }

//     private boolean setUnauthorizedResponse(HttpServletResponse response) throws IOException, IOException {
//         response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 设置HTTP状态码为401
//         response.setContentType("application/json"); // 告诉客户端返回的是JSON格式数据
//         response.getWriter().write("{\"code\": 401, \"msg\": \"未授权访问\"}"); // 写入具体的JSON响应内容
//         return false; // 返回false表示拦截器阻止请求继续执行（不再调用后续控制器方法）
//     }

// }
