package pe.edu.pucp.cita.bo;

import pe.edu.pucp.cita.dao.HistorialClinicoDAO;
import pe.edu.pucp.cita.model.HistorialClinico;
import pe.edu.pucp.cita.mysql.HistorialClinicoMySQL;

public class HistorialClinicoBO {

    private final HistorialClinicoDAO daoHistorial;

    public HistorialClinicoBO() {
        daoHistorial = new HistorialClinicoMySQL();
    }

    public int insertar(HistorialClinico historialClinico) {
        return daoHistorial.insertar(historialClinico);
    }
    
    public int modificar(HistorialClinico historialClinico) {
        return daoHistorial.modificar(historialClinico);
    }
    
    public int eliminar(int  id) {
        return daoHistorial.eliminar(id);
    }

    public HistorialClinico obtenerHistorialConCitas(String codigoPaciente) {
        return daoHistorial.obtenerHistorialConCitas(codigoPaciente);
    }
}
