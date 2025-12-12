package pe.edu.pucp.cita.bo;

import pe.edu.pucp.cita.dao.DiagnosticoDAO;
import pe.edu.pucp.cita.model.Diagnostico;
import pe.edu.pucp.cita.mysql.DiagnosticoMySQL;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

public class DiagnosticoBO {

    private final DiagnosticoDAO daoDiagnostico;

    public DiagnosticoBO() {
        daoDiagnostico = new DiagnosticoMySQL();
    }

    public int insertar(Diagnostico diagnostico) {
        return daoDiagnostico.insertar(diagnostico);
    }

    public int modificar(Diagnostico diagnostico) {
        return daoDiagnostico.modificar(diagnostico);
    }
    
    public int eliminar(int  id) {
        return daoDiagnostico.eliminar(id);
    }
    
    public ArrayList<Diagnostico> listarTodos() {
        return daoDiagnostico.listarTodos();
    }

    public Diagnostico obtenerPorId(int idDiagnostico) {
        return daoDiagnostico.obtenerPorId(idDiagnostico);
    }

    public ArrayList<Diagnostico> obtenerDiagnosticosPorFecha(Date fechaInicio, Date fechaFin) {
        return daoDiagnostico.obtenerDiagnosticosPorFecha(fechaInicio, fechaFin);
    }
}
