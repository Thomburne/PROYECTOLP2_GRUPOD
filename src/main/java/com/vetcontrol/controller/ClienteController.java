
package com.vetcontrol.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vetcontrol.dto.ClienteDTO;
import com.vetcontrol.entity.Cliente;
import com.vetcontrol.service.ClienteService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping({"/clientes", "/cliente"})
@RequiredArgsConstructor
public class ClienteController {

    private final ClienteService clienteService;

    // ==========================================
    // LISTADO DE CLIENTES
    // ==========================================
    @GetMapping({"", "/"})
    public String listarClientes(Model model) {

        model.addAttribute(
            "clientes",
            clienteService.listarClientes()
        );

        return "clientes/listado";
    }

    // ==========================================
    // FORMULARIO NUEVO CLIENTE
    // ==========================================
    @GetMapping("/nuevo")
    public String nuevoCliente(Model model) {

        model.addAttribute(
            "clienteDTO",
            new ClienteDTO()
        );

        model.addAttribute("modoEdicion", false);

        return "clientes/formulario";
    }

    // ==========================================
    // REGISTRAR CLIENTE
    // ==========================================
    @PostMapping("/guardar")
    public String guardarCliente(
            @Valid @ModelAttribute("clienteDTO")
            ClienteDTO dto,
            BindingResult resultado,
            Model model,
            RedirectAttributes redirect) {

        normalizar(dto);

        if (resultado.hasErrors()) {
            return mostrarFormulario(dto, false, model);
        }

        if (documentoDuplicado(dto, null)) {

            resultado.rejectValue(
                "nroDocumento",
                "duplicado",
                "Ya existe un cliente con ese documento."
            );

            return mostrarFormulario(dto, false, model);
        }

        Cliente cliente = new Cliente();

        copiarDatos(dto, cliente);

        cliente.setActivo(true);
        cliente.setFechaRegistro(null);

        try {

            clienteService.guardarCliente(cliente);

            redirect.addFlashAttribute(
                "mensajeExito",
                "Cliente registrado correctamente."
            );

            return "redirect:/clientes";

        } catch (DataIntegrityViolationException ex) {

            model.addAttribute(
                "mensajeError",
                "No se pudo registrar el cliente. "
                + "Compruebe que el documento no "
                + "esté duplicado."
            );

            return mostrarFormulario(dto, false, model);
        }
    }

    // ==========================================
    // FORMULARIO EDITAR CLIENTE
    // ==========================================
    @GetMapping("/{id}/editar")
    public String editarCliente(
            @PathVariable Long id,
            Model model,
            RedirectAttributes redirect) {

        Optional<Cliente> encontrado =
            clienteService.buscarPorId(id);

        if (encontrado.isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "El cliente solicitado no existe."
            );

            return "redirect:/clientes";
        }

        ClienteDTO dto =
            convertirDTO(encontrado.get());

        model.addAttribute("clienteDTO", dto);
        model.addAttribute("modoEdicion", true);

        return "clientes/formulario";
    }

    // ==========================================
    // ACTUALIZAR CLIENTE
    // ==========================================
    @PostMapping("/{id}/actualizar")
    public String actualizarCliente(
            @PathVariable Long id,
            @Valid @ModelAttribute("clienteDTO")
            ClienteDTO dto,
            BindingResult resultado,
            Model model,
            RedirectAttributes redirect) {

        Optional<Cliente> encontrado =
            clienteService.buscarPorId(id);

        if (encontrado.isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "El cliente que desea editar no existe."
            );

            return "redirect:/clientes";
        }

        normalizar(dto);
        dto.setIdCliente(id);

        if (resultado.hasErrors()) {
            return mostrarFormulario(dto, true, model);
        }

        if (documentoDuplicado(dto, id)) {

            resultado.rejectValue(
                "nroDocumento",
                "duplicado",
                "El documento pertenece a otro cliente."
            );

            return mostrarFormulario(dto, true, model);
        }

        Cliente cliente = encontrado.get();

        // CORRECCION IMPORTANTE:
        // COPIAR LOS NUEVOS DATOS ANTES DE GUARDAR
        copiarDatos(dto, cliente);

        try {

            clienteService.guardarCliente(cliente);

            redirect.addFlashAttribute(
                "mensajeExito",
                "Cliente actualizado correctamente."
            );

            return "redirect:/clientes";

        } catch (DataIntegrityViolationException ex) {

            model.addAttribute(
                "mensajeError",
                "No se pudo actualizar el cliente. "
                + "Verifique la información."
            );

            return mostrarFormulario(dto, true, model);
        }
    }

    // ==========================================
    // ACTIVAR / DESACTIVAR CLIENTE
    // ==========================================
    @PostMapping("/{id}/cambiar-estado")
    public String cambiarEstado(
            @PathVariable Long id,
            RedirectAttributes redirect) {

        Optional<Cliente> encontrado =
            clienteService.buscarPorId(id);

        if (encontrado.isEmpty()) {

            redirect.addFlashAttribute(
                "mensajeError",
                "No se encontró el cliente."
            );

            return "redirect:/clientes";
        }

        Cliente cliente = encontrado.get();

        boolean estabaActivo =
            Boolean.TRUE.equals(
                cliente.getActivo()
            );

        cliente.setActivo(!estabaActivo);

        try {

            clienteService.guardarCliente(cliente);

            redirect.addFlashAttribute(
                "mensajeExito",
                estabaActivo
                    ? "Cliente desactivado correctamente."
                    : "Cliente activado correctamente."
            );

        } catch (DataIntegrityViolationException ex) {

            redirect.addFlashAttribute(
                "mensajeError",
                "No se pudo cambiar el estado del cliente."
            );
        }

        return "redirect:/clientes";
    }

    // ==========================================
    // CONVERTIR ENTIDAD A DTO
    // ==========================================
    private ClienteDTO convertirDTO(
            Cliente cliente) {

        ClienteDTO dto = new ClienteDTO();

        dto.setIdCliente(
            cliente.getIdCliente()
        );

        dto.setTipoDocumento(
            cliente.getTipoDocumento()
        );

        dto.setNroDocumento(
            cliente.getNroDocumento()
        );

        dto.setNombresRazonSocial(
            cliente.getNombresRazonSocial()
        );

        dto.setApellidos(
            cliente.getApellidos()
        );

        dto.setCelular(
            cliente.getCelular()
        );

        dto.setCorreo(
            cliente.getCorreo()
        );

        dto.setDireccion(
            cliente.getDireccion()
        );

        return dto;
    }

    // ==========================================
    // COPIAR DATOS DEL FORMULARIO
    // ==========================================
    private void copiarDatos(
            ClienteDTO dto,
            Cliente cliente) {

        cliente.setTipoDocumento(
            dto.getTipoDocumento()
        );

        cliente.setNroDocumento(
            dto.getNroDocumento()
        );

        cliente.setNombresRazonSocial(
            dto.getNombresRazonSocial()
        );

        cliente.setApellidos(
            dto.getApellidos()
        );

        cliente.setCelular(
            dto.getCelular()
        );

        cliente.setCorreo(
            dto.getCorreo()
        );

        cliente.setDireccion(
            dto.getDireccion()
        );
    }

    // ==========================================
    // VALIDAR DOCUMENTO DUPLICADO
    // ==========================================
    private boolean documentoDuplicado(
            ClienteDTO dto,
            Long idActual) {

        Optional<Cliente> encontrado =
            clienteService.buscarPorDocumento(
                dto.getTipoDocumento(),
                dto.getNroDocumento()
            );

        if (encontrado.isEmpty()) {
            return false;
        }

        return idActual == null
            || !idActual.equals(
                encontrado.get().getIdCliente()
            );
    }

    // ==========================================
    // NORMALIZAR DATOS
    // ==========================================
    private void normalizar(ClienteDTO dto) {

        dto.setTipoDocumento(
            limpiar(dto.getTipoDocumento())
                .toUpperCase()
        );

        dto.setNroDocumento(
            limpiar(dto.getNroDocumento())
        );

        dto.setNombresRazonSocial(
            limpiar(dto.getNombresRazonSocial())
        );

        dto.setApellidos(
            limpiar(dto.getApellidos())
        );

        dto.setCelular(
            limpiar(dto.getCelular())
        );

        dto.setCorreo(
            limpiar(dto.getCorreo())
        );

        dto.setDireccion(
            limpiar(dto.getDireccion())
        );
    }

    // ==========================================
    // LIMPIAR ESPACIOS
    // ==========================================
    private String limpiar(String dato) {

        return dato == null
            ? ""
            : dato.trim();
    }

    // ==========================================
    // MOSTRAR FORMULARIO
    // ==========================================
    private String mostrarFormulario(
            ClienteDTO dto,
            boolean modoEdicion,
            Model model) {

        model.addAttribute(
            "clienteDTO",
            dto
        );

        model.addAttribute(
            "modoEdicion",
            modoEdicion
        );

        return "clientes/formulario";
    }
}
