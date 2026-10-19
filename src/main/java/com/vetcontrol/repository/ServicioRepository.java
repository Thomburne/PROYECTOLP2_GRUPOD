
package com.vetcontrol.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vetcontrol.entity.Servicio;

@Repository
public interface ServicioRepository
        extends JpaRepository<Servicio, Long> {

    // =========================================
    // METODOS ORIGINALES DEL PROYECTO
    // =========================================

    // Listar servicios activos ordenados por nombre
    List<Servicio> findByActivoTrueOrderByNombreAsc();

    // Listar todos los servicios ordenados por nombre
    List<Servicio> findAllByOrderByNombreAsc();


    // =========================================
    // BUSQUEDAS Y FILTROS
    // =========================================

    // Buscar servicios por nombre
    List<Servicio> findByNombreContainingIgnoreCase(
            String nombre
    );

    // Buscar servicios por categoria
    List<Servicio> findByCategoria(
            String categoria
    );

    // Buscar servicios por estado
    List<Servicio> findByActivo(
            Boolean activo
    );

    // Filtrar por categoria y estado
    List<Servicio> findByCategoriaAndActivo(
            String categoria,
            Boolean activo
    );


    // =========================================
    // VALIDACION DE DUPLICADOS
    // =========================================

    // Buscar servicio por nombre exacto
    Optional<Servicio> findByNombreIgnoreCase(
            String nombre
    );

    // Verificar si existe un nombre registrado
    boolean existsByNombreIgnoreCase(
            String nombre
    );

    // Verificar nombre duplicado excluyendo
    // el mismo servicio durante la edicion
    boolean existsByNombreIgnoreCaseAndIdServicioNot(
            String nombre,
            Long idServicio
    );
}
