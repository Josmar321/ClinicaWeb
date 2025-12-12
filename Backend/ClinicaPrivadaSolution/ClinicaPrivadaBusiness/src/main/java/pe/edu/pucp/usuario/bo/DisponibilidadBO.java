/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.usuario.bo;

import java.util.ArrayList;
import pe.edu.pucp.usuario.dao.DisponibilidadDAO;
import pe.edu.pucp.usuario.model.Disponibilidad;
import pe.edu.pucp.usuario.mysql.DisponibilidadMySQL;

public class DisponibilidadBO {
    
    private final DisponibilidadDAO daoDisponibilidad;
    
    public DisponibilidadBO(){
        daoDisponibilidad = new DisponibilidadMySQL();
    }
    
    public int insertar(Disponibilidad disponibilidad) {
        return daoDisponibilidad.insertar(disponibilidad);
    }
    
    public ArrayList<Disponibilidad> obtenerDisponibilidadXMedico(String codigoMedico) {
        return daoDisponibilidad.obtenerDisponibilidadXMedico(codigoMedico);
    }
    
    public Disponibilidad obtenerPorId(int id){
        return daoDisponibilidad.obtenerPorId(id);
    }
    
    public int modificar(Disponibilidad disponibilidad){
        return daoDisponibilidad.modificar(disponibilidad);
    }
}
