package pe.edu.pucp.cita.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import java.time.LocalDate;
import java.util.Date;
import pe.edu.pucp.cita.bo.DiagnosticoBO;
import pe.edu.pucp.cita.model.Diagnostico;

@WebService(serviceName = "DiagnosticoWS", targetNamespace = "http://services.pucp.edu.pe")
public class DiagnosticoWS {

    private DiagnosticoBO boDiagnostico;
    
    @WebMethod(operationName = "insertarDiagnostico")
    public int insertarDiagnostico(@WebParam(name = "diagnostico") Diagnostico diagnostico) {
        boDiagnostico = new DiagnosticoBO();
        return boDiagnostico.insertar(diagnostico);
    }
    
    @WebMethod(operationName = "modificarDiagnostico")
    public int modificarDiagnostico(@WebParam(name = "diagnostico") Diagnostico diagnostico) {
        boDiagnostico = new DiagnosticoBO();
        return boDiagnostico.modificar(diagnostico);
    }
    
    @WebMethod(operationName = "eliminarDiagnostico")
    public int eliminarDiagnostico(@WebParam(name = "idDiagnostico") int idDiagnostico) {
        boDiagnostico = new DiagnosticoBO();
        return boDiagnostico.eliminar(idDiagnostico);
    }

    @WebMethod(operationName = "listarDiagnosticos")
    public ArrayList<Diagnostico> listarDiagnosticos(){
        boDiagnostico = new DiagnosticoBO();
        return boDiagnostico.listarTodos();
    }
    
    @WebMethod(operationName = "obtenerDiagnosticoPorId")
    public Diagnostico obtenerDiagnosticoPorId(
            @WebParam(name = "idDiagnostico") int idDiagnostico){
        boDiagnostico = new DiagnosticoBO();
        return boDiagnostico.obtenerPorId(idDiagnostico);
    }
    
    @WebMethod(operationName = "obtenerDiagnosticosPorFecha")
    public ArrayList<Diagnostico> obtenerDiagnosticosPorFecha(
            @WebParam(name = "fechaInicio")Date fechaInicio, 
            @WebParam(name = "fechaFin")Date fechaFin){
        boDiagnostico = new DiagnosticoBO();
        return boDiagnostico.obtenerDiagnosticosPorFecha(fechaInicio, fechaFin);
    }
}
