
package com.vetcontrol.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.core.io.ClassPathResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

@Controller
@RequestMapping("/reportes/citas")
public class ReporteCitasPdfController {

    private final DataSource dataSource;

    public ReporteCitasPdfController(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @GetMapping("/pdf")
    public ResponseEntity<byte[]> generarPdf() {

        try (
            InputStream archivo = new ClassPathResource(
                "reportes/reporte_citas.jrxml"
            ).getInputStream();

            Connection conexion = dataSource.getConnection();

            ByteArrayOutputStream salida =
                new ByteArrayOutputStream()
        ) {

            // Compilar la plantilla de Jaspersoft Studio.
            JasperReport reporte =
                JasperCompileManager.compileReport(archivo);

            // Parámetros del reporte.
            Map<String, Object> parametros = new HashMap<>();

            // Obtener los registros directamente desde MySQL.
            JasperPrint documento = JasperFillManager.fillReport(
                reporte,
                parametros,
                conexion
            );

            // Convertir el reporte a PDF.
            JasperExportManager.exportReportToPdfStream(
                documento,
                salida
            );

            byte[] contenidoPdf = salida.toByteArray();

            HttpHeaders cabeceras = new HttpHeaders();

            cabeceras.setContentType(
                MediaType.APPLICATION_PDF
            );

            cabeceras.setContentDisposition(
                ContentDisposition.inline()
                    .filename("reporte_citas_vetcontrol.pdf")
                    .build()
            );

            return ResponseEntity.ok()
                .headers(cabeceras)
                .contentLength(contenidoPdf.length)
                .body(contenidoPdf);

        } catch (Exception e) {

            throw new IllegalStateException(
                "No se pudo generar el reporte de citas veterinarias",
                e
            );
        }
    }
}
