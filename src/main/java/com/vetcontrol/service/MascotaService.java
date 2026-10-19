
package com.vetcontrol.service;

import java.util.List;
import java.util.Optional;

import com.vetcontrol.entity.Mascota;

public interface MascotaService {

    List<Mascota> listarMascotas();

    List<Mascota> listarActivas();

    List<Mascota> listarPorCliente(Long idCliente);

    Optional<Mascota> buscarPorId(Long id);

    List<Mascota> buscarPorNombre(String nombre);

    Mascota guardarMascota(Mascota mascota);
}
