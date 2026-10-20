package com.vetcontrol.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.vetcontrol.entity.Producto;

@Repository
public interface ProductoRepository
        extends JpaRepository<Producto, Long> {

    List<Producto> findAllByOrderByNombreAsc();

    boolean existsByCodigoIgnoreCase(String codigo);

    boolean existsByCodigoIgnoreCaseAndIdProductoNot(
            String codigo,
            Long idProducto
    );

    
    @Query("""
            SELECT p FROM Producto p
            WHERE (:nombre = ''
                   OR LOWER(p.nombre) LIKE LOWER(CONCAT('%', :nombre, '%')))
              AND (:categoria = '' OR p.categoria = :categoria)
              AND (:soloStockBajo = false
                   OR p.stockActual <= p.stockMinimo)
            ORDER BY p.nombre ASC
            """)
    List<Producto> filtrar(
            @Param("nombre") String nombre,
            @Param("categoria") String categoria,
            @Param("soloStockBajo") boolean soloStockBajo
    );

    @Query("""
            SELECT p FROM Producto p
            WHERE p.activo = true
              AND p.stockActual <= p.stockMinimo
            ORDER BY p.nombre ASC
            """)
    List<Producto> buscarStockBajo();
}