package pe.edu.pucp.cita.bo;

import java.util.ArrayList;
import pe.edu.pucp.cita.dao.TratamientoDAO;
import pe.edu.pucp.cita.model.Tratamiento;
import pe.edu.pucp.cita.mysql.TratamientoMySQL;

public class TratamientoBO {

    private final TratamientoDAO daoTratamiento;

    public TratamientoBO() {
        daoTratamiento = new TratamientoMySQL();
    }

    public int insertar(Tratamiento tratamiento) {
        return daoTratamiento.insertar(tratamiento);
    }
    
    public int modificar(Tratamiento tratamiento) {
        return daoTratamiento.modificar(tratamiento);
    }
    
    public int eliminar(int  id) {
        return daoTratamiento.eliminar(id);
    }
    
    public ArrayList<Tratamiento> listarTodos() {
        return daoTratamiento.listarTodos();
    }

    public Tratamiento obtenerPorId(int idTratamiento) {
        return daoTratamiento.obtenerPorId(idTratamiento);
    }
}
