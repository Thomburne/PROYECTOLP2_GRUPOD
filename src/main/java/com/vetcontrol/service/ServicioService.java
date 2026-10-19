
package com.vetcontrol.service;

import java.util.List;
import java.util.Optional;

import com.vetcontrol.entity.Servicio;

public interface ServicioService {

    List<Servicio> listarTodos();

    List<Servicio> listarActivos();

    Optional<Servicio> buscarPorId(Long id);

    Servicio guardar(Servicio servicio);

    void cambiarEstado(Long id);
}
