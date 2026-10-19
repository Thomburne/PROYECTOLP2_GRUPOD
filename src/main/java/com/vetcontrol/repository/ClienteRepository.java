
package com.vetcontrol.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vetcontrol.entity.Cliente;

public interface ClienteRepository
        extends JpaRepository<Cliente, Long> {

    Optional<Cliente> findByTipoDocumentoAndNroDocumento(
            String tipoDocumento,
            String nroDocumento
    );

    List<Cliente> findByActivoTrueOrderByIdClienteDesc();

    List<Cliente> findByNombresRazonSocialContainingIgnoreCase(
            String nombre
    );
}
