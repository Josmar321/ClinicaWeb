package pe.edu.pucp.usuario.dao;

import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.usuario.model.Medico;
import java.util.ArrayList;

public interface MedicoDAO extends ICrud<Medico>{
    public Medico obtenerPorId(String codigoMedico);
    public Medico obtenerMedicoXUser(int id);
    public ArrayList<Medico> obtenerMedicosParaCitaMedica(int idLocal, int idEspecialidad, String dia);
}
