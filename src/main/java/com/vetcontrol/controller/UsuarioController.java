
package com.vetcontrol.controller;

import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vetcontrol.entity.Usuario;
import com.vetcontrol.repository.UsuarioRepository;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/usuarios")
@RequiredArgsConstructor
public class UsuarioController {

    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;

    // =========================================
    // LISTAR USUARIOS
    // =========================================
    @GetMapping({"", "/"})
    public String listar(Model model) {

        cargarListado(model);

        if (!model.containsAttribute("formulario")) {
            model.addAttribute(
                "formulario",
                new UsuarioFormulario()
            );
        }

        return "usuarios/listado";
    }

    // =========================================
    // REGISTRAR USUARIO
    // =========================================
    @PostMapping("/guardar")
    public String guardar(
            @ModelAttribute("formulario")
            UsuarioFormulario formulario,
            Model model,
            RedirectAttributes redirect) {

        normalizarFormulario(formulario);

        String error = validarDatos(
            formulario, null, true
        );

        if (error != null) {
            cargarListado(model);
            model.addAttribute("error", error);
            formulario.setPassword("");
            return "usuarios/listado";
        }

        try {
            Usuario usuario = new Usuario();

            copiarDatos(formulario, usuario);

            usuario.setPassword(
                passwordEncoder.encode(
                    formulario.getPassword()
                )
            );

            usuario.setActivo(true);

            usuarioRepository.saveAndFlush(usuario);

            redirect.addFlashAttribute(
                "mensaje",
                "Usuario registrado correctamente."
            );

        } catch (DataIntegrityViolationException ex) {

            redirect.addFlashAttribute(
                "error",
                "No se pudo registrar. Verifique "
                + "que usuario y correo sean únicos."
            );
        }

        return "redirect:/usuarios";
    }

    // =========================================
    // FORMULARIO EDITAR
    // =========================================
    @GetMapping("/{id}/editar")
    public String editar(
            @PathVariable Long id,
            Model model,
            Authentication authentication,
            RedirectAttributes redirect) {

        Optional<Usuario> encontrado =
            usuarioRepository.findById(id);

        if (encontrado.isEmpty()) {

            redirect.addFlashAttribute(
                "error",
                "El usuario no existe."
            );

            return "redirect:/usuarios";
        }

        Usuario usuario = encontrado.get();

        UsuarioFormulario formulario =
            convertirFormulario(usuario);

        model.addAttribute("formulario", formulario);
        model.addAttribute("usuario", usuario);

        model.addAttribute(
            "esCuentaPropia",
            esCuentaActual(usuario, authentication)
        );

        return "usuarios/editar";
    }

    // =========================================
    // ACTUALIZAR DATOS DE USUARIO
    // =========================================
    @PostMapping("/{id}/actualizar")
    public String actualizar(
            @PathVariable Long id,
            @ModelAttribute("formulario")
            UsuarioFormulario formulario,
            Authentication authentication,
            RedirectAttributes redirect) {

        Optional<Usuario> encontrado =
            usuarioRepository.findById(id);

        if (encontrado.isEmpty()) {

            redirect.addFlashAttribute(
                "error",
                "El usuario no existe."
            );

            return "redirect:/usuarios";
        }

        Usuario usuario = encontrado.get();

        normalizarFormulario(formulario);

        // LA CONTRASEÑA NO SE MODIFICA AQUÍ
        formulario.setPassword("");

        String error = validarDatos(
            formulario, id, false
        );

        if (error != null) {

            redirect.addFlashAttribute("error", error);

            return "redirect:/usuarios/"
                + id + "/editar";
        }

        boolean cuentaPropia =
            esCuentaActual(usuario, authentication);

        if (cuentaPropia) {

            // EVITAR QUITARSE EL ACCESO ADMIN
            if (!"ADMIN".equals(formulario.getRol())) {

                redirect.addFlashAttribute(
                    "error",
                    "No puede quitarse su propio "
                    + "rol de administrador."
                );

                return "redirect:/usuarios/"
                    + id + "/editar";
            }

            // CAMBIAR USERNAME ROMPERÍA LA SESIÓN ACTUAL
            if (!usuario.getUsername().equals(
                    formulario.getUsername())) {

                redirect.addFlashAttribute(
                    "error",
                    "No puede cambiar su usuario "
                    + "de acceso mientras está conectado."
                );

                return "redirect:/usuarios/"
                    + id + "/editar";
            }
        }

        if (esUltimoAdministradorActivo(usuario)
                && !"ADMIN".equals(formulario.getRol())) {

            redirect.addFlashAttribute(
                "error",
                "No puede cambiar el rol del "
                + "último administrador activo."
            );

            return "redirect:/usuarios/"
                + id + "/editar";
        }

        try {

            copiarDatos(formulario, usuario);

            usuarioRepository.saveAndFlush(usuario);

            redirect.addFlashAttribute(
                "mensaje",
                "Usuario actualizado correctamente."
            );

            return "redirect:/usuarios";

        } catch (DataIntegrityViolationException ex) {

            redirect.addFlashAttribute(
                "error",
                "No se pudo actualizar. "
                + "Verifique datos duplicados."
            );

            return "redirect:/usuarios/"
                + id + "/editar";
        }
    }

    // =========================================
    // ACTIVAR / DESACTIVAR
    // =========================================
    @PostMapping("/{id}/cambiar-estado")
    public String cambiarEstado(
            @PathVariable Long id,
            Authentication authentication,
            RedirectAttributes redirect) {

        Optional<Usuario> encontrado =
            usuarioRepository.findById(id);

        if (encontrado.isEmpty()) {

            redirect.addFlashAttribute(
                "error",
                "El usuario no existe."
            );

            return "redirect:/usuarios";
        }

        Usuario usuario = encontrado.get();

        if (esCuentaActual(usuario, authentication)) {

            redirect.addFlashAttribute(
                "error",
                "No puede cambiar el estado "
                + "de su propia cuenta."
            );

            return "redirect:/usuarios";
        }

        boolean activo =
            Boolean.TRUE.equals(usuario.getActivo());

        if (activo
                && esUltimoAdministradorActivo(usuario)) {

            redirect.addFlashAttribute(
                "error",
                "No puede desactivar al "
                + "último administrador activo."
            );

            return "redirect:/usuarios";
        }

        usuario.setActivo(!activo);

        usuarioRepository.saveAndFlush(usuario);

        redirect.addFlashAttribute(
            "mensaje",
            activo
                ? "Usuario desactivado correctamente."
                : "Usuario activado correctamente."
        );

        return "redirect:/usuarios";
    }

    // =========================================
    // RESTABLECER CONTRASEÑA
    // =========================================
    @PostMapping("/{id}/restablecer-clave")
    public String restablecerClave(
            @PathVariable Long id,
            String nuevaClave,
            String confirmarClave,
            Authentication authentication,
            RedirectAttributes redirect) {

        Optional<Usuario> encontrado =
            usuarioRepository.findById(id);

        if (encontrado.isEmpty()) {

            redirect.addFlashAttribute(
                "error",
                "El usuario no existe."
            );

            return "redirect:/usuarios";
        }

        Usuario usuario = encontrado.get();

        if (esCuentaActual(usuario, authentication)) {

            redirect.addFlashAttribute(
                "error",
                "Por seguridad, no puede restablecer "
                + "su propia clave desde este módulo."
            );

            return "redirect:/usuarios";
        }

        if (nuevaClave == null
                || nuevaClave.length() < 10
                || nuevaClave.length() > 72) {

            redirect.addFlashAttribute(
                "error",
                "La nueva contraseña debe tener "
                + "entre 10 y 72 caracteres."
            );

            return "redirect:/usuarios";
        }

        if (!nuevaClave.equals(confirmarClave)) {

            redirect.addFlashAttribute(
                "error",
                "Las contraseñas no coinciden."
            );

            return "redirect:/usuarios";
        }

        usuario.setPassword(
            passwordEncoder.encode(nuevaClave)
        );

        usuarioRepository.saveAndFlush(usuario);

        redirect.addFlashAttribute(
            "mensaje",
            "Contraseña restablecida correctamente "
            + "para " + usuario.getUsername() + "."
        );

        return "redirect:/usuarios";
    }

    // =========================================
    // ELIMINAR USUARIO
    // =========================================
    @PostMapping("/{id}/eliminar")
    public String eliminar(
            @PathVariable Long id,
            Authentication authentication,
            RedirectAttributes redirect) {

        Optional<Usuario> encontrado =
            usuarioRepository.findById(id);

        if (encontrado.isEmpty()) {

            redirect.addFlashAttribute(
                "error",
                "El usuario ya no existe."
            );

            return "redirect:/usuarios";
        }

        Usuario usuario = encontrado.get();

        if (esCuentaActual(usuario, authentication)) {

            redirect.addFlashAttribute(
                "error",
                "No puede eliminar su propia cuenta."
            );

            return "redirect:/usuarios";
        }

        if (esUltimoAdministradorActivo(usuario)) {

            redirect.addFlashAttribute(
                "error",
                "No puede eliminar al "
                + "último administrador activo."
            );

            return "redirect:/usuarios";
        }

        try {

            usuarioRepository.delete(usuario);
            usuarioRepository.flush();

            redirect.addFlashAttribute(
                "mensaje",
                "Usuario eliminado correctamente."
            );

        } catch (DataIntegrityViolationException ex) {

            redirect.addFlashAttribute(
                "error",
                "No es posible eliminar este usuario "
                + "porque tiene registros relacionados. "
                + "Puede desactivarlo."
            );
        }

        return "redirect:/usuarios";
    }

    // =========================================
    // VALIDACIONES
    // =========================================
    private String validarDatos(
            UsuarioFormulario formulario,
            Long idActual,
            boolean validarPassword) {

        if (formulario.getNombres().isBlank()
                || formulario.getNombres().length() > 120) {

            return "Ingrese un nombre válido.";
        }

        if (!formulario.getUsername().matches(
                "[a-z0-9._-]{4,50}")) {

            return "El usuario debe tener entre "
                + "4 y 50 caracteres válidos.";
        }

        if (formulario.getCorreo().isBlank()
                || formulario.getCorreo().length() > 150
                || !formulario.getCorreo().matches(
                    "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {

            return "Ingrese un correo válido.";
        }

        if (!"ADMIN".equals(formulario.getRol())
                && !"EMPLEADO".equals(formulario.getRol())) {

            return "Seleccione un rol válido.";
        }

        if (validarPassword) {

            String clave = formulario.getPassword();

            if (clave == null
                    || clave.length() < 10
                    || clave.length() > 72) {

                return "La contraseña debe tener "
                    + "entre 10 y 72 caracteres.";
            }
        }

        Optional<Usuario> porUsername =
            usuarioRepository.findByUsername(
                formulario.getUsername()
            );

        if (porUsername.isPresent()
                && !porUsername.get().getIdUsuario()
                    .equals(idActual)) {

            return "El nombre de usuario ya existe.";
        }

        Optional<Usuario> porCorreo =
            usuarioRepository.findByCorreo(
                formulario.getCorreo()
            );

        if (porCorreo.isPresent()
                && !porCorreo.get().getIdUsuario()
                    .equals(idActual)) {

            return "El correo ya está registrado.";
        }

        return null;
    }

    // =========================================
    // PROTEGER EL ÚLTIMO ADMINISTRADOR
    // =========================================
    private boolean esUltimoAdministradorActivo(
            Usuario usuario) {

        if (!"ADMIN".equals(usuario.getRol())
                || !Boolean.TRUE.equals(usuario.getActivo())) {

            return false;
        }

        long totalAdministradores =
            usuarioRepository.findAll().stream()
                .filter(u -> "ADMIN".equals(u.getRol()))
                .filter(u -> Boolean.TRUE.equals(u.getActivo()))
                .count();

        return totalAdministradores <= 1;
    }

    private boolean esCuentaActual(
            Usuario usuario,
            Authentication authentication) {

        return authentication != null
            && authentication.isAuthenticated()
            && usuario.getUsername() != null
            && usuario.getUsername().equalsIgnoreCase(
                authentication.getName()
            );
    }

    // =========================================
    // CONVERTIR Y COPIAR DATOS
    // =========================================
    private UsuarioFormulario convertirFormulario(
            Usuario usuario) {

        UsuarioFormulario dto = new UsuarioFormulario();

        dto.setNombres(usuario.getNombres());
        dto.setUsername(usuario.getUsername());
        dto.setCorreo(usuario.getCorreo());
        dto.setRol(usuario.getRol());

        return dto;
    }

    private void copiarDatos(
            UsuarioFormulario dto,
            Usuario usuario) {

        usuario.setNombres(dto.getNombres());
        usuario.setUsername(dto.getUsername());
        usuario.setCorreo(dto.getCorreo());
        usuario.setRol(dto.getRol());
    }

    private void normalizarFormulario(
            UsuarioFormulario formulario) {

        formulario.setNombres(
            limpiar(formulario.getNombres())
        );

        formulario.setUsername(
            limpiar(formulario.getUsername())
                .toLowerCase(Locale.ROOT)
        );

        formulario.setCorreo(
            limpiar(formulario.getCorreo())
                .toLowerCase(Locale.ROOT)
        );

        formulario.setRol(
            limpiar(formulario.getRol())
                .toUpperCase(Locale.ROOT)
        );
    }

    private String limpiar(String valor) {
        return valor == null ? "" : valor.trim();
    }

    private void cargarListado(Model model) {

        List<Usuario> usuarios =
            usuarioRepository.findAll();

        usuarios.sort(
            Comparator.comparing(
                Usuario::getIdUsuario,
                Comparator.nullsLast(
                    Comparator.reverseOrder()
                )
            )
        );

        model.addAttribute("usuarios", usuarios);
        model.addAttribute("totalUsuarios", usuarios.size());
    }

    // =========================================
    // DTO DEL FORMULARIO
    // =========================================
    public static class UsuarioFormulario {

        private String nombres = "";
        private String username = "";
        private String correo = "";
        private String password = "";
        private String rol = "EMPLEADO";

        public String getNombres() {
            return nombres;
        }

        public void setNombres(String nombres) {
            this.nombres = nombres;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getCorreo() {
            return correo;
        }

        public void setCorreo(String correo) {
            this.correo = correo;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String getRol() {
            return rol;
        }

        public void setRol(String rol) {
            this.rol = rol;
        }
    }
}
