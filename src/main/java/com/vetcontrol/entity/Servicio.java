
package com.vetcontrol.entity;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "tbl_servicio")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Servicio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_servicio")
    private Long idServicio;

    @Column(
        name = "nombre",
        nullable = false,
        length = 100
    )
    private String nombre;

    @Column(
        name = "categoria",
        nullable = false,
        columnDefinition = "ENUM"
    )
    private String categoria;

    @Column(
        name = "descripcion",
        length = 500
    )
    private String descripcion;

    @Column(
        name = "precio_referencial",
        nullable = false,
        precision = 10,
        scale = 2
    )
    private BigDecimal precioReferencial;

    @Column(name = "duracion_minutos")
    private Integer duracionMinutos;

    @Column(name = "activo", nullable = false)
    private Boolean activo;
}
