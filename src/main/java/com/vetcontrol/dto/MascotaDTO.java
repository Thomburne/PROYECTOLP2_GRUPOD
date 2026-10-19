
package com.vetcontrol.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
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
public class MascotaDTO {

    private Long idMascota;

    @NotNull(message = "Seleccione el propietario")
    private Long clienteId;

    @NotBlank(message = "Ingrese el nombre de la mascota")
    @Size(
        max = 80,
        message = "Máximo 80 caracteres"
    )
    private String nombre;

    @NotBlank(message = "Seleccione la especie")
    @Size(
        max = 50,
        message = "Máximo 50 caracteres"
    )
    private String especie;

    @Size(
        max = 80,
        message = "Máximo 80 caracteres"
    )
    private String raza;

    @NotBlank(message = "Seleccione el sexo")
    @Pattern(
        regexp = "M|H",
        message = "Seleccione Macho o Hembra"
    )
    private String sexo;

    @PastOrPresent(
        message = "La fecha de nacimiento "
                + "no puede ser futura"
    )
    private LocalDate fechaNacimiento;

    @Size(
        max = 60,
        message = "Máximo 60 caracteres"
    )
    private String color;

    @DecimalMin(
        value = "0.01",
        message = "El peso debe ser mayor que cero"
    )
    @Digits(
        integer = 4,
        fraction = 2,
        message = "El peso admite hasta 4 enteros "
                + "y 2 decimales"
    )
    private BigDecimal pesoKg;

    @Size(
        max = 50,
        message = "Máximo 50 caracteres"
    )
    private String nroMicrochip;

    @Size(
        max = 500,
        message = "Máximo 500 caracteres"
    )
    private String observaciones;
}
