package pe.edu.pucp.empresa.dao;

import java.util.ArrayList;
import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.empresa.model.Especialidad;

public interface EspecialidadDAO extends ICrud<Especialidad>{
    ArrayList<Especialidad> listarPorIdLocal(int idLocal);
    Especialidad obtenerPorId(int idEspecialidad);
}

