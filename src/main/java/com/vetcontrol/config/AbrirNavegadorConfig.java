
package com.vetcontrol.config;

import java.awt.Desktop;
import java.net.URI;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class AbrirNavegadorConfig {

    @Value("${vetcontrol.browser.auto-open:false}")
    private boolean abrirAutomaticamente;

    @Value("${server.port:8080}")
    private int puerto;

    @EventListener(ApplicationReadyEvent.class)
    public void abrirLogin() {

        if (!abrirAutomaticamente) {
            return;
        }

        String url = "http://localhost:" + puerto + "/login";

        try {

            String sistemaOperativo =
                System.getProperty("os.name", "")
                      .toLowerCase(Locale.ROOT);

            // WINDOWS: USAR EL NAVEGADOR PREDETERMINADO
            if (sistemaOperativo.contains("win")) {

                new ProcessBuilder(
                    "cmd", "/c", "start", "", url
                ).start();

                System.out.println(
                    "VetControl Peru - Apertura solicitada: " + url
                );

                return;
            }

            // OTROS SISTEMAS CON ESCRITORIO
            if (Desktop.isDesktopSupported()
                    && Desktop.getDesktop().isSupported(
                            Desktop.Action.BROWSE)) {

                Desktop.getDesktop().browse(new URI(url));

                System.out.println(
                    "VetControl Peru - Apertura solicitada: " + url
                );

                return;
            }

            System.out.println(
                "No hay un navegador de escritorio disponible."
            );

            System.out.println(
                "Abre manualmente: " + url
            );

        } catch (Exception e) {

            System.err.println(
                "No se pudo iniciar la apertura del navegador: "
                + e.getMessage()
            );

            System.out.println(
                "URL del Login: " + url
            );
        }
    }
}
