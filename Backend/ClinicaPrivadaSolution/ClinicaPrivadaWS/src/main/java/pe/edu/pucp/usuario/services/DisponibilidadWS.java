/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.usuario.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.usuario.bo.DisponibilidadBO;
import pe.edu.pucp.usuario.model.Dia;
import pe.edu.pucp.usuario.model.Disponibilidad;

@WebService(serviceName = "DisponibilidadWS", targetNamespace = "http://services.pucp.edu.pe")
public class DisponibilidadWS {

    private DisponibilidadBO boDisponibilidad;
    
    @WebMethod(operationName = "insertarDisponibilidad")
    public int  insertarDisponibilidad(@WebParam(name = "disponibilidad") Disponibilidad disponibilidad, String dia) {
        boDisponibilidad = new DisponibilidadBO();
        Dia dianew = Dia.valueOf(dia);
        disponibilidad.setDia(dianew);
        return boDisponibilidad.insertar(disponibilidad);
    }
    
    @WebMethod(operationName = "obtenerDisponibilidadXMedico")
    public ArrayList<Disponibilidad>  obtenerDisponibilidadXMedico(@WebParam(name = "disponibilidad") String codigoMedico) {
        boDisponibilidad = new DisponibilidadBO();
        return boDisponibilidad.obtenerDisponibilidadXMedico(codigoMedico);
    }
    
        @WebMethod(operationName = "obtenerDisponibilidadPorId")
    public Disponibilidad  obtenerDisponibilidadPorId(@WebParam(name = "disponibilidad") int id) {
        boDisponibilidad = new DisponibilidadBO();
        return boDisponibilidad.obtenerPorId(id);
    }
    
    @WebMethod(operationName = "modificarDisponibilidad")
    public int  modificarDisponibilidad(@WebParam(name = "disponibilidad") Disponibilidad disponibilidad) {
        boDisponibilidad = new DisponibilidadBO();
        return boDisponibilidad.modificar(disponibilidad);
    }
}
