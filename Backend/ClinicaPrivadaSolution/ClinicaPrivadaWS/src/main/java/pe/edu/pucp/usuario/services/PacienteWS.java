package pe.edu.pucp.usuario.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.usuario.bo.PacienteBO;
import pe.edu.pucp.usuario.model.Paciente;

@WebService(serviceName = "PacienteWS", targetNamespace = "http://services.pucp.edu.pe")
public class PacienteWS {

    private PacienteBO boPaciente;
    
    @WebMethod(operationName = "insertarPaciente")
    public int insertarPaciente(@WebParam(name = "paciente") Paciente paciente) {
        boPaciente = new PacienteBO();
        return boPaciente.insertar(paciente);
    }
    
    @WebMethod(operationName = "modificarPaciente")
    public int modificarPaciente(@WebParam(name = "paciente") Paciente paciente) {
        boPaciente = new PacienteBO();
        return boPaciente.modificar(paciente);
    }
    
    @WebMethod(operationName = "eliminarPaciente")
    public int eliminarPaciente(@WebParam(name = "idPaciente") String idPaciente) {
        boPaciente = new PacienteBO();
        return boPaciente.eliminar(idPaciente);
    }
    
    @WebMethod(operationName = "listarPaciente")
    public ArrayList<Paciente> listarPaciente(){
        boPaciente = new PacienteBO();
        return boPaciente.listarTodos();
    }
    
    @WebMethod(operationName = "obtenerPacientePorId")
    public Paciente obtenerPacientePorId(
            @WebParam(name = "idPaciente") String idPaciente){
        boPaciente = new PacienteBO();
        return boPaciente.obtenerPorId(idPaciente);
    }
    
    @WebMethod(operationName = "obtenerPacienteXUser")
    public Paciente obtenerPacienteXUser(
            @WebParam(name = "idUsuario") int idUsuario) {
        boPaciente = new PacienteBO();
        return boPaciente.obtenerPacienteXUser(idUsuario);
    }

}
