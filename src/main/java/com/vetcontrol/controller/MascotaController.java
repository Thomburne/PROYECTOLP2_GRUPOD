
package com.vetcontrol.controller;

import java.time.LocalDate;
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

import com.vetcontrol.dto.MascotaDTO;
import com.vetcontrol.entity.Cliente;
import com.vetcontrol.entity.Mascota;
import com.vetcontrol.service.ClienteService;
import com.vetcontrol.service.MascotaService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/mascotas")
@RequiredArgsConstructor
public class MascotaController {

    private final MascotaService mascotaService;
    private final ClienteService clienteService;

    // LISTADO GENERAL
    @GetMapping({"", "/"})
    public String listar(Model model) {

        model.addAttribute(
            "mascotas",
            mascotaService.listarMascotas()
        );

        model.addAttribute("clienteSeleccionado", null);

        return "mascotas/listado";
    }

    // LISTADO DE MASCOTAS POR PROPIETARIO
    @GetMapping("/cliente/{idCliente}")
    public String listarPorCliente(
            @PathVariable Long idCliente,
            Model model,
            RedirectAttributes redirect) {

        Optional<Cliente> cliente =
            clienteService.buscarPorId(idCliente);

        if (cliente.isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "No se encontró al propietario solicitado."
            );

            return "redirect:/mascotas";
        }

        model.addAttribute(
            "mascotas",
            mascotaService.listarPorCliente(idCliente)
        );

        model.addAttribute(
            "clienteSeleccionado",
            cliente.get()
        );

        return "mascotas/listado";
    }

    // FORMULARIO DE NUEVA MASCOTA
    @GetMapping("/nuevo")
    public String nuevaMascota(
            @RequestParam(
                name = "clienteId",
                required = false
            ) Long clienteId,
            Model model) {

        MascotaDTO dto = new MascotaDTO();

        dto.setClienteId(clienteId);

        model.addAttribute("mascotaDTO", dto);
        model.addAttribute("modoEdicion", false);

        cargarClientes(model, false);

        return "mascotas/formulario";
    }

    // GUARDAR NUEVA MASCOTA
    @PostMapping("/guardar")
    public String guardarMascota(
            @Valid @ModelAttribute("mascotaDTO")
                MascotaDTO dto,
            BindingResult resultado,
            Model model,
            RedirectAttributes redirect) {

        normalizar(dto);

        if (resultado.hasErrors()) {
            return mostrarFormulario(dto, false, model);
        }

        Optional<Cliente> propietario =
            clienteService.buscarPorId(dto.getClienteId());

        if (propietario.isEmpty()) {

            resultado.rejectValue(
                "clienteId",
                "propietario.inexistente",
                "El propietario seleccionado no existe."
            );

            return mostrarFormulario(dto, false, model);
        }

        if (!Boolean.TRUE.equals(
                propietario.get().getActivo())) {

            resultado.rejectValue(
                "clienteId",
                "propietario.inactivo",
                "No se puede registrar una mascota "
                + "para un propietario inactivo."
            );

            return mostrarFormulario(dto, false, model);
        }

        if (fechaFutura(dto, resultado)) {
            return mostrarFormulario(dto, false, model);
        }

        Mascota nueva = new Mascota();

        copiarDatos(dto, nueva, propietario.get());

        nueva.setActivo(true);

        try {

            mascotaService.guardarMascota(nueva);

            redirect.addFlashAttribute(
                "mensajeExito",
                "Mascota registrada correctamente."
            );

            return "redirect:/mascotas/cliente/"
                + dto.getClienteId();

        } catch (DataIntegrityViolationException ex) {

            model.addAttribute(
                "mensajeError",
                "No se pudo registrar la mascota. "
                + "Verifique si el microchip ya existe."
            );

            return mostrarFormulario(dto, false, model);
        }
    }

    // FORMULARIO DE EDICION
    @GetMapping("/{id}/editar")
    public String editarMascota(
            @PathVariable Long id,
            Model model,
            RedirectAttributes redirect) {

        Optional<Mascota> encontrada =
            mascotaService.buscarPorId(id);

        if (encontrada.isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "No se encontró la mascota solicitada."
            );

            return "redirect:/mascotas";
        }

        MascotaDTO dto =
            convertirDTO(encontrada.get());

        model.addAttribute("mascotaDTO", dto);
        model.addAttribute("modoEdicion", true);

        cargarClientes(model, true);

        return "mascotas/formulario";
    }

    // ACTUALIZAR MASCOTA EXISTENTE
    @PostMapping("/{id}/actualizar")
    public String actualizarMascota(
            @PathVariable Long id,
            @Valid @ModelAttribute("mascotaDTO")
                MascotaDTO dto,
            BindingResult resultado,
            Model model,
            RedirectAttributes redirect) {

        Optional<Mascota> encontrada =
            mascotaService.buscarPorId(id);

        if (encontrada.isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "La mascota que desea editar no existe."
            );

            return "redirect:/mascotas";
        }

        normalizar(dto);

        // El ID válido proviene de la URL,
        // no del navegador.
        dto.setIdMascota(id);

        if (resultado.hasErrors()) {
            return mostrarFormulario(dto, true, model);
        }

        Optional<Cliente> propietario =
            clienteService.buscarPorId(dto.getClienteId());

        if (propietario.isEmpty()) {

            resultado.rejectValue(
                "clienteId",
                "propietario.inexistente",
                "El propietario seleccionado no existe."
            );

            return mostrarFormulario(dto, true, model);
        }

        if (!Boolean.TRUE.equals(
                propietario.get().getActivo())) {

            Long propietarioOriginal =
                encontrada.get().getCliente().getIdCliente();

            if (!propietarioOriginal.equals(
                    dto.getClienteId())) {

                resultado.rejectValue(
                    "clienteId",
                    "propietario.inactivo",
                    "No se puede trasladar una mascota "
                    + "a un propietario inactivo."
                );

                return mostrarFormulario(dto, true, model);
            }
        }

        if (fechaFutura(dto, resultado)) {
            return mostrarFormulario(dto, true, model);
        }

        Mascota mascota = encontrada.get();

        // Modificar únicamente los datos permitidos.
        // Conserva ID y estado de la mascota.
        copiarDatos(dto, mascota, propietario.get());

        try {

            mascotaService.guardarMascota(mascota);

            redirect.addFlashAttribute(
                "mensajeExito",
                "Mascota actualizada correctamente."
            );

            return "redirect:/mascotas/cliente/"
                + dto.getClienteId();

        } catch (DataIntegrityViolationException ex) {

            model.addAttribute(
                "mensajeError",
                "No se pudo actualizar la mascota. "
                + "Verifique si el microchip está duplicado."
            );

            return mostrarFormulario(dto, true, model);
        }
    }

    // ACTIVAR O DESACTIVAR MASCOTA
    @PostMapping("/{id}/cambiar-estado")
    public String cambiarEstado(
            @PathVariable Long id,
            RedirectAttributes redirect) {

        Optional<Mascota> encontrada =
            mascotaService.buscarPorId(id);

        if (encontrada.isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "No se encontró la mascota."
            );

            return "redirect:/mascotas";
        }

        Mascota mascota = encontrada.get();

        boolean estabaActiva =
            Boolean.TRUE.equals(mascota.getActivo());

        mascota.setActivo(!estabaActiva);

        try {

            mascotaService.guardarMascota(mascota);

            redirect.addFlashAttribute(
                "mensajeExito",
                estabaActiva
                    ? "Mascota desactivada correctamente."
                    : "Mascota activada correctamente."
            );

        } catch (DataIntegrityViolationException ex) {

            redirect.addFlashAttribute(
                "mensajeError",
                "No se pudo cambiar el estado."
            );
        }

        return "redirect:/mascotas/cliente/"
            + mascota.getCliente().getIdCliente();
    }

    // CONVERTIR ENTIDAD A DTO
    private MascotaDTO convertirDTO(Mascota mascota) {

        MascotaDTO dto = new MascotaDTO();

        dto.setIdMascota(mascota.getIdMascota());

        dto.setClienteId(
            mascota.getCliente().getIdCliente()
        );

        dto.setNombre(mascota.getNombre());
        dto.setEspecie(mascota.getEspecie());
        dto.setRaza(mascota.getRaza());
        dto.setSexo(mascota.getSexo());

        dto.setFechaNacimiento(
            mascota.getFechaNacimiento()
        );

        dto.setColor(mascota.getColor());
        dto.setPesoKg(mascota.getPesoKg());

        dto.setNroMicrochip(
            mascota.getNroMicrochip()
        );

        dto.setObservaciones(
            mascota.getObservaciones()
        );

        return dto;
    }

    // COPIAR LOS DATOS VALIDADOS A LA ENTIDAD
    private void copiarDatos(
            MascotaDTO dto,
            Mascota mascota,
            Cliente propietario) {

        mascota.setCliente(propietario);

        mascota.setNombre(dto.getNombre());
        mascota.setEspecie(dto.getEspecie());
        mascota.setRaza(dto.getRaza());
        mascota.setSexo(dto.getSexo());

        mascota.setFechaNacimiento(
            dto.getFechaNacimiento()
        );

        mascota.setColor(dto.getColor());
        mascota.setPesoKg(dto.getPesoKg());

        String microchip = dto.getNroMicrochip();

        mascota.setNroMicrochip(
            microchip == null || microchip.isBlank()
                ? null
                : microchip
        );

        mascota.setObservaciones(
            dto.getObservaciones()
        );
    }

    // VALIDAR FECHAS
    private boolean fechaFutura(
            MascotaDTO dto,
            BindingResult resultado) {

        LocalDate fecha = dto.getFechaNacimiento();

        if (fecha != null && fecha.isAfter(LocalDate.now())) {

            resultado.rejectValue(
                "fechaNacimiento",
                "fecha.futura",
                "La fecha de nacimiento no puede ser futura."
            );

            return true;
        }

        return false;
    }

    // NORMALIZAR DATOS DEL FORMULARIO
    private void normalizar(MascotaDTO dto) {

        dto.setNombre(limpiar(dto.getNombre()));
        dto.setEspecie(limpiar(dto.getEspecie()));
        dto.setRaza(limpiar(dto.getRaza()));
        dto.setSexo(limpiar(dto.getSexo()));
        dto.setColor(limpiar(dto.getColor()));

        dto.setNroMicrochip(
            limpiar(dto.getNroMicrochip())
        );

        dto.setObservaciones(
            limpiar(dto.getObservaciones())
        );
    }

    // CARGAR PROPIETARIOS
    private void cargarClientes(
            Model model,
            boolean modoEdicion) {

        model.addAttribute(
            "clientes",
            modoEdicion
                ? clienteService.listarClientes()
                : clienteService.listarActivos()
        );
    }

    // MOSTRAR FORMULARIO CON ERRORES
    private String mostrarFormulario(
            MascotaDTO dto,
            boolean modoEdicion,
            Model model) {

        model.addAttribute("mascotaDTO", dto);
        model.addAttribute("modoEdicion", modoEdicion);

        cargarClientes(model, modoEdicion);

        return "mascotas/formulario";
    }

    private String limpiar(String valor) {
        return valor == null ? "" : valor.trim();
    }
}
