
package com.vetcontrol.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CitaDTO {

    private Long idCita;

    // MASCOTA SELECCIONADA
    @NotNull(message = "Seleccione una mascota")
    private Long mascotaId;

    // SERVICIO SELECCIONADO DEL CATALOGO MYSQL
    @NotNull(message = "Seleccione un servicio veterinario")
    private Long servicioId;

    // FECHA Y HORA
    @NotNull(message = "Seleccione fecha y hora de atencion")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime fechaHora;

    // CAMPO TEXTUAL ANTERIOR
    // SE COMPLETARA DESDE EL SERVICIO ELEGIDO
    @Size(
        max = 40,
        message = "El servicio admite hasta 40 caracteres"
    )
    private String servicio;

    // MOTIVO
    @NotBlank(message = "Ingrese el motivo de la cita")
    @Size(
        max = 255,
        message = "El motivo admite hasta 255 caracteres"
    )
    private String motivo;

    // OBSERVACIONES
    @Size(
        max = 500,
        message = "Las observaciones admiten hasta 500 caracteres"
    )
    private String observaciones;

    // ESTADO
    @NotBlank(message = "Seleccione un estado")
    @Pattern(
        regexp = "PENDIENTE|CONFIRMADA|ATENDIDA|CANCELADA",
        message = "Seleccione un estado valido"
    )
    private String estado = "PENDIENTE";
}
