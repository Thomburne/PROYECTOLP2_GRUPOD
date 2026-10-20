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
public class ProductoDTO {

    private Long idProducto;

    @NotBlank(message = "Ingrese el código del producto")
    @Size(max = 40,
          message = "El código no debe superar 40 caracteres")
    private String codigo;

    @NotBlank(message = "Ingrese el nombre del producto")
    @Size(max = 120,
          message = "El nombre no debe superar 120 caracteres")
    private String nombre;

    @NotBlank(message = "Seleccione una categoría")
    private String categoria;

    @NotBlank(message = "Ingrese la unidad de medida")
    @Size(max = 30,
          message = "La unidad no debe superar 30 caracteres")
    private String unidadMedida;

    @NotNull(message = "Ingrese el stock actual")
    @DecimalMin(value = "0.00",
                message = "El stock no puede ser negativo")
    @Digits(integer = 10, fraction = 2,
            message = "Ingrese un stock válido con máximo 2 decimales")
    private BigDecimal stockActual;

    @NotNull(message = "Ingrese el stock mínimo")
    @DecimalMin(value = "0.00",
                message = "El stock mínimo no puede ser negativo")
    @Digits(integer = 10, fraction = 2,
            message = "Ingrese un stock mínimo válido")
    private BigDecimal stockMinimo;

    @NotNull(message = "Ingrese el precio de venta")
    @DecimalMin(value = "0.00",
                message = "El precio no puede ser negativo")
    @Digits(integer = 10, fraction = 2,
            message = "Ingrese un precio válido con máximo 2 decimales")
    private BigDecimal precioVenta;

    private Boolean activo = true;
}
