
package com.vetcontrol.dto;

import java.math.BigDecimal;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

@Getter
@Setter
@NoArgsConstructor
public class ServicioDTO {

    private Long idServicio;

    @NotBlank(message = "Ingrese el nombre del servicio")
    @Size(max = 100,
          message = "El nombre no debe superar 100 caracteres")
    private String nombre;

    @NotBlank(message = "Seleccione una categoría")
    private String categoria;

    @Size(max = 500,
          message = "La descripción no debe superar 500 caracteres")
    private String descripcion;

    @NotNull(message = "Ingrese el precio del servicio")
    @DecimalMin(value = "0.00",
                message = "El precio no puede ser negativo")
    @Digits(integer = 8, fraction = 2,
            message = "Ingrese un precio válido con máximo 2 decimales")
    private BigDecimal precioReferencial;

    @Min(value = 1,
         message = "La duración debe ser mayor que cero")
    private Integer duracionMinutos;

    private Boolean activo = true;
}
