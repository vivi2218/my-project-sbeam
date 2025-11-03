// package com.sbeam.sbeam.security;

// import com.sbeam.sbeam.util.JWTUtils;
// import org.springframework.security.authentication.userNamePasswordAuthenticationToken;
// import org.springframework.security.core.context.SecurityContextHolder;
// import org.springframework.web.filter.OncePerRequestFilter;
// import jakarta.servlet.FilterChain;
// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpServletResponse;

// import java.io.IOException;
// import java.util.Collections;

// public class JwtAuthenticationFilter extends OncePerRequestFilter {

//     private final JWTUtils jwtUtils;

//     public JwtAuthenticationFilter(JWTUtils jwtUtils) {
//         this.jwtUtils = jwtUtils;
//     }

//     @Override
//     protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
//             throws IOException, jakarta.servlet.ServletException {
//         String auth = request.getHeader("Authorization");
//         if (auth != null && auth.startsWith("Bearer ")) {
//             String token = auth.substring(7);
//             if (jwtUtils.validateToken(token)) {
//                 String userId = jwtUtils.getUserIdFromToken(token);
//                 userNamePasswordAuthenticationToken authToken =
//                         new userNamePasswordAuthenticationToken(userId, null, Collections.emptyList());
//                 SecurityContextHolder.getContext().setAuthentication(authToken);
//             }
//         }
//         filterChain.doFilter(request, response);
//     }
// }