package pe.edu.pucp.empresa.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.empresa.bo.ConsultorioBO;
import pe.edu.pucp.empresa.model.Consultorio;

@WebService(serviceName = "ConsultorioWS", targetNamespace = "http://services.pucp.edu.pe")
public class ConsultorioWS {

    private ConsultorioBO boConsultorio;
    
    @WebMethod(operationName = "insertarConsultorio")
    public int insertarConsultorio(@WebParam(name = "consultorio") Consultorio consultorio) {
        boConsultorio = new ConsultorioBO();
        return boConsultorio.insertar(consultorio);
    }
    
    @WebMethod(operationName = "modificarConsultorio")
    public int modificarConsultorio(@WebParam(name = "consultorio") Consultorio consultorio) {
        boConsultorio = new ConsultorioBO();
        return boConsultorio.modificar(consultorio);
    }
    
    @WebMethod(operationName = "eliminarConsultorio")
    public int eliminarConsultorio(@WebParam(name = "idConsultorio") int idConsultorio) {
        boConsultorio = new ConsultorioBO();
        return boConsultorio.eliminar(idConsultorio);
    }
    
    @WebMethod(operationName = "listarConsultorios")
    public ArrayList<Consultorio> listarConsultorios(){
        boConsultorio = new ConsultorioBO();
        return boConsultorio.listarTodos();
    }
    
    @WebMethod(operationName = "obtenerConsultorioPorId")
    public Consultorio obtenerConsultorioPorId(
            @WebParam(name = "idConsultorio") int idConsultorio){
        boConsultorio = new ConsultorioBO();
        return boConsultorio.obtenerPorId(idConsultorio);
    }
    
    @WebMethod(operationName = "listarConsultoriosPorIdLocal")
    public ArrayList<Consultorio> listarConsultoriosPorIdLocal(
            @WebParam(name = "idLocal") int idLocal){
        boConsultorio = new ConsultorioBO();
        return boConsultorio.listarPorIdLocal(idLocal);
    }

    @WebMethod(operationName = "listarConsultoriosPorIdLocalYMedico")
    public ArrayList<Consultorio> listarConsultoriosPorIdLocalYMedico(
            @WebParam(name = "idLocal") int idLocal,
            @WebParam(name = "codigoMedico") String codigoMedico) {
        boConsultorio = new ConsultorioBO();
        return boConsultorio.listarPorIdLocalYMedico(idLocal, codigoMedico);
    }

}
