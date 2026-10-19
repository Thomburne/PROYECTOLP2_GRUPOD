
package com.vetcontrol.service.impl;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Locale;
import java.util.Optional;
import java.util.Set;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vetcontrol.dto.CitaDTO;
import com.vetcontrol.entity.Cita;
import com.vetcontrol.entity.Mascota;
import com.vetcontrol.entity.Servicio;
import com.vetcontrol.repository.CitaRepository;
import com.vetcontrol.repository.ServicioRepository;
import com.vetcontrol.service.CitaService;
import com.vetcontrol.service.MascotaService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CitaServiceImpl implements CitaService {

    private final CitaRepository citaRepository;
    private final MascotaService mascotaService;
    private final ServicioRepository servicioRepository;

    private static final Set<String> ESTADOS = Set.of(
        "PENDIENTE",
        "CONFIRMADA",
        "ATENDIDA",
        "CANCELADA"
    );

    // LISTADO GENERAL
    @Override
    @Transactional(readOnly = true)
    public List<Cita> listarCitas() {
        return citaRepository.findAllByOrderByFechaHoraDesc();
    }

    // HISTORIAL DE UNA MASCOTA
    @Override
    @Transactional(readOnly = true)
    public List<Cita> listarPorMascota(Long idMascota) {
        return citaRepository
            .findByMascotaIdMascotaOrderByFechaHoraDesc(
                idMascota
            );
    }

    // BUSCAR POR ID
    @Override
    @Transactional(readOnly = true)
    public Optional<Cita> buscarPorId(Long idCita) {
        return citaRepository.findById(idCita);
    }

    // FILTRAR POR ESTADO
    @Override
    @Transactional(readOnly = true)
    public List<Cita> listarPorEstado(String estado) {

        String valor = normalizar(estado);
        validarEstado(valor);

        return citaRepository
            .findByEstadoOrderByFechaHoraAsc(valor);
    }

    // FILTRAR POR FECHAS
    @Override
    @Transactional(readOnly = true)
    public List<Cita> listarPorFechas(
            LocalDateTime inicio,
            LocalDateTime fin) {

        if (inicio == null || fin == null) {
            throw new IllegalArgumentException(
                "Ingrese ambas fechas."
            );
        }

        if (fin.isBefore(inicio)) {
            throw new IllegalArgumentException(
                "La fecha final no puede ser anterior."
            );
        }

        return citaRepository
            .findByFechaHoraBetweenOrderByFechaHoraAsc(
                inicio, fin
            );
    }

    // REGISTRAR CITA
    @Override
    @Transactional
    public Cita registrarCita(CitaDTO dto) {

        validarDatos(dto);

        Mascota mascota =
            obtenerMascota(dto.getMascotaId());

        validarMascotaActiva(mascota);

        Servicio servicio =
            obtenerServicioActivo(dto.getServicioId());

        LocalDateTime fecha =
            normalizarFecha(dto.getFechaHora());

        validarFechaFutura(fecha);

        if (!horarioDisponible(
                mascota.getIdMascota(), fecha, null)) {

            throw new IllegalArgumentException(
                "La mascota ya tiene una cita "
                + "a la misma fecha y hora."
            );
        }

        Cita cita = new Cita();

        cita.setMascota(mascota);
        cita.setServicioVeterinario(servicio);
        cita.setFechaHora(fecha);

        // COLUMNA VARCHAR(40) DE COMPATIBILIDAD
        cita.setServicio(
            normalizar(servicio.getCategoria())
        );

        cita.setMotivo(limpiar(dto.getMotivo()));
        cita.setObservaciones(
            limpiar(dto.getObservaciones())
        );
        cita.setEstado(normalizar(dto.getEstado()));

        return citaRepository.saveAndFlush(cita);
    }

    // ACTUALIZAR CITA
    @Override
    @Transactional
    public Cita actualizarCita(Long idCita, CitaDTO dto) {

        if (idCita == null) {
            throw new IllegalArgumentException(
                "Debe indicar la cita."
            );
        }

        validarDatos(dto);

        Cita cita = citaRepository.findById(idCita)
            .orElseThrow(() ->
                new IllegalArgumentException(
                    "La cita no existe."
                )
            );

        Mascota mascota =
            obtenerMascota(dto.getMascotaId());

        validarMascotaActiva(mascota);

        Servicio servicio =
            obtenerServicioActivo(dto.getServicioId());

        LocalDateTime fecha =
            normalizarFecha(dto.getFechaHora());

        boolean cambioHorario =
            !cita.getFechaHora().equals(fecha)
            || !cita.getMascota().getIdMascota()
                .equals(mascota.getIdMascota());

        if (cambioHorario) {

            validarFechaFutura(fecha);

            if (!horarioDisponible(
                    mascota.getIdMascota(),
                    fecha,
                    idCita)) {

                throw new IllegalArgumentException(
                    "Ya existe otra cita para esta mascota "
                    + "en esa fecha y hora."
                );
            }
        }

        cita.setMascota(mascota);
        cita.setServicioVeterinario(servicio);
        cita.setFechaHora(fecha);

        cita.setServicio(
            normalizar(servicio.getCategoria())
        );

        cita.setMotivo(limpiar(dto.getMotivo()));
        cita.setObservaciones(
            limpiar(dto.getObservaciones())
        );
        cita.setEstado(normalizar(dto.getEstado()));

        return citaRepository.saveAndFlush(cita);
    }

    // CAMBIAR ESTADO
    @Override
    @Transactional
    public Cita cambiarEstado(
            Long idCita,
            String nuevoEstado) {

        String estado = normalizar(nuevoEstado);
        validarEstado(estado);

        Cita cita = citaRepository.findById(idCita)
            .orElseThrow(() ->
                new IllegalArgumentException(
                    "La cita no existe."
                )
            );

        cita.setEstado(estado);

        return citaRepository.saveAndFlush(cita);
    }

    // VALIDAR DISPONIBILIDAD
    @Override
    @Transactional(readOnly = true)
    public boolean horarioDisponible(
            Long idMascota,
            LocalDateTime fechaHora,
            Long idCitaActual) {

        if (idMascota == null || fechaHora == null) {
            return false;
        }

        LocalDateTime fecha =
            normalizarFecha(fechaHora);

        if (idCitaActual == null) {
            return !citaRepository
                .existsByMascotaIdMascotaAndFechaHora(
                    idMascota,
                    fecha
                );
        }

        return !citaRepository
            .existsByMascotaIdMascotaAndFechaHoraAndIdCitaNot(
                idMascota,
                fecha,
                idCitaActual
            );
    }

    // COMPROBAR CAMPOS OBLIGATORIOS
    private void validarDatos(CitaDTO dto) {

        if (dto == null) {
            throw new IllegalArgumentException(
                "No se recibieron datos de la cita."
            );
        }

        if (dto.getMascotaId() == null) {
            throw new IllegalArgumentException(
                "Seleccione una mascota."
            );
        }

        if (dto.getServicioId() == null) {
            throw new IllegalArgumentException(
                "Seleccione un servicio veterinario."
            );
        }

        if (dto.getFechaHora() == null) {
            throw new IllegalArgumentException(
                "Seleccione fecha y hora."
            );
        }

        String motivo = limpiar(dto.getMotivo());

        if (motivo.isBlank() || motivo.length() > 255) {
            throw new IllegalArgumentException(
                "Ingrese un motivo válido "
                + "de hasta 255 caracteres."
            );
        }

        if (limpiar(dto.getObservaciones()).length() > 500) {
            throw new IllegalArgumentException(
                "Las observaciones permiten "
                + "hasta 500 caracteres."
            );
        }

        validarEstado(normalizar(dto.getEstado()));
    }

    // CONSULTAR MASCOTA
    private Mascota obtenerMascota(Long idMascota) {

        return mascotaService.buscarPorId(idMascota)
            .orElseThrow(() ->
                new IllegalArgumentException(
                    "La mascota seleccionada no existe."
                )
            );
    }

    // CONSULTAR SERVICIO REAL DE MYSQL
    private Servicio obtenerServicioActivo(Long idServicio) {

        Servicio servicio = servicioRepository
            .findById(idServicio)
            .orElseThrow(() ->
                new IllegalArgumentException(
                    "El servicio seleccionado no existe."
                )
            );

        if (!Boolean.TRUE.equals(servicio.getActivo())) {
            throw new IllegalArgumentException(
                "El servicio seleccionado está inactivo."
            );
        }

        if (servicio.getCategoria() == null
                || servicio.getCategoria().isBlank()) {
            throw new IllegalArgumentException(
                "El servicio no tiene categoría válida."
            );
        }

        if (normalizar(servicio.getCategoria()).length() > 40) {
            throw new IllegalArgumentException(
                "La categoría del servicio supera "
                + "los 40 caracteres."
            );
        }

        return servicio;
    }

    private void validarMascotaActiva(Mascota mascota) {

        if (!Boolean.TRUE.equals(mascota.getActivo())) {
            throw new IllegalArgumentException(
                "La mascota seleccionada está inactiva."
            );
        }
    }

    private void validarEstado(String estado) {

        if (!ESTADOS.contains(estado)) {
            throw new IllegalArgumentException(
                "Seleccione un estado válido."
            );
        }
    }

    private void validarFechaFutura(LocalDateTime fecha) {

        if (!fecha.isAfter(LocalDateTime.now())) {
            throw new IllegalArgumentException(
                "Seleccione una fecha y hora futuras."
            );
        }
    }

    private LocalDateTime normalizarFecha(
            LocalDateTime fecha) {

        return fecha.truncatedTo(ChronoUnit.MINUTES);
    }

    private String limpiar(String valor) {
        return valor == null ? "" : valor.trim();
    }

    private String normalizar(String valor) {
        return limpiar(valor).toUpperCase(Locale.ROOT);
    }
}
