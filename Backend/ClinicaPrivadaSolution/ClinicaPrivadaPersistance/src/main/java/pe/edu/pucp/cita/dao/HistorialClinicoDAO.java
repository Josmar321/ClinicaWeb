package pe.edu.pucp.cita.dao;

import pe.edu.pucp.cita.model.HistorialClinico;
import pe.edu.pucp.dao.ICrud;

public interface HistorialClinicoDAO extends ICrud<HistorialClinico>{
    HistorialClinico obtenerHistorialConCitas(String codigoPaciente);
}
