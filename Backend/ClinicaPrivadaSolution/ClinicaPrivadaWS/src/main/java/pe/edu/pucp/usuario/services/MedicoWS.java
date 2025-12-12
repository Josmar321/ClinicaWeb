package pe.edu.pucp.usuario.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.usuario.bo.MedicoBO;
import pe.edu.pucp.usuario.model.Medico;

@WebService(serviceName = "MedicoWS", targetNamespace = "http://services.pucp.edu.pe")
public class MedicoWS {

    private MedicoBO boMedico;
    
    @WebMethod(operationName = "insertarMedico")
    public int insertarMedico(@WebParam(name = "medico") Medico medico) {
        boMedico = new MedicoBO();
        return boMedico.insertar(medico);
    }
    
    @WebMethod(operationName = "modificarMedico")
    public int modificarMedico(@WebParam(name = "medico") Medico medico) {
        boMedico = new MedicoBO();
        return boMedico.modificar(medico);
    }
    
    @WebMethod(operationName = "eliminarMedico")
    public int eliminarMedico(@WebParam(name = "idMedico") String idMedico) {
        boMedico = new MedicoBO();
        return boMedico.eliminar(idMedico);
    }
    
    @WebMethod(operationName = "listarMedico")
    public ArrayList<Medico> listarMedico(){
        boMedico = new MedicoBO();
        return boMedico.listarTodos();
    }
    
    @WebMethod(operationName = "obtenerMedicoPorId")
    public Medico obtenerMedicoPorId(
            @WebParam(name = "idMedico") String idMedico){
        boMedico = new MedicoBO();
        return boMedico.obtenerPorId(idMedico);
    }
        
    @WebMethod(operationName = "obtenerMedicoXUser")
    public Medico obtenerMedicoXUser(
            @WebParam(name = "idMedico") int idUser){
        boMedico = new MedicoBO();
        return boMedico.obtenerMedicoXUser(idUser);
    }
    
    @WebMethod(operationName = "obtenerMedicosParaCitaMedica")
    public ArrayList<Medico> obtenerMedicosParaCitaMedica(
        @WebParam(name = "idLocal") int idLocal,
        @WebParam(name = "idEspecialidad") int idEspecialidad,
        @WebParam(name = "dia") String dia
    ) {
        boMedico = new MedicoBO();
        return boMedico.obtenerMedicosParaCitaMedica(idLocal, idEspecialidad, dia);
    }

}
