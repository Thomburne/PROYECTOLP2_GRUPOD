
package com.vetcontrol.dto;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
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
public class ClienteDTO {

    private Long idCliente;

    @NotBlank(message = "Seleccione el tipo de documento")
    @Pattern(
        regexp = "DNI|RUC|CE|PASAPORTE",
        message = "El tipo de documento no es válido"
    )
    private String tipoDocumento;

    @NotBlank(message = "Ingrese el número de documento")
    @Size(
        max = 20,
        message = "Máximo 20 caracteres"
    )
    private String nroDocumento;

    @NotBlank(message = "Ingrese el nombre o razón social")
    @Size(
        max = 150,
        message = "Máximo 150 caracteres"
    )
    private String nombresRazonSocial;

    @Size(
        max = 100,
        message = "Máximo 100 caracteres"
    )
    private String apellidos;

    @Size(
        max = 20,
        message = "Máximo 20 caracteres"
    )
    private String celular;

    @Email(message = "Ingrese un correo válido")
    @Size(
        max = 120,
        message = "Máximo 120 caracteres"
    )
    private String correo;

    @Size(
        max = 200,
        message = "Máximo 200 caracteres"
    )
    private String direccion;

    // VALIDACION DE DNI Y RUC
    @AssertTrue(
        message = "El DNI debe tener 8 dígitos "
                + "y el RUC debe tener 11 dígitos"
    )
    public boolean isDocumentoValido() {

        if (tipoDocumento == null ||
            nroDocumento == null) {
            return true;
        }

        String documento = nroDocumento.trim();

        if (tipoDocumento.equals("DNI")) {
            return documento.matches("\\d{8}");
        }

        if (tipoDocumento.equals("RUC")) {
            return documento.matches("\\d{11}");
        }

        return true;
    }
}
