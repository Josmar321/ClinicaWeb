package pe.edu.pucp.empresa.bo;

import java.util.ArrayList;
import pe.edu.pucp.empresa.dao.ConsultorioDAO;
import pe.edu.pucp.empresa.model.Consultorio;
import pe.edu.pucp.empresa.mysql.ConsultorioMySQL;

public class ConsultorioBO {
    private final ConsultorioDAO daoConsultorio;

    public ConsultorioBO() {
        daoConsultorio = new ConsultorioMySQL(); 
    }

    public int insertar(Consultorio consultorio) {
        return daoConsultorio.insertar(consultorio);
    }

    public int modificar(Consultorio consultorio) {
        return daoConsultorio.modificar(consultorio);
    }
    
    public int eliminar(int  idConsultorio) {
        return daoConsultorio.eliminar(idConsultorio);
    }
    
    public ArrayList<Consultorio> listarTodos() {
        return daoConsultorio.listarTodos();
    }
    
    public Consultorio obtenerPorId(int idConsultorio) {
        return daoConsultorio.obtenerPorId(idConsultorio);
    }
    
    public ArrayList<Consultorio> listarPorIdLocal(int idLocal) {
        return daoConsultorio.listarPorIdLocal(idLocal);
    }

    public ArrayList<Consultorio> listarPorIdLocalYMedico(int idLocal, String codigoMedico) {
        return daoConsultorio.listarPorIdLocalYMedico(idLocal, codigoMedico);
    }

}
