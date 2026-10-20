
package com.vetcontrol.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;

import org.springframework.security.core.userdetails.UserDetailsService;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    // =========================================
    // 1. CIFRADO DE CONTRASEÑAS CON BCRYPT
    // =========================================
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    // =========================================
    // 2. PROVEEDOR DE AUTENTICACION
    // =========================================
    @Bean
    public AuthenticationProvider authenticationProvider(
            UserDetailsService userDetailsService,
            PasswordEncoder passwordEncoder) {

        DaoAuthenticationProvider provider =
                new DaoAuthenticationProvider(userDetailsService);

        provider.setPasswordEncoder(passwordEncoder);

        return provider;
    }

    // =========================================
    // 3. CONFIGURACION DE SEGURIDAD
    // =========================================
    @Bean
    public SecurityFilterChain securityFilterChain(
            HttpSecurity http,
            AuthenticationProvider authenticationProvider)
            throws Exception {

        http

            // PROVEEDOR DE AUTENTICACION
            .authenticationProvider(authenticationProvider)

            // =====================================
            // AUTORIZACION DE RUTAS
            // =====================================
            .authorizeHttpRequests(auth -> auth

                // RECURSOS PUBLICOS
            		.requestMatchers(
            			    "/",
            			    "/login",
            			    "/error",
            			    "/css/**",
            			    "/js/**",
            			    "/images/**",
            			    "/img/**",
            			    "/webjars/**",
            			    "/favicon.ico"
            			).permitAll()

                // SOLO ADMINISTRADOR
                .requestMatchers(
                    "/admin",
                    "/admin/**",
                    "/usuarios",
                    "/usuarios/**",
                    "/configuracion",
                    "/configuracion/**"
                ).hasRole("ADMIN")

                // ADMINISTRADOR Y EMPLEADO
                .requestMatchers(
                    "/dashboard",

                    "/clientes",
                    "/clientes/**",

                    "/cliente",
                    "/cliente/**",

                    "/mascotas",
                    "/mascotas/**",

                    "/mascota",
                    "/mascota/**",

                    "/citas",
                    "/citas/**",

                    "/cita",
                    "/cita/**",

                    "/servicios",
                    "/servicios/**",

                    "/servicio",
                    "/servicio/**"
                ).hasAnyRole("ADMIN", "EMPLEADO")

                // CUALQUIER OTRA RUTA
                // REQUIERE INICIAR SESION
                .anyRequest().authenticated()
            )

            // =====================================
            // INICIO DE SESION
            // =====================================
            .formLogin(form -> form

                .loginPage("/login")

                .loginProcessingUrl("/login")

                .usernameParameter("username")

                .passwordParameter("password")

                // DESPUES DEL LOGIN
                // ABRIR EL DASHBOARD
                .defaultSuccessUrl("/dashboard", true)

                // LOGIN INCORRECTO
                .failureUrl("/login?error")

                .permitAll()
            )

            // =====================================
            // CIERRE DE SESION
            // =====================================
            .logout(logout -> logout

                .logoutUrl("/logout")

                .logoutSuccessUrl("/login?logout")

                .invalidateHttpSession(true)

                .clearAuthentication(true)

                .deleteCookies("JSESSIONID")

                .permitAll()
            )

            // =====================================
            // PROTECCION DE SESIONES
            // =====================================
            .sessionManagement(session -> session

                // CAMBIAR IDENTIFICADOR DE SESION
                // DESPUES DE AUTENTICARSE
                .sessionFixation(fixation ->
                    fixation.changeSessionId()
                )
            );

        // CSRF SE MANTIENE HABILITADO
        // PARA PROTEGER FORMULARIOS POST

        return http.build();
    }
}
