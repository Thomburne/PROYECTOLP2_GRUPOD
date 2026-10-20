package com.vetcontrol.dto;

import java.math.BigDecimal;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MovimientoDTO {

    @NotNull(message = "Seleccione un producto")
    private Long idProducto;

    @NotBlank(message = "Seleccione el tipo de movimiento")
    private String tipo;

    @NotNull(message = "Ingrese la cantidad")
    @DecimalMin(value = "0.01",
                message = "La cantidad debe ser mayor que cero")
    @Digits(integer = 10, fraction = 2,
            message = "Ingrese una cantidad válida con máximo 2 decimales")
    private BigDecimal cantidad;

    @NotBlank(message = "Ingrese el motivo del movimiento")
    @Size(max = 255,
          message = "El motivo no debe superar 255 caracteres")
    private String motivo;
}