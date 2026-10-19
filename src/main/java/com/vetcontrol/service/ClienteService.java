
package com.vetcontrol.service;

import java.util.List;
import java.util.Optional;

import com.vetcontrol.entity.Cliente;

public interface ClienteService {

    List<Cliente> listarClientes();

    List<Cliente> listarActivos();

    Optional<Cliente> buscarPorId(Long id);

    Optional<Cliente> buscarPorDocumento(
            String tipoDocumento,
            String nroDocumento
    );

    List<Cliente> buscarPorNombre(String nombre);

    Cliente guardarCliente(Cliente cliente);
}
