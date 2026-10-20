package com.vetcontrol.service.impl;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vetcontrol.entity.MovimientoInventario;
import com.vetcontrol.entity.Producto;
import com.vetcontrol.repository.MovimientoInventarioRepository;
import com.vetcontrol.repository.ProductoRepository;
import com.vetcontrol.service.MovimientoInventarioService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MovimientoInventarioServiceImpl
        implements MovimientoInventarioService {

    private static final List<String> TIPOS =
            List.of("ENTRADA", "SALIDA", "AJUSTE");

    private final MovimientoInventarioRepository movimientoRepository;
    private final ProductoRepository productoRepository;

    @Override
    @Transactional(readOnly = true)
    public List<MovimientoInventario> listarTodos() {
        return movimientoRepository
                .findAllByOrderByFechaMovimientoDescIdMovimientoDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<MovimientoInventario> listarPorProducto(Long idProducto) {
        return movimientoRepository
                .findByProducto_IdProductoOrderByFechaMovimientoDescIdMovimientoDesc(
                        idProducto);
    }

    // transaccion- actualiza el stock del producto y registra el movimiento Si lanza una excepcion, se deshace todo (rollback)
    @Override
    @Transactional
    public MovimientoInventario registrar(Long idProducto,
                                          String tipo,
                                          BigDecimal cantidad,
                                          String motivo) {

        if (cantidad == null
                || cantidad.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException(
                    "La cantidad debe ser mayor que cero.");
        }

        if (tipo == null || !TIPOS.contains(tipo)) {
            throw new IllegalArgumentException(
                    "Tipo de movimiento no válido.");
        }

        Producto producto = productoRepository.findById(idProducto)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Producto no encontrado."));

        if (!Boolean.TRUE.equals(producto.getActivo())) {
            throw new IllegalStateException(
                    "No se puede mover el stock de un producto inactivo.");
        }

        BigDecimal stockNuevo;

        if ("ENTRADA".equals(tipo)) {

            stockNuevo = producto.getStockActual().add(cantidad);

        } else {
            // SALIDA y AJUSTE restan stock

            if (producto.getStockActual().compareTo(cantidad) < 0) {
                throw new IllegalStateException(
                        "Stock insuficiente. Disponible: "
                        + producto.getStockActual().toPlainString());
            }

            stockNuevo = producto.getStockActual().subtract(cantidad);
        }

        // Actualizar el stock del producto
        producto.setStockActual(stockNuevo);
        productoRepository.save(producto);

        // Registrar el movimiento
        MovimientoInventario movimiento = new MovimientoInventario();
        movimiento.setProducto(producto);
        movimiento.setTipo(tipo);
        movimiento.setCantidad(cantidad);
        movimiento.setFechaMovimiento(LocalDateTime.now());
        movimiento.setMotivo(motivo == null ? null : motivo.trim());

        return movimientoRepository.save(movimiento);
    }
}