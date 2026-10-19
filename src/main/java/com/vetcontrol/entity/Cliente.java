
package com.vetcontrol.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.DynamicInsert;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@DynamicInsert
@Table(
    name = "tbl_cliente",
    uniqueConstraints = {
        @UniqueConstraint(
            name = "uq_cliente_documento",
            columnNames = {
                "tipo_documento",
                "nro_documento"
            }
        )
    }
)
public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cliente")
    private Long idCliente;

    @Column(
        name = "tipo_documento",
        nullable = false,
        columnDefinition =
            "ENUM('DNI','RUC','CE','PASAPORTE')"
    )
    private String tipoDocumento;

    @Column(
        name = "nro_documento",
        nullable = false,
        length = 20
    )
    private String nroDocumento;

    @Column(
        name = "nombres_razon_social",
        nullable = false,
        length = 150
    )
    private String nombresRazonSocial;

    @Column(
        name = "apellidos",
        length = 100
    )
    private String apellidos;

    @Column(
        name = "celular",
        nullable = false,
        length = 20
    )
    private String celular;

    @Column(
        name = "correo",
        length = 120
    )
    private String correo;

    @Column(
        name = "direccion",
        length = 200
    )
    private String direccion;

    @Column(
        name = "fecha_registro",
        nullable = false,
        insertable = false,
        updatable = false
    )
    private LocalDateTime fechaRegistro;

    @Column(
        name = "activo",
        nullable = false,
        columnDefinition = "TINYINT(1)"
    )
    private Boolean activo;
}
