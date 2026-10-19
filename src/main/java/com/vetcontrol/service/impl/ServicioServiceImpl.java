
package com.vetcontrol.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vetcontrol.entity.Servicio;
import com.vetcontrol.repository.ServicioRepository;
import com.vetcontrol.service.ServicioService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ServicioServiceImpl implements ServicioService {

    private final ServicioRepository servicioRepository;

    @Override
    @Transactional(readOnly = true)
    public List<Servicio> listarTodos() {
        return servicioRepository.findAllByOrderByNombreAsc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Servicio> listarActivos() {
        return servicioRepository.findByActivoTrueOrderByNombreAsc();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Servicio> buscarPorId(Long id) {
        return servicioRepository.findById(id);
    }

    @Override
    @Transactional
    public Servicio guardar(Servicio servicio) {
        if (servicio.getIdServicio() == null
                && servicio.getActivo() == null) {
            servicio.setActivo(true);
        }

        return servicioRepository.save(servicio);
    }

    @Override
    @Transactional
    public void cambiarEstado(Long id) {

        Servicio servicio = servicioRepository.findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Servicio no encontrado: " + id
                        )
                );

        servicio.setActivo(
                !Boolean.TRUE.equals(servicio.getActivo())
        );

        servicioRepository.save(servicio);
    }
}
