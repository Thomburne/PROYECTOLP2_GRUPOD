
package com.vetcontrol.controller;

import java.util.List;
import java.util.Locale;
import java.util.Optional;

import org.springframework.dao.DataIntegrityViolationException;
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

import com.vetcontrol.dto.CitaDTO;
import com.vetcontrol.entity.Cita;
import com.vetcontrol.entity.Mascota;
import com.vetcontrol.repository.ServicioRepository;
import com.vetcontrol.service.CitaService;
import com.vetcontrol.service.MascotaService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/citas")
@RequiredArgsConstructor
public class CitaController {

    private final CitaService citaService;
    private final MascotaService mascotaService;
    private final ServicioRepository servicioRepository;

    // LISTADO GENERAL
    @GetMapping({"", "/"})
    public String listar(Model model) {

        model.addAttribute(
            "citas", citaService.listarCitas()
        );

        model.addAttribute(
            "mascotaSeleccionada", null
        );

        return "citas/listado";
    }

    // HISTORIAL DE UNA MASCOTA
    @GetMapping("/mascota/{idMascota}")
    public String listarPorMascota(
            @PathVariable Long idMascota,
            Model model,
            RedirectAttributes redirect) {

        Optional<Mascota> encontrada =
            mascotaService.buscarPorId(idMascota);

        if (encontrada.isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "No se encontró la mascota."
            );

            return "redirect:/citas";
        }

        model.addAttribute(
            "citas",
            citaService.listarPorMascota(idMascota)
        );

        model.addAttribute(
            "mascotaSeleccionada",
            encontrada.get()
        );

        return "citas/listado";
    }

    // NUEVA CITA
    @GetMapping("/nuevo")
    public String nuevaCita(
            @RequestParam(
                name = "mascotaId",
                required = false
            ) Long mascotaId,
            Model model) {

        CitaDTO dto = new CitaDTO();

        dto.setMascotaId(mascotaId);
        dto.setEstado("PENDIENTE");

        model.addAttribute("citaDTO", dto);
        model.addAttribute("modoEdicion", false);

        cargarDatosFormulario(model, false, mascotaId);

        return "citas/formulario";
    }

    // GUARDAR CITA
    @PostMapping("/guardar")
    public String guardarCita(
            @Valid @ModelAttribute("citaDTO") CitaDTO dto,
            BindingResult resultado,
            Model model,
            RedirectAttributes redirect) {

        normalizar(dto);

        if (resultado.hasErrors()) {
            return mostrarFormulario(dto, false, model);
        }

        try {

            citaService.registrarCita(dto);

            redirect.addFlashAttribute(
                "mensajeExito",
                "Cita registrada correctamente."
            );

            return "redirect:/citas";

        } catch (IllegalArgumentException ex) {

            model.addAttribute(
                "mensajeError", ex.getMessage()
            );

        } catch (DataIntegrityViolationException ex) {

            model.addAttribute(
                "mensajeError",
                "No se pudo guardar la cita. "
                + "Revise el horario y el servicio."
            );
        }

        return mostrarFormulario(dto, false, model);
    }

    // EDITAR CITA
    @GetMapping("/{id}/editar")
    public String editarCita(
            @PathVariable Long id,
            Model model,
            RedirectAttributes redirect) {

        Optional<Cita> encontrada =
            citaService.buscarPorId(id);

        if (encontrada.isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "La cita no existe."
            );

            return "redirect:/citas";
        }

        CitaDTO dto = convertirDTO(encontrada.get());

        model.addAttribute("citaDTO", dto);
        model.addAttribute("modoEdicion", true);

        cargarDatosFormulario(
            model, true, dto.getMascotaId()
        );

        return "citas/formulario";
    }

    // ACTUALIZAR CITA
    @PostMapping("/{id}/actualizar")
    public String actualizarCita(
            @PathVariable Long id,
            @Valid @ModelAttribute("citaDTO") CitaDTO dto,
            BindingResult resultado,
            Model model,
            RedirectAttributes redirect) {

        if (citaService.buscarPorId(id).isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "No se encontró la cita."
            );

            return "redirect:/citas";
        }

        dto.setIdCita(id);
        normalizar(dto);

        if (resultado.hasErrors()) {
            return mostrarFormulario(dto, true, model);
        }

        try {

            citaService.actualizarCita(id, dto);

            redirect.addFlashAttribute(
                "mensajeExito",
                "Cita actualizada correctamente."
            );

            return "redirect:/citas";

        } catch (IllegalArgumentException ex) {

            model.addAttribute(
                "mensajeError", ex.getMessage()
            );

        } catch (DataIntegrityViolationException ex) {

            model.addAttribute(
                "mensajeError",
                "No se pudo actualizar la cita. "
                + "Verifique que no exista un horario duplicado."
            );
        }

        return mostrarFormulario(dto, true, model);
    }

    // CAMBIAR ESTADO
    @PostMapping("/{id}/estado")
    public String cambiarEstado(
            @PathVariable Long id,
            @RequestParam("estado") String estado,
            RedirectAttributes redirect) {

        try {

            citaService.cambiarEstado(id, estado);

            redirect.addFlashAttribute(
                "mensajeExito",
                "Estado actualizado correctamente."
            );

        } catch (IllegalArgumentException ex) {

            redirect.addFlashAttribute(
                "mensajeError", ex.getMessage()
            );

        } catch (DataIntegrityViolationException ex) {

            redirect.addFlashAttribute(
                "mensajeError",
                "No se pudo actualizar el estado."
            );
        }

        return "redirect:/citas";
    }

    // MAPEO DE CITA A DTO
    private CitaDTO convertirDTO(Cita cita) {

        CitaDTO dto = new CitaDTO();

        dto.setIdCita(cita.getIdCita());

        dto.setMascotaId(
            cita.getMascota().getIdMascota()
        );

        dto.setServicioId(
            cita.getServicioVeterinario().getIdServicio()
        );

        dto.setFechaHora(cita.getFechaHora());
        dto.setServicio(cita.getServicio());
        dto.setMotivo(cita.getMotivo());
        dto.setObservaciones(cita.getObservaciones());
        dto.setEstado(cita.getEstado());

        return dto;
    }

    // CARGAR MASCOTAS Y SERVICIOS PARA EL FORMULARIO
    private void cargarDatosFormulario(
            Model model,
            boolean modoEdicion,
            Long mascotaActualId) {

        List<Mascota> mascotas =
            mascotaService.listarMascotas()
                .stream()
                .filter(m ->
                    Boolean.TRUE.equals(m.getActivo())
                    || (
                        modoEdicion
                        && mascotaActualId != null
                        && mascotaActualId.equals(
                            m.getIdMascota()
                        )
                    )
                )
                .toList();

        model.addAttribute("mascotas", mascotas);

        model.addAttribute(
            "servicios",
            servicioRepository.findByActivoTrueOrderByNombreAsc()
        );
    }

    // RECUPERAR EL FORMULARIO SI HAY ERRORES
    private String mostrarFormulario(
            CitaDTO dto,
            boolean modoEdicion,
            Model model) {

        model.addAttribute("citaDTO", dto);
        model.addAttribute("modoEdicion", modoEdicion);

        cargarDatosFormulario(
            model,
            modoEdicion,
            dto.getMascotaId()
        );

        return "citas/formulario";
    }

    // LIMPIAR TEXTOS
    private void normalizar(CitaDTO dto) {

        dto.setMotivo(limpiar(dto.getMotivo()));

        dto.setObservaciones(
            limpiar(dto.getObservaciones())
        );

        dto.setEstado(
            limpiar(dto.getEstado())
                .toUpperCase(Locale.ROOT)
        );

        dto.setServicio(
            limpiar(dto.getServicio())
        );
    }

    private String limpiar(String texto) {
        return texto == null ? "" : texto.trim();
    }
}
