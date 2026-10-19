
package com.vetcontrol.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vetcontrol.entity.Cita;

@Repository
public interface CitaRepository
        extends JpaRepository<Cita, Long> {

    // TODAS LAS CITAS DE UNA MASCOTA
    List<Cita> findByMascotaIdMascotaOrderByFechaHoraDesc(
        Long idMascota
    );

    // CITAS ORDENADAS POR FECHA
    List<Cita> findAllByOrderByFechaHoraDesc();

    // CITAS SEGUN ESTADO
    List<Cita> findByEstadoOrderByFechaHoraAsc(
        String estado
    );

    // CONSULTAR CITAS EN UN RANGO DE FECHAS
    List<Cita> findByFechaHoraBetweenOrderByFechaHoraAsc(
        LocalDateTime inicio,
        LocalDateTime fin
    );

    // COMPROBAR SI LA MASCOTA YA TIENE CITA
    // A LA MISMA HORA
    boolean existsByMascotaIdMascotaAndFechaHora(
        Long idMascota,
        LocalDateTime fechaHora
    );

    // MISMA COMPROBACION AL EDITAR:
    // SE EXCLUYE LA CITA ACTUAL
    boolean existsByMascotaIdMascotaAndFechaHoraAndIdCitaNot(
        Long idMascota,
        LocalDateTime fechaHora,
        Long idCita
    );
}
