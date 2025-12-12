package pe.edu.pucp.cita.dao;

import java.util.Date;
import java.util.ArrayList;
import pe.edu.pucp.cita.model.CitaMedica;
import pe.edu.pucp.dao.ICrud;

public interface CitaMedicaDAO extends ICrud<CitaMedica>{
    int modificarCitaMedico(CitaMedica citaMedica);
    int modificarCitaPaciente(CitaMedica citaMedica);
    int cancelarCitaMedica(int idCitaMedica);
    ArrayList<CitaMedica> obtenerCitasPorFecha(Date fechaInicio, Date fechaFin);
    ArrayList<CitaMedica> listarCitasPorPaciente(String codigoPaciente);
    CitaMedica obtenerPorId(int idCitaMedica);
}
