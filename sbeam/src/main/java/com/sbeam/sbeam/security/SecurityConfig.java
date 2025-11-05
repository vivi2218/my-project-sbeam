// package com.sbeam.sbeam.security;

// import com.sbeam.sbeam.util.JWTUtils;
// import org.springframework.context.annotation.Bean;
// import org.springframework.context.annotation.Configuration;
// import org.springframework.security.config.annotation.web.builders.HttpSecurity;
// import org.springframework.security.web.SecurityFilterChain;

// @Configuration
// public class SecurityConfig {

//     private final JWTUtils jwtUtils;

//     public SecurityConfig(JWTUtils jwtUtils) {
//         this.jwtUtils = jwtUtils;
//     }

//     @Bean
//     public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//         JwtAuthenticationFilter jwtFilter = new JwtAuthenticationFilter(jwtUtils);
//         http.csrf().disable()
//                 .authorizeHttpRequests(auth -> auth
//                         .requestMatchers("/auth/**", "/login", "/register", "/css/**", "/js/**").permitAll()
//                         .anyRequest().authenticated()
//                 )
//                 .addFilterBefore(jwtFilter, org.springframework.security.web.authentication.userNamePasswordAuthenticationFilter.class);
//         return http.build();
//     }
// }