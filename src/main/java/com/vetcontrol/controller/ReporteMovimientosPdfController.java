package com.vetcontrol.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URI;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.core.io.ClassPathResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vetcontrol.service.ProductoService;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

@Controller
@RequestMapping("/reportes/movimientos")
public class ReporteMovimientosPdfController {

    private static final List<String> TIPOS =
            List.of("ENTRADA", "SALIDA", "AJUSTE");

    private final DataSource dataSource;
    private final ProductoService productoService;

    public ReporteMovimientosPdfController(
            DataSource dataSource,
            ProductoService productoService) {

        this.dataSource = dataSource;
        this.productoService = productoService;
    }

    // PANTALLA DE FILTROS
   

    @GetMapping({"", "/"})
    public String pantalla(
            @RequestParam(name = "error", required = false)
            String error,
            Model model) {

        model.addAttribute("productos", productoService.listarTodos());
        model.addAttribute("tipos", TIPOS);

        if (error != null) {
            model.addAttribute(
                    "mensajeError",
                    "Revise los filtros: el rango de fechas no es válido.");
        }

        return "inventario/reporte";
    }

    // GENERAR PDF CON FILTROS

    @GetMapping("/pdf")
    public ResponseEntity<byte[]> generarPdf(
            @RequestParam(name = "idProducto", defaultValue = "")
            String idProducto,
            @RequestParam(name = "tipo", defaultValue = "")
            String tipo,
            @RequestParam(name = "desde", defaultValue = "")
            String desde,
            @RequestParam(name = "hasta", defaultValue = "")
            String hasta) {

        String id = idProducto.trim();
        String tipoMov = tipo.trim();

        // Validar fechas

        LocalDate fechaDesde = null;
        LocalDate fechaHasta = null;

        try {
            if (!desde.isBlank()) {
                fechaDesde = LocalDate.parse(desde.trim());
            }
            if (!hasta.isBlank()) {
                fechaHasta = LocalDate.parse(hasta.trim());
            }
        } catch (DateTimeParseException ex) {
            return volverConError();
        }

        // Validar el resto de filtros

        boolean idInvalido = !id.isBlank()
                && !id.matches("\\d{1,18}");

        boolean tipoInvalido = !tipoMov.isBlank()
                && !TIPOS.contains(tipoMov);

        boolean rangoInvalido = fechaDesde != null
                && fechaHasta != null
                && fechaDesde.isAfter(fechaHasta);

        if (idInvalido || tipoInvalido || rangoInvalido) {
            return volverConError();
        }

        // Texto que se imprime en el PDF con los filtros usados

        String textoProducto = "Todos";

        if (!id.isBlank()) {
            textoProducto = productoService
                    .buscarPorId(Long.valueOf(id))
                    .map(p -> p.getCodigo() + " - " + p.getNombre())
                    .orElse("Código interno " + id);
        }

        DateTimeFormatter formato =
                DateTimeFormatter.ofPattern("dd/MM/yyyy");

        String textoFiltros = "Filtros aplicados:  Producto: "
                + textoProducto
                + "   |   Tipo: "
                + (tipoMov.isBlank() ? "Todos" : tipoMov)
                + "   |   Desde: "
                + (fechaDesde == null ? "-" : fechaDesde.format(formato))
                + "   |   Hasta: "
                + (fechaHasta == null ? "-" : fechaHasta.format(formato));

        try (
            InputStream archivo = new ClassPathResource(
                "reportes/reporte_movimientos.jrxml"
            ).getInputStream();

            Connection conexion = dataSource.getConnection();

            ByteArrayOutputStream salida =
                new ByteArrayOutputStream()
        ) {

            JasperReport reporte =
                JasperCompileManager.compileReport(archivo);

            // Parametros: cadena vacia = sin filtro
            Map<String, Object> parametros = new HashMap<>();

            parametros.put("P_ID_PRODUCTO", id);
            parametros.put("P_TIPO", tipoMov);
            parametros.put("P_DESDE",
                    fechaDesde == null ? "" : fechaDesde.toString());
            parametros.put("P_HASTA",
                    fechaHasta == null ? "" : fechaHasta.toString());
            parametros.put("P_FILTROS", textoFiltros);

            JasperPrint documento = JasperFillManager.fillReport(
                reporte,
                parametros,
                conexion
            );

            JasperExportManager.exportReportToPdfStream(
                documento,
                salida
            );

            byte[] contenidoPdf = salida.toByteArray();

            HttpHeaders cabeceras = new HttpHeaders();

            cabeceras.setContentType(MediaType.APPLICATION_PDF);

            cabeceras.setContentDisposition(
                ContentDisposition.inline()
                    .filename("reporte_movimientos_vetcontrol.pdf")
                    .build()
            );

            return ResponseEntity.ok()
                .headers(cabeceras)
                .contentLength(contenidoPdf.length)
                .body(contenidoPdf);

        } catch (Exception e) {

            throw new IllegalStateException(
                "No se pudo generar el reporte PDF de movimientos",
                e
            );
        }
    }

    // Vuelve a la pantalla de filtros indicando el error
    private ResponseEntity<byte[]> volverConError() {

        return ResponseEntity.status(HttpStatus.FOUND)
                .location(URI.create("/reportes/movimientos?error=filtros"))
                .build();
    }
}