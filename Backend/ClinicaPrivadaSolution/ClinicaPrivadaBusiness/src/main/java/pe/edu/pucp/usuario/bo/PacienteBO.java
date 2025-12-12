package pe.edu.pucp.usuario.bo;

import pe.edu.pucp.usuario.dao.PacienteDAO;
import pe.edu.pucp.usuario.mysql.PacienteMySQL;
import pe.edu.pucp.usuario.model.Paciente;

import java.util.ArrayList;

public class PacienteBO {
    private PacienteDAO daoPaciente = new PacienteMySQL();

    public int insertar(Paciente paciente) {
        return daoPaciente.insertar(paciente);
    }

    public int modificar(Paciente paciente) {
        return daoPaciente.modificar(paciente);
    }

    public int eliminar(String codigoPaciente) {
        return daoPaciente.eliminar(codigoPaciente);
    }

    public ArrayList<Paciente> listarTodos() {
        return daoPaciente.listarTodos();
    }

    public Paciente obtenerPorId(String codigoPaciente) {
        return daoPaciente.obtenerPorId(codigoPaciente);
    }
    
    public Paciente obtenerPacienteXUser(int idUsuario) {
        return daoPaciente.obtenerPacienteXUser(idUsuario);
    }

}
