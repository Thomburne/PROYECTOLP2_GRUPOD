
package com.vetcontrol.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vetcontrol.entity.Mascota;
import com.vetcontrol.repository.MascotaRepository;
import com.vetcontrol.service.MascotaService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MascotaServiceImpl implements MascotaService {

    private final MascotaRepository mascotaRepository;

    @Override
    @Transactional(readOnly = true)
    public List<Mascota> listarMascotas() {
        return mascotaRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Mascota> listarActivas() {
        return mascotaRepository
                .findByActivoTrueOrderByIdMascotaDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Mascota> listarPorCliente(Long idCliente) {
        return mascotaRepository
                .findByClienteIdCliente(idCliente);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Mascota> buscarPorId(Long id) {
        return mascotaRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Mascota> buscarPorNombre(String nombre) {
        return mascotaRepository
                .findByNombreContainingIgnoreCase(nombre);
    }

    @Override
    @Transactional
    public Mascota guardarMascota(Mascota mascota) {
        return mascotaRepository.save(mascota);
    }
}
