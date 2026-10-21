
package com.vetcontrol.controller;

import java.util.Comparator;
import java.util.List;
import java.util.Locale;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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

    // LISTAR Y MOSTRAR FORMULARIO
    @GetMapping({"", "/"})
    public String listar(Model model) {

        cargarUsuarios(model);

        if (!model.containsAttribute("formulario")) {
            model.addAttribute(
                "formulario",
                new UsuarioFormulario()
            );
        }

        return "usuarios/listado";
    }

    // REGISTRAR USUARIO
    @PostMapping("/guardar")
    public String guardar(
            @ModelAttribute("formulario")
            UsuarioFormulario formulario,
            Model model,
            RedirectAttributes redirect) {

        String nombres = limpiar(formulario.getNombres());

        String username = limpiar(
            formulario.getUsername()
        ).toLowerCase(Locale.ROOT);

        String correo = limpiar(
            formulario.getCorreo()
        ).toLowerCase(Locale.ROOT);

        String clave = formulario.getPassword();

        String rol = limpiar(
            formulario.getRol()
        ).toUpperCase(Locale.ROOT);

        formulario.setNombres(nombres);
        formulario.setUsername(username);
        formulario.setCorreo(correo);
        formulario.setRol(rol);
        formulario.setPassword("");

        String error = validar(
            nombres, username, correo, clave, rol
        );

        if (error != null) {
            cargarUsuarios(model);
            model.addAttribute("error", error);
            return "usuarios/listado";
        }

        try {

            Usuario usuario = new Usuario();

            usuario.setNombres(nombres);
            usuario.setUsername(username);
            usuario.setCorreo(correo);
            usuario.setRol(rol);
            usuario.setActivo(true);

            // GUARDAR SOLO EL HASH BCRYPT
            usuario.setPassword(
                passwordEncoder.encode(clave)
            );

            usuarioRepository.saveAndFlush(usuario);

            redirect.addFlashAttribute(
                "mensaje",
                "Usuario registrado correctamente: "
                + username
            );

            return "redirect:/usuarios";

        } catch (DataIntegrityViolationException ex) {

            cargarUsuarios(model);

            model.addAttribute(
                "error",
                "No se pudo guardar el usuario. "
                + "Revise el nombre de acceso y correo."
            );

            return "usuarios/listado";
        }
    }

    private String validar(
            String nombres,
            String username,
            String correo,
            String clave,
            String rol) {

        if (nombres.isBlank() || nombres.length() > 120) {
            return "Ingrese nombres completos válidos.";
        }

        if (!username.matches("[a-z0-9._-]{4,50}")) {
            return "El usuario debe tener entre 4 y 50 "
                 + "caracteres: letras, números, puntos "
                 + "o guiones.";
        }

        if (correo.isBlank()
                || correo.length() > 150
                || !correo.matches(
                    "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            return "Ingrese un correo electrónico válido.";
        }

        if (clave == null
                || clave.length() < 10
                || clave.length() > 72) {
            return "La contraseña debe tener entre "
                 + "10 y 72 caracteres.";
        }

        if (!rol.equals("ADMIN")
                && !rol.equals("EMPLEADO")) {
            return "Seleccione un rol válido.";
        }

        if (usuarioRepository.existsByUsername(username)) {
            return "El nombre de usuario ya existe.";
        }

        if (usuarioRepository.findByCorreo(correo).isPresent()) {
            return "El correo ya está registrado.";
        }

        return null;
    }

    private void cargarUsuarios(Model model) {

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

    private String limpiar(String valor) {
        return valor == null ? "" : valor.trim();
    }

    // FORMULARIO INTERNO
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
