
package com.vetcontrol.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import com.vetcontrol.dto.CitaDTO;
import com.vetcontrol.entity.Cita;

public interface CitaService {

    // LISTADO GENERAL
    List<Cita> listarCitas();

    // CITAS DE UNA MASCOTA
    List<Cita> listarPorMascota(Long idMascota);

    // BUSCAR CITA POR ID
    Optional<Cita> buscarPorId(Long idCita);

    // BUSCAR POR ESTADO
    List<Cita> listarPorEstado(String estado);

    // BUSCAR POR RANGO DE FECHAS
    List<Cita> listarPorFechas(
            LocalDateTime inicio,
            LocalDateTime fin
    );

    // REGISTRAR NUEVA CITA
    Cita registrarCita(CitaDTO dto);

    // ACTUALIZAR CITA EXISTENTE
    Cita actualizarCita(Long idCita, CitaDTO dto);

    // CAMBIAR ESTADO
    Cita cambiarEstado(Long idCita, String nuevoEstado);

    // COMPROBAR HORARIO DISPONIBLE
    boolean horarioDisponible(
            Long idMascota,
            LocalDateTime fechaHora,
            Long idCitaActual
    );
}
