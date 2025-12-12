package pe.edu.pucp.cita.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.cita.bo.HistorialClinicoBO;
import pe.edu.pucp.cita.model.HistorialClinico;

@WebService(serviceName = "HistorialClinicoWS", targetNamespace = "http://services.pucp.edu.pe")
public class HistorialClinicoWS {

    private HistorialClinicoBO boHistorialClinico;
    
    @WebMethod(operationName = "insertarHistorialClinico")
    public int insertarHistorialClinico(@WebParam(name = "historialClinico") HistorialClinico historialClinico) {
        boHistorialClinico = new HistorialClinicoBO();
        return boHistorialClinico.insertar(historialClinico);
    }
    
    @WebMethod(operationName = "modificarHistorialClinico")
    public int modificarHistorialClinico(@WebParam(name = "historialClinico") HistorialClinico historialClinico) {
        boHistorialClinico = new HistorialClinicoBO();
        return boHistorialClinico.modificar(historialClinico);
    }
    
    @WebMethod(operationName = "eliminarHistorialClinico")
    public int eliminarHistorialClinico(@WebParam(name = "idHistorialClinico") int idHistorialClinico) {
        boHistorialClinico = new HistorialClinicoBO();
        return boHistorialClinico.eliminar(idHistorialClinico);
    }
    
    @WebMethod(operationName = "obtenerHistorialConCitas")
    public HistorialClinico obtenerHistorialConCitas(
                @WebParam(name = "idHistorialClinico") String codigoPaciente){
        boHistorialClinico = new HistorialClinicoBO();
        return boHistorialClinico.obtenerHistorialConCitas(codigoPaciente);
    }
}
