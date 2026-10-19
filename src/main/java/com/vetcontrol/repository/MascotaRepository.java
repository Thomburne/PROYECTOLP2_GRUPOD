
package com.vetcontrol.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vetcontrol.entity.Mascota;

public interface MascotaRepository
        extends JpaRepository<Mascota, Long> {

    List<Mascota> findByClienteIdCliente(Long idCliente);

    List<Mascota> findByActivoTrueOrderByIdMascotaDesc();

    List<Mascota> findByNombreContainingIgnoreCase(
            String nombre
    );
}
