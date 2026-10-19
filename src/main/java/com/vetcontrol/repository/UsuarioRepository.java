
package com.vetcontrol.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vetcontrol.entity.Usuario;

@Repository
public interface UsuarioRepository
        extends JpaRepository<Usuario, Long> {

    // Buscar usuario por nombre de acceso
    Optional<Usuario> findByUsername(String username);

    // Verificar si un nombre de usuario ya existe
    boolean existsByUsername(String username);

    // Buscar usuario por correo electronico
    Optional<Usuario> findByCorreo(String correo);

}
