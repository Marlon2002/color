/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.logging.Level;
import java.util.logging.Logger;
import jflex.exceptions.SilentExit;

/**
 *
 * @author david
 */
public class EjecutarJflex {
    public static void main(String omega[]) {
        String rutaA = System.getProperty("user.dir") + "/src/modelo/Analizador.flex",
                rutaC = System.getProperty("user.dir") + "/src/modelo/AnalizadorColor.flex";
        try {
            jflex.Main.generate(new String[]{rutaA, rutaC});
        } catch (SilentExit ex) {
            System.out.println("Error al compilar/generar el archivo flex: " + ex);
        }
    }
}
