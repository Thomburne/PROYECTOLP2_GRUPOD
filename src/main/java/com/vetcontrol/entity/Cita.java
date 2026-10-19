
package com.vetcontrol.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.DynamicInsert;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(
    name = "tbl_cita",
    uniqueConstraints = {
        @UniqueConstraint(
            name = "uk_cita_mascota_fecha",
            columnNames = {"id_mascota", "fecha_hora"}
        )
    }
)
@DynamicInsert
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Cita {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cita")
    private Long idCita;

    // MASCOTA QUE RECIBIRA LA ATENCION
    @ManyToOne(
        fetch = FetchType.LAZY,
        optional = false
    )
    @JoinColumn(
        name = "id_mascota",
        nullable = false
    )
    private Mascota mascota;

    // SERVICIO VETERINARIO REGISTRADO EN MYSQL
    @ManyToOne(
        fetch = FetchType.LAZY,
        optional = false
    )
    @JoinColumn(
        name = "id_servicio",
        nullable = false
    )
    private Servicio servicioVeterinario;

    // FECHA Y HORA DE LA ATENCION
    @Column(
        name = "fecha_hora",
        nullable = false
    )
    private LocalDateTime fechaHora;

    // COLUMNA ANTERIOR CONSERVADA POR COMPATIBILIDAD
    @Column(
        name = "servicio",
        nullable = false,
        length = 40
    )
    private String servicio;

    // MOTIVO DE LA ATENCION
    @Column(
        name = "motivo",
        length = 255
    )
    private String motivo;

    // OBSERVACIONES
    @Column(
        name = "observaciones",
        length = 500
    )
    private String observaciones;

    // ESTADO DE LA CITA
    @Column(
        name = "estado",
        nullable = false,
        length = 20
    )
    private String estado = "PENDIENTE";

    // FECHA GENERADA AUTOMATICAMENTE POR MYSQL
    @Column(
        name = "fecha_registro",
        nullable = false,
        insertable = false,
        updatable = false
    )
    private LocalDateTime fechaRegistro;

    // FECHA DE CREACION ORIGINAL DE MYSQL
    @Column(
        name = "fecha_creacion",
        nullable = false,
        insertable = false,
        updatable = false
    )
    private LocalDateTime fechaCreacion;
}
