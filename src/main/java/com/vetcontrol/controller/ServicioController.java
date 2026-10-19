
package com.vetcontrol.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vetcontrol.dto.ServicioDTO;
import com.vetcontrol.entity.Servicio;
import com.vetcontrol.repository.ServicioRepository;
import com.vetcontrol.service.ServicioService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/servicios")
@RequiredArgsConstructor
public class ServicioController {

    private final ServicioService servicioService;
    private final ServicioRepository servicioRepository;

    // ==========================================
    // CATEGORIAS DISPONIBLES
    // ==========================================

    @ModelAttribute("categorias")
    public List<String> cargarCategorias() {

        return servicioRepository
                .findAllByOrderByNombreAsc()
                .stream()
                .map(Servicio::getCategoria)
                .filter(Objects::nonNull)
                .distinct()
                .sorted()
                .toList();
    }

    // ==========================================
    // LISTAR SERVICIOS
    // ==========================================

    @GetMapping({"", "/"})
    public String listar(Model model) {

        model.addAttribute(
                "servicios",
                servicioService.listarTodos()
        );

        return "servicios/listado";
    }

    // ==========================================
    // MOSTRAR FORMULARIO DE REGISTRO
    // ==========================================

    @GetMapping("/nuevo")
    public String nuevo(Model model) {

        ServicioDTO dto = new ServicioDTO();

        dto.setActivo(true);

        model.addAttribute(
                "servicioDTO",
                dto
        );

        model.addAttribute(
                "modoEdicion",
                false
        );

        return "servicios/formulario";
    }

    // ==========================================
    // MOSTRAR FORMULARIO DE EDICION
    // ==========================================

    @GetMapping("/{id}/editar")
    public String editar(
            @PathVariable("id") Long id,
            Model model,
            RedirectAttributes redirectAttributes) {

        Servicio servicio = servicioService
                .buscarPorId(id)
                .orElse(null);

        if (servicio == null) {

            redirectAttributes.addFlashAttribute(
                    "mensajeError",
                    "No se encontró el servicio solicitado."
            );

            return "redirect:/servicios";
        }

        ServicioDTO dto = convertirADTO(servicio);

        model.addAttribute(
                "servicioDTO",
                dto
        );

        model.addAttribute(
                "modoEdicion",
                true
        );

        return "servicios/formulario";
    }

    // ==========================================
    // GUARDAR SERVICIO
    // ==========================================

    @PostMapping("/guardar")
    public String guardar(
            @Valid @ModelAttribute("servicioDTO")
            ServicioDTO dto,
            BindingResult resultado,
            Model model,
            RedirectAttributes redirectAttributes) {

        boolean modoEdicion =
                dto.getIdServicio() != null;

        // Validar categoria

        List<String> categoriasPermitidas =
                cargarCategorias();

        if (dto.getCategoria() != null
                && !dto.getCategoria().isBlank()
                && !categoriasPermitidas.contains(
                        dto.getCategoria())) {

            resultado.rejectValue(
                    "categoria",
                    "categoria.invalida",
                    "Seleccione una categoría válida."
            );
        }

        // Validar precio

        if (dto.getPrecioReferencial() != null
                && dto.getPrecioReferencial()
                        .compareTo(BigDecimal.ZERO) < 0) {

            resultado.rejectValue(
                    "precioReferencial",
                    "precio.invalido",
                    "El precio no puede ser negativo."
            );
        }

        // Validar duplicados por nombre

        if (dto.getNombre() != null
                && !dto.getNombre().isBlank()) {

            String nombre =
                    dto.getNombre().trim();

            boolean duplicado;

            if (modoEdicion) {

                duplicado = servicioRepository
                        .existsByNombreIgnoreCaseAndIdServicioNot(
                                nombre,
                                dto.getIdServicio()
                        );

            } else {

                duplicado = servicioRepository
                        .existsByNombreIgnoreCase(
                                nombre
                        );
            }

            if (duplicado) {

                resultado.rejectValue(
                        "nombre",
                        "nombre.duplicado",
                        "Ya existe un servicio con este nombre."
                );
            }
        }

        // Errores de validacion

        if (resultado.hasErrors()) {

            model.addAttribute(
                    "modoEdicion",
                    modoEdicion
            );

            return "servicios/formulario";
        }

        Servicio servicio;

        // Editar servicio existente

        if (modoEdicion) {

            servicio = servicioService
                    .buscarPorId(
                            dto.getIdServicio()
                    )
                    .orElse(null);

            if (servicio == null) {

                redirectAttributes.addFlashAttribute(
                        "mensajeError",
                        "El servicio que intenta editar no existe."
                );

                return "redirect:/servicios";
            }

        } else {

            // Nuevo servicio
            servicio = new Servicio();
            servicio.setActivo(true);
        }

        // Asignar datos validados

        servicio.setNombre(
                dto.getNombre().trim()
        );

        servicio.setCategoria(
                dto.getCategoria()
        );

        servicio.setDescripcion(
                dto.getDescripcion()
        );

        servicio.setPrecioReferencial(
                dto.getPrecioReferencial()
        );

        servicio.setDuracionMinutos(
                dto.getDuracionMinutos()
        );

        // No modificar estado desde el formulario.
        // El cambio de estado tiene su propio metodo.

        try {

            servicioService.guardar(servicio);

            redirectAttributes.addFlashAttribute(
                    "mensajeExito",
                    modoEdicion
                            ? "Servicio actualizado correctamente."
                            : "Servicio registrado correctamente."
            );

            return "redirect:/servicios";

        } catch (Exception ex) {

            model.addAttribute(
                    "modoEdicion",
                    modoEdicion
            );

            model.addAttribute(
                    "mensajeError",
                    "No se pudo guardar el servicio. "
                    + "Verifique los datos registrados."
            );

            return "servicios/formulario";
        }
    }

    // ==========================================
    // ACTIVAR / DESACTIVAR SERVICIO
    // ==========================================

    @PostMapping("/{id}/cambiar-estado")
    public String cambiarEstado(
            @PathVariable("id") Long id,
            RedirectAttributes redirectAttributes) {

        try {

            servicioService.cambiarEstado(id);

            redirectAttributes.addFlashAttribute(
                    "mensajeExito",
                    "Estado del servicio actualizado correctamente."
            );

        } catch (IllegalArgumentException ex) {

            redirectAttributes.addFlashAttribute(
                    "mensajeError",
                    "No se encontró el servicio solicitado."
            );

        } catch (Exception ex) {

            redirectAttributes.addFlashAttribute(
                    "mensajeError",
                    "No se pudo cambiar el estado del servicio."
            );
        }

        return "redirect:/servicios";
    }

    // ==========================================
    // CONVERTIR SERVICIO A DTO
    // ==========================================

    private ServicioDTO convertirADTO(
            Servicio servicio) {

        ServicioDTO dto = new ServicioDTO();

        dto.setIdServicio(
                servicio.getIdServicio()
        );

        dto.setNombre(
                servicio.getNombre()
        );

        dto.setCategoria(
                servicio.getCategoria()
        );

        dto.setDescripcion(
                servicio.getDescripcion()
        );

        dto.setPrecioReferencial(
                servicio.getPrecioReferencial()
        );

        dto.setDuracionMinutos(
                servicio.getDuracionMinutos()
        );

        dto.setActivo(
                servicio.getActivo()
        );

        return dto;
    }
}
