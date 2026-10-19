
package com.vetcontrol.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.vetcontrol.repository.ClienteRepository;
import com.vetcontrol.repository.MascotaRepository;
import com.vetcontrol.repository.CitaRepository;
import com.vetcontrol.repository.ServicioRepository;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class DashboardController {

    private final ClienteRepository clienteRepository;
    private final MascotaRepository mascotaRepository;
    private final CitaRepository citaRepository;
    private final ServicioRepository servicioRepository;

    @GetMapping("/dashboard")
    public String mostrarDashboard(
            Authentication authentication,
            Model model) {

        boolean esAdmin = authentication
                .getAuthorities()
                .stream()
                .map(GrantedAuthority::getAuthority)
                .anyMatch("ROLE_ADMIN"::equals);

        model.addAttribute(
                "username",
                authentication.getName()
        );

        model.addAttribute(
                "rol",
                esAdmin ? "ADMIN" : "EMPLEADO"
        );

        model.addAttribute("esAdmin", esAdmin);

        // Conteos reales de MySQL
        model.addAttribute(
                "totalClientes",
                clienteRepository.count()
        );

        model.addAttribute(
                "totalMascotas",
                mascotaRepository.count()
        );

        model.addAttribute(
                "totalCitas",
                citaRepository.count()
        );

        model.addAttribute(
                "totalServicios",
                servicioRepository.count()
        );

        return "dashboard";
    }
}
