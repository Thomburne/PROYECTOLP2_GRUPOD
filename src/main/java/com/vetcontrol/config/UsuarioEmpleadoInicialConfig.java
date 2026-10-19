
package com.vetcontrol.config;

import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.vetcontrol.entity.Usuario;
import com.vetcontrol.repository.UsuarioRepository;

@Configuration
public class UsuarioEmpleadoInicialConfig {

    @Bean
    public ApplicationRunner crearEmpleadoInicial(
            UsuarioRepository usuarioRepository,
            PasswordEncoder passwordEncoder,
            Environment environment) {

        return args -> {

            String username = "empleado";

            // Evitar duplicados
            if (usuarioRepository.existsByUsername(username)) {
                System.out.println(
                    "VetControl: el empleado ya existe."
                );
                return;
            }

            // Leer contraseña desde Environment
            String password = environment.getProperty(
                    "VETCONTROL_EMPLEADO_PASSWORD"
            );

            if (password == null || password.isBlank()) {
                System.out.println(
                    "VetControl: empleado no creado. " +
                    "Configure VETCONTROL_EMPLEADO_PASSWORD."
                );
                return;
            }

            // Validar longitud de contraseña
            if (password.length() < 12
                    || password.length() > 72) {
                throw new IllegalStateException(
                    "La contraseña del empleado debe " +
                    "tener entre 12 y 72 caracteres."
                );
            }

            // Validar complejidad
            if (!password.matches("(?s).*\\p{Lu}.*")
                    || !password.matches("(?s).*\\p{Ll}.*")
                    || !password.matches("(?s).*\\d.*")
                    || !password.matches(
                            "(?s).*[^\\p{L}\\p{N}].*")) {

                throw new IllegalStateException(
                    "La contraseña debe incluir " +
                    "mayúsculas, minúsculas, " +
                    "números y símbolos."
                );
            }

            // Crear usuario EMPLEADO
            Usuario empleado = new Usuario();

            empleado.setUsername(username);
            empleado.setPassword(
                    passwordEncoder.encode(password)
            );
            empleado.setNombres(
                    "Empleado de Prueba VetControl"
            );
            empleado.setCorreo(null);
            empleado.setRol("EMPLEADO");
            empleado.setActivo(true);

            usuarioRepository.save(empleado);

            System.out.println(
                "VetControl: empleado creado correctamente."
            );
        };
    }
}
