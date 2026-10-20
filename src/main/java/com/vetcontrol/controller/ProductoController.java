package com.vetcontrol.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vetcontrol.dto.ProductoDTO;
import com.vetcontrol.entity.Producto;
import com.vetcontrol.repository.ProductoRepository;
import com.vetcontrol.service.ProductoService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/productos")
@RequiredArgsConstructor
public class ProductoController {

    // categorias fijas iguales al ENUM de la tabla tbl_producto
    private static final List<String> CATEGORIAS = List.of(
            "VACUNA", "MEDICAMENTO", "HIGIENE", "ACCESORIO", "OTRO"
    );

    private final ProductoService productoService;
    private final ProductoRepository productoRepository;

    // CATEGORIAS DISPONIBLES (para los select)

    @ModelAttribute("categorias")
    public List<String> cargarCategorias() {
        return CATEGORIAS;
    }


    // LISTAR PRODUCTOS- con filtros

    @GetMapping({"", "/"})
    public String listar(
            @RequestParam(name = "nombre", defaultValue = "")
            String nombre,
            @RequestParam(name = "categoria", defaultValue = "")
            String categoria,
            @RequestParam(name = "soloStockBajo", defaultValue = "false")
            boolean soloStockBajo,
            Model model) {

        model.addAttribute("productos",
                productoService.filtrar(nombre, categoria, soloStockBajo));

        // Se devuelven los filtros para que el formulario los recuerde
        model.addAttribute("filtroNombre", nombre);
        model.addAttribute("filtroCategoria", categoria);
        model.addAttribute("filtroStockBajo", soloStockBajo);

        return "productos/listado";
    }

    // FORMULARIO DE REGISTRO

    @GetMapping("/nuevo")
    public String nuevo(Model model) {

        ProductoDTO dto = new ProductoDTO();
        dto.setActivo(true);

        model.addAttribute("productoDTO", dto);
        model.addAttribute("modoEdicion", false);

        return "productos/formulario";
    }

   
    // FORMULARIO DE EDICION

    @GetMapping("/{id}/editar")
    public String editar(
            @PathVariable("id") Long id,
            Model model,
            RedirectAttributes redirectAttributes) {

        Producto producto = productoService
                .buscarPorId(id)
                .orElse(null);

        if (producto == null) {
            redirectAttributes.addFlashAttribute(
                    "mensajeError",
                    "No se encontró el producto solicitado.");
            return "redirect:/productos";
        }

        model.addAttribute("productoDTO", convertirADTO(producto));
        model.addAttribute("modoEdicion", true);

        return "productos/formulario";
    }

    // GUARDAR PRODUCTO

    @PostMapping("/guardar")
    public String guardar(
            @Valid @ModelAttribute("productoDTO") ProductoDTO dto,
            BindingResult resultado,
            Model model,
            RedirectAttributes redirectAttributes) {

        boolean modoEdicion = dto.getIdProducto() != null;

        // Validar categoria

        if (dto.getCategoria() != null
                && !dto.getCategoria().isBlank()
                && !CATEGORIAS.contains(dto.getCategoria())) {

            resultado.rejectValue(
                    "categoria",
                    "categoria.invalida",
                    "Seleccione una categoría válida.");
        }

        // Validar codigo duplicado

        if (dto.getCodigo() != null && !dto.getCodigo().isBlank()) {

            String codigo = dto.getCodigo().trim();

            boolean duplicado = modoEdicion
                    ? productoRepository
                        .existsByCodigoIgnoreCaseAndIdProductoNot(
                                codigo, dto.getIdProducto())
                    : productoRepository
                        .existsByCodigoIgnoreCase(codigo);

            if (duplicado) {
                resultado.rejectValue(
                        "codigo",
                        "codigo.duplicado",
                        "Ya existe un producto con este código.");
            }
        }

        // Errores de validacion, se vuelve al formulario

        if (resultado.hasErrors()) {
            model.addAttribute("modoEdicion", modoEdicion);
            return "productos/formulario";
        }

        Producto producto;

        if (modoEdicion) {

            producto = productoService
                    .buscarPorId(dto.getIdProducto())
                    .orElse(null);

            if (producto == null) {
                redirectAttributes.addFlashAttribute(
                        "mensajeError",
                        "El producto que intenta editar no existe.");
                return "redirect:/productos";
            }

        } else {
            // Producto nuevo: el stock inicial viene del formulario
            producto = new Producto();
            producto.setActivo(true);
            producto.setStockActual(dto.getStockActual());
        }

        // En edicion no se toca el stock solo cambia con movimientos

        producto.setCodigo(dto.getCodigo().trim().toUpperCase());
        producto.setNombre(dto.getNombre().trim());
        producto.setCategoria(dto.getCategoria());
        producto.setUnidadMedida(dto.getUnidadMedida().trim());
        producto.setStockMinimo(dto.getStockMinimo());
        producto.setPrecioVenta(dto.getPrecioVenta());

        try {

            productoService.guardar(producto);

            redirectAttributes.addFlashAttribute(
                    "mensajeExito",
                    modoEdicion
                            ? "Producto actualizado correctamente."
                            : "Producto registrado correctamente.");

            return "redirect:/productos";

        } catch (Exception ex) {

            model.addAttribute("modoEdicion", modoEdicion);
            model.addAttribute(
                    "mensajeError",
                    "No se pudo guardar el producto. "
                    + "Verifique los datos registrados.");

            return "productos/formulario";
        }
    }


    // ACTIVAR - DESACTIVAR PRODUCTO

    @PostMapping("/{id}/cambiar-estado")
    public String cambiarEstado(
            @PathVariable("id") Long id,
            RedirectAttributes redirectAttributes) {

        try {

            productoService.cambiarEstado(id);

            redirectAttributes.addFlashAttribute(
                    "mensajeExito",
                    "Estado del producto actualizado correctamente.");

        } catch (IllegalArgumentException ex) {

            redirectAttributes.addFlashAttribute(
                    "mensajeError",
                    "No se encontró el producto solicitado.");

        } catch (Exception ex) {

            redirectAttributes.addFlashAttribute(
                    "mensajeError",
                    "No se pudo cambiar el estado del producto.");
        }

        return "redirect:/productos";
    }

    // CONVERTIR PRODUCTO A DTO

    private ProductoDTO convertirADTO(Producto producto) {

        ProductoDTO dto = new ProductoDTO();

        dto.setIdProducto(producto.getIdProducto());
        dto.setCodigo(producto.getCodigo());
        dto.setNombre(producto.getNombre());
        dto.setCategoria(producto.getCategoria());
        dto.setUnidadMedida(producto.getUnidadMedida());
        dto.setStockActual(producto.getStockActual());
        dto.setStockMinimo(producto.getStockMinimo());
        dto.setPrecioVenta(producto.getPrecioVenta());
        dto.setActivo(producto.getActivo());

        return dto;
    }
}