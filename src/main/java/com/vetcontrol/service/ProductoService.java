package com.vetcontrol.service;

import java.util.List;
import java.util.Optional;

import com.vetcontrol.entity.Producto;

public interface ProductoService {

    List<Producto> listarTodos();

    List<Producto> filtrar(String nombre,
                           String categoria,
                           boolean soloStockBajo);

    List<Producto> listarStockBajo();

    Optional<Producto> buscarPorId(Long id);

    Producto guardar(Producto producto);

    void cambiarEstado(Long id);
}