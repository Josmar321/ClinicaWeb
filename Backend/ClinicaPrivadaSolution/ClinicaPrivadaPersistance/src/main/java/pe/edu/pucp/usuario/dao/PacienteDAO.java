package pe.edu.pucp.usuario.dao;

import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.usuario.model.Paciente;

public interface PacienteDAO extends ICrud<Paciente>{
    Paciente obtenerPorId (String codigoPaciente);
    public Paciente obtenerPacienteXUser(int idUsuario);
}
