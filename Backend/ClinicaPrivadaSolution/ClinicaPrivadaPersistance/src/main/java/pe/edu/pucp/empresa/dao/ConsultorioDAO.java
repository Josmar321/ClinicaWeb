package pe.edu.pucp.empresa.dao;

import java.util.ArrayList;
import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.empresa.model.Consultorio;

public interface ConsultorioDAO extends ICrud<Consultorio>{
    Consultorio obtenerPorId(int idConsultorio);
    ArrayList<Consultorio> listarPorIdLocal(int idLocal);
    ArrayList<Consultorio> listarPorIdLocalYMedico(int idLocal, String codigoMedico); //para citas médicas
}
