package com.vetcontrol.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vetcontrol.dto.MovimientoDTO;
import com.vetcontrol.entity.MovimientoInventario;
import com.vetcontrol.entity.Producto;
import com.vetcontrol.service.MovimientoInventarioService;
import com.vetcontrol.service.ProductoService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/inventario")
@RequiredArgsConstructor
public class MovimientoInventarioController {

    // tipos permitidos iguales al enum de la tabla
    private static final List<String> TIPOS =
            List.of("ENTRADA", "SALIDA", "AJUSTE");

    private final MovimientoInventarioService movimientoService;
    private final ProductoService productoService;

    // TIPOS DE MOVIMIENTO para el select
  

    @ModelAttribute("tipos")
    public List<String> cargarTipos() {
        return TIPOS;
    }

    // HISTORIAL DE MOVIMIENTOS -filtro por producto
  
    @GetMapping({"", "/"})
    public String listar(
            @RequestParam(name = "idProducto", required = false)
            Long idProducto,
            Model model) {

        List<MovimientoInventario> movimientos =
                (idProducto == null)
                        ? movimientoService.listarTodos()
                        : movimientoService.listarPorProducto(idProducto);

        model.addAttribute("movimientos", movimientos);
        model.addAttribute("productosTodos", productoService.listarTodos());
        model.addAttribute("filtroProducto", idProducto);

        return "inventario/listado";
    }

    // FORMULARIO DE NUEVO MOVIMIENTO

    @GetMapping("/nuevo")
    public String nuevo(
            @RequestParam(name = "idProducto", required = false)
            Long idProducto,
            Model model) {

        MovimientoDTO dto = new MovimientoDTO();
        dto.setIdProducto(idProducto);

        model.addAttribute("movimientoDTO", dto);
        model.addAttribute("productosActivos", productosActivos());

        return "inventario/formulario";
    }

    // REGISTRAR MOVIMIENTO transaccion

    @PostMapping("/guardar")
    public String guardar(
            @Valid @ModelAttribute("movimientoDTO") MovimientoDTO dto,
            BindingResult resultado,
            Model model,
            RedirectAttributes redirectAttributes) {

        // Validar tipo

        if (dto.getTipo() != null
                && !dto.getTipo().isBlank()
                && !TIPOS.contains(dto.getTipo())) {

            resultado.rejectValue(
                    "tipo",
                    "tipo.invalido",
                    "Seleccione un tipo válido.");
        }

        // Errores de validacion - se vuelve al formulario

        if (resultado.hasErrors()) {
            model.addAttribute("productosActivos", productosActivos());
            return "inventario/formulario";
        }

        try {

            MovimientoInventario movimiento = movimientoService.registrar(
                    dto.getIdProducto(),
                    dto.getTipo(),
                    dto.getCantidad(),
                    dto.getMotivo());

            Producto producto = movimiento.getProducto();

            redirectAttributes.addFlashAttribute(
                    "mensajeExito",
                    "Movimiento registrado. Nuevo stock de "
                    + producto.getNombre() + ": "
                    + producto.getStockActual().toPlainString());

            return "redirect:/inventario";

        } catch (IllegalArgumentException | IllegalStateException ex) {

            // Mensajes propios del servicio - stock insuficiente, etc
            model.addAttribute("productosActivos", productosActivos());
            model.addAttribute("mensajeError", ex.getMessage());

            return "inventario/formulario";

        } catch (Exception ex) {

            model.addAttribute("productosActivos", productosActivos());
            model.addAttribute(
                    "mensajeError",
                    "No se pudo registrar el movimiento. "
                    + "Verifique los datos ingresados.");

            return "inventario/formulario";
        }
    }

    // PRODUCTOS ACTIVOS -solo estos admiten movimientos

    private List<Producto> productosActivos() {

        return productoService.listarTodos()
                .stream()
                .filter(p -> Boolean.TRUE.equals(p.getActivo()))
                .toList();
    }
}
