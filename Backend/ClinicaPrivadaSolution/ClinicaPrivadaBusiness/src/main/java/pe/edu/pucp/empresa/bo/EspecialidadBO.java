package pe.edu.pucp.empresa.bo;

import java.util.ArrayList;
import pe.edu.pucp.empresa.dao.EspecialidadDAO;
import pe.edu.pucp.empresa.model.Especialidad;
import pe.edu.pucp.empresa.mysql.EspecialidadMySQL;

public class EspecialidadBO {
    private final EspecialidadDAO daoEspecialidad;

    public EspecialidadBO() {
        daoEspecialidad = new EspecialidadMySQL(); 
    }

    public int insertar(Especialidad especialidad) {
        return daoEspecialidad.insertar(especialidad);
    }

    public int modificar(Especialidad especialidad) {
        return daoEspecialidad.modificar(especialidad);
    }
    
    public int eliminar(int  id) {
        return daoEspecialidad.eliminar(id);
    }
    
    public ArrayList<Especialidad> listarTodos() {
        return daoEspecialidad.listarTodos();
    }
    
    public ArrayList<Especialidad> listarPorIdLocal(int id){
        return daoEspecialidad.listarPorIdLocal(id);
    }
    
    public Especialidad obtenerPorId(int idEspecialidad) {
        return daoEspecialidad.obtenerPorId(idEspecialidad);
    }
}
