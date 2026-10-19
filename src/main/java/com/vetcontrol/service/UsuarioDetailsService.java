
package com.vetcontrol.service;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.vetcontrol.entity.Usuario;
import com.vetcontrol.repository.UsuarioRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UsuarioDetailsService implements UserDetailsService {

    private final UsuarioRepository usuarioRepository;

    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {

        // Buscar el usuario registrado en MySQL
        Usuario usuario = usuarioRepository
                .findByUsername(username)
                .orElseThrow(() ->
                    new UsernameNotFoundException(
                        "Usuario no encontrado"
                    )
                );

        // Comprobar el estado de la cuenta
        boolean cuentaActiva =
                Boolean.TRUE.equals(usuario.getActivo());

        // Obtener el rol del usuario
        String rol = usuario.getRol();

        if (!"ADMIN".equals(rol)
                && !"EMPLEADO".equals(rol)) {

            throw new UsernameNotFoundException(
                "Usuario con rol no válido"
            );
        }

        // Construir el usuario reconocido por Spring Security
        return User.withUsername(usuario.getUsername())
                .password(usuario.getPassword())
                .roles(rol)
                .disabled(!cuentaActiva)
                .build();
    }
}
