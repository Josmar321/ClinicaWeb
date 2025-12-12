package pe.edu.pucp.empresa.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.empresa.bo.LocalBO;
import pe.edu.pucp.empresa.model.Local;

@WebService(serviceName = "LocalWS", targetNamespace = "http://services.pucp.edu.pe")
public class LocalWS {

    private LocalBO boLocal;
    
    @WebMethod(operationName = "insertarLocal")
    public int insertarLocal(@WebParam(name = "local") Local local) {
        boLocal = new LocalBO();
        return boLocal.insertar(local);
    }
    
    @WebMethod(operationName = "modificarLocal")
    public int modificarLocal(@WebParam(name = "local") Local local) {
        boLocal = new LocalBO();
        return boLocal.modificar(local);
    }
    
    @WebMethod(operationName = "eliminarLocal")
    public int eliminarLocal(@WebParam(name = "idLocal") int idLocal) {
        boLocal = new LocalBO();
        return boLocal.eliminar(idLocal);
    }
    
    @WebMethod(operationName = "listarLocales")
    public ArrayList<Local> listarLocales(){
        boLocal = new LocalBO();
        return boLocal.listarTodos();
    }
    
    @WebMethod(operationName = "obtenerLocalPorId")
    public Local obtenerLocalPorId(
            @WebParam(name = "idLocal") int idLocal){
        boLocal = new LocalBO();
        return boLocal.obtenerLocalPorId(idLocal);
    }
}
