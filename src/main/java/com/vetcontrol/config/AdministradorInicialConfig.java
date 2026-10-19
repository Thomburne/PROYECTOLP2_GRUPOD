
package com.vetcontrol.config;

import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.vetcontrol.entity.Usuario;
import com.vetcontrol.repository.UsuarioRepository;

@Configuration
public class AdministradorInicialConfig {

    @Bean
    public ApplicationRunner crearAdministradorInicial(
            UsuarioRepository usuarioRepository,
            PasswordEncoder passwordEncoder,
            Environment environment) {

        return args -> {

            String username = "admin";

            // No modificar usuarios existentes
            if (usuarioRepository.existsByUsername(username)) {
                System.out.println(
                    "VetControl: el usuario admin ya existe."
                );
                return;
            }

            String password = environment.getProperty(
                    "VETCONTROL_ADMIN_PASSWORD");

            // La contraseña no se almacena en el codigo
            if (password == null || password.isBlank()) {
                System.out.println(
                    "VetControl: administrador no creado. " +
                    "Configure VETCONTROL_ADMIN_PASSWORD."
                );
                return;
            }

            // Validacion minima de seguridad
            if (password.length() < 12
                    || password.length() > 72) {
                throw new IllegalStateException(
                    "La contraseña inicial debe tener " +
                    "entre 12 y 72 caracteres."
                );
            }

            if (!password.matches("(?s).*\\p{Lu}.*")
                    || !password.matches("(?s).*\\p{Ll}.*")
                    || !password.matches("(?s).*\\d.*")
                    || !password.matches(
                            "(?s).*[^\\p{L}\\p{N}].*")) {

                throw new IllegalStateException(
                    "La contraseña debe incluir mayúsculas, " +
                    "minúsculas, números y símbolos."
                );
            }

            Usuario administrador = new Usuario();

            administrador.setUsername(username);
            administrador.setPassword(
                    passwordEncoder.encode(password));
            administrador.setNombres(
                    "Administrador VetControl Perú");
            administrador.setCorreo(null);
            administrador.setRol("ADMIN");
            administrador.setActivo(true);

            usuarioRepository.save(administrador);

            System.out.println(
                "VetControl: administrador creado correctamente."
            );
        };
    }
}
