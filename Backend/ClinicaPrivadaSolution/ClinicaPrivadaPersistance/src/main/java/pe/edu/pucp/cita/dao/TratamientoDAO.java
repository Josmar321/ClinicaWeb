package pe.edu.pucp.cita.dao;

import pe.edu.pucp.cita.model.Tratamiento;
import pe.edu.pucp.dao.ICrud;

public interface TratamientoDAO extends ICrud<Tratamiento>{
    Tratamiento obtenerPorId(int idCita);
}
