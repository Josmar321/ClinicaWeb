package pe.edu.pucp.cita.dao;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.cita.model.Diagnostico;
import pe.edu.pucp.dao.ICrud;

public interface DiagnosticoDAO extends ICrud<Diagnostico>{
    Diagnostico obtenerPorId(int idCita);
    ArrayList<Diagnostico> obtenerDiagnosticosPorFecha(Date fechaInicio, Date fechaFin);
}
