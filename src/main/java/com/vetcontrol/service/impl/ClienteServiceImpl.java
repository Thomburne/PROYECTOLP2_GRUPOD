
package com.vetcontrol.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vetcontrol.entity.Cliente;
import com.vetcontrol.repository.ClienteRepository;
import com.vetcontrol.service.ClienteService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ClienteServiceImpl implements ClienteService {

    private final ClienteRepository clienteRepository;

    @Override
    @Transactional(readOnly = true)
    public List<Cliente> listarClientes() {
        return clienteRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Cliente> listarActivos() {
        return clienteRepository
                .findByActivoTrueOrderByIdClienteDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Cliente> buscarPorId(Long id) {
        return clienteRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Cliente> buscarPorDocumento(
            String tipoDocumento,
            String nroDocumento) {

        return clienteRepository
                .findByTipoDocumentoAndNroDocumento(
                    tipoDocumento,
                    nroDocumento
                );
    }

    @Override
    @Transactional(readOnly = true)
    public List<Cliente> buscarPorNombre(String nombre) {
        return clienteRepository
                .findByNombresRazonSocialContainingIgnoreCase(
                    nombre
                );
    }

    @Override
    @Transactional
    public Cliente guardarCliente(Cliente cliente) {
        return clienteRepository.save(cliente);
    }
}
