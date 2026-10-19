
package com.vetcontrol.entity;

import java.time.LocalDateTime;

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
@Table(name = "usuarios")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Long idUsuario;

    @Column(name = "username", nullable = false,
            unique = true, length = 50)
    private String username;

    @Column(name = "password", nullable = false,
            length = 100)
    private String password;

    @Column(name = "nombres", nullable = false,
            length = 120)
    private String nombres;

    @Column(name = "correo", unique = true,
            length = 150)
    private String correo;

    @Column(name = "rol", nullable = false,
            length = 20)
    private String rol = "EMPLEADO";

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;

    @Column(name = "fecha_registro",
            insertable = false, updatable = false)
    private LocalDateTime fechaRegistro;
}
