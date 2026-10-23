
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
@RequestMapping("/reportes/inventario")
public class ReporteInventarioPdfController {

    private final DataSource dataSource;

    public ReporteInventarioPdfController(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @GetMapping("/pdf")
    public ResponseEntity<byte[]> generarPdf() {

        try (
            InputStream archivo = new ClassPathResource(
                "reportes/reporte_inventario.jrxml"
            ).getInputStream();

            Connection conexion = dataSource.getConnection();

            ByteArrayOutputStream salida =
                new ByteArrayOutputStream()
        ) {

            // Compilar el diseño generado en Jaspersoft Studio.
            JasperReport reporte =
                JasperCompileManager.compileReport(archivo);

            // Parámetros del reporte.
            Map<String, Object> parametros = new HashMap<>();

            // Consultar los productos desde MySQL.
            JasperPrint documento = JasperFillManager.fillReport(
                reporte,
                parametros,
                conexion
            );

            // Generar el archivo PDF.
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
                    .filename("reporte_inventario_vetcontrol.pdf")
                    .build()
            );

            return ResponseEntity.ok()
                .headers(cabeceras)
                .contentLength(contenidoPdf.length)
                .body(contenidoPdf);

        } catch (Exception e) {

            throw new IllegalStateException(
                "No se pudo generar el reporte PDF de inventario",
                e
            );
        }
    }
}
