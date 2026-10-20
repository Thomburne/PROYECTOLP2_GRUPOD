package com.vetcontrol.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vetcontrol.entity.MovimientoInventario;

@Repository
public interface MovimientoInventarioRepository
        extends JpaRepository<MovimientoInventario, Long> {

    // Historial general: del movimiento mas reciente al mas antiguo
    List<MovimientoInventario>
            findAllByOrderByFechaMovimientoDescIdMovimientoDesc();

    // Historial (kardex) de un solo producto
    List<MovimientoInventario>
            findByProducto_IdProductoOrderByFechaMovimientoDescIdMovimientoDesc(
                    Long idProducto);
}