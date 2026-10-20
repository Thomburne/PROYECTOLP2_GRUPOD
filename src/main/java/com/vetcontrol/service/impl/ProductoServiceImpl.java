package com.vetcontrol.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vetcontrol.entity.Producto;
import com.vetcontrol.repository.ProductoRepository;
import com.vetcontrol.service.ProductoService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductoServiceImpl implements ProductoService {

    private final ProductoRepository productoRepository;

    @Override
    @Transactional(readOnly = true)
    public List<Producto> listarTodos() {
        return productoRepository.findAllByOrderByNombreAsc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Producto> filtrar(String nombre,
                                  String categoria,
                                  boolean soloStockBajo) {

        String n = nombre == null ? "" : nombre.trim();
        String c = categoria == null ? "" : categoria.trim();

        return productoRepository.filtrar(n, c, soloStockBajo);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Producto> listarStockBajo() {
        return productoRepository.buscarStockBajo();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Producto> buscarPorId(Long id) {
        return productoRepository.findById(id);
    }

    @Override
    @Transactional
    public Producto guardar(Producto producto) {
        if (producto.getIdProducto() == null
                && producto.getActivo() == null) {
            producto.setActivo(true);
        }

        return productoRepository.save(producto);
    }

    @Override
    @Transactional
    public void cambiarEstado(Long id) {

        Producto producto = productoRepository.findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Producto no encontrado: " + id
                        )
                );

        producto.setActivo(
                !Boolean.TRUE.equals(producto.getActivo())
        );

        productoRepository.save(producto);
    }
}