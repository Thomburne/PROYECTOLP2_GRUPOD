package com.vetcontrol.service;

import java.math.BigDecimal;
import java.util.List;

import com.vetcontrol.entity.MovimientoInventario;

public interface MovimientoInventarioService {

    List<MovimientoInventario> listarTodos();

    List<MovimientoInventario> listarPorProducto(Long idProducto);

    MovimientoInventario registrar(Long idProducto,
                                   String tipo,
                                   BigDecimal cantidad,
                                   String motivo);
}
