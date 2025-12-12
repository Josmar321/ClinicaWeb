package pe.edu.pucp.usuario.bo;

import pe.edu.pucp.usuario.dao.MedicoDAO;
import pe.edu.pucp.usuario.mysql.MedicoMySQL;
import pe.edu.pucp.usuario.model.Medico;

import java.util.ArrayList;

public class MedicoBO {
    private MedicoDAO daoMedico = new MedicoMySQL();

    public int insertar(Medico medico) {
        return daoMedico.insertar(medico);
    }

    public int modificar(Medico medico) {
        return daoMedico.modificar(medico);
    }

    public int eliminar(String codigoMedico) {
        return daoMedico.eliminar(codigoMedico);
    }

    public ArrayList<Medico> listarTodos() {
        return daoMedico.listarTodos();
    }

    public Medico obtenerPorId(String codigoMedico) {
        return daoMedico.obtenerPorId(codigoMedico);
    }
    public Medico obtenerMedicoXUser(int id) {
        return daoMedico.obtenerMedicoXUser(id);
    }
    public ArrayList<Medico> obtenerMedicosParaCitaMedica(int idLocal, int idEspecialidad, String dia) {
        return daoMedico.obtenerMedicosParaCitaMedica(idLocal, idEspecialidad, dia);
    }
}
