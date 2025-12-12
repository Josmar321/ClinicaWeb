package pe.edu.pucp.cita.bo;

import pe.edu.pucp.cita.dao.CitaMedicaDAO;
import pe.edu.pucp.cita.model.CitaMedica;
import pe.edu.pucp.cita.mysql.CitaMedicaMySQL;

import java.util.Date;
import java.util.ArrayList;

public class CitaMedicaBO {
    private final CitaMedicaDAO daoCitaMedica;

    public CitaMedicaBO() {
        daoCitaMedica = new CitaMedicaMySQL();
    }

    public int insertar(CitaMedica citaMedica) {
        return daoCitaMedica.insertar(citaMedica);
    }
    
    public int modificar(CitaMedica citaMedica) {
        return daoCitaMedica.modificar(citaMedica);
    }
    
    public int eliminar(int idCitaMedica) {
        return daoCitaMedica.eliminar(idCitaMedica);
    }
    
    public ArrayList<CitaMedica> listarTodos() {
        return daoCitaMedica.listarTodos();
    }

    public int modificarCitaMedico(CitaMedica citaMedica) {
        return daoCitaMedica.modificarCitaMedico(citaMedica);
    }

    public int modificarCitaPaciente(CitaMedica citaMedica) {
        return daoCitaMedica.modificarCitaPaciente(citaMedica);  
    }

    public int cancelarCitaMedica(int idCitaMedica) {
        return daoCitaMedica.cancelarCitaMedica(idCitaMedica); 
    }

    public ArrayList<CitaMedica> obtenerCitasPorFecha(Date fechaInicio, Date fechaFin) {
        return daoCitaMedica.obtenerCitasPorFecha(fechaInicio, fechaFin);     
    }
    
    public ArrayList<CitaMedica> listarCitasPorPaciente(String codigoPaciente) {
        return daoCitaMedica.listarCitasPorPaciente(codigoPaciente);
    }

    public CitaMedica obtenerPorId(int idCitaMedica) {
        return daoCitaMedica.obtenerPorId(idCitaMedica);
    }

}
