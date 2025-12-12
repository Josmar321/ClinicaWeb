package pe.edu.pucp.cita.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.Date;
import java.util.ArrayList;
import pe.edu.pucp.cita.bo.CitaMedicaBO;
import pe.edu.pucp.cita.model.CitaMedica;

@WebService(serviceName = "CitaMedicaWS", targetNamespace = "http://services.pucp.edu.pe")
public class CitaMedicaWS {

    private CitaMedicaBO boCitaMedica;
    
    @WebMethod(operationName = "insertarCitaMedica")
    public int insertarCitaMedica(@WebParam(name = "citaMedica") CitaMedica citaMedica) {
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.insertar(citaMedica);
    }
    
    @WebMethod(operationName = "modificarCitaMedica")
    public int modificarCitaMedica(@WebParam(name = "citaMedica") CitaMedica citaMedica) {
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.modificar(citaMedica);
    }
    
    @WebMethod(operationName = "eliminarCitaMedica")
    public int eliminarCitaMedica(@WebParam(name = "idCitaMedica") int idCitaMedica) {
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.eliminar(idCitaMedica);
    }
    
    @WebMethod(operationName = "listarCitasMedicas")
    public ArrayList<CitaMedica> listarCitasTodas(){
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.listarTodos();
    }

    @WebMethod(operationName = "modificarCitaMedico")
    public int modificarCitaMedico(@WebParam(name = "citaMedica") CitaMedica citaMedica) {
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.modificarCitaMedico(citaMedica);
    }
    
    @WebMethod(operationName = "modificarCitaMedicaPaciente")
    public int modificarCitaMedicaPaciente(@WebParam(name = "citaMedica") CitaMedica citaMedica) {
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.modificarCitaPaciente(citaMedica);
    }
    
    @WebMethod(operationName = "cancelarCitaMedica")
    public int cancelarCitaMedica(@WebParam(name = "idCitaMedica") int idCitaMedica) {
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.cancelarCitaMedica(idCitaMedica);
    }
    
    @WebMethod(operationName = "obtenerCitasPorFecha")
    public ArrayList<CitaMedica> obtenerCitasPorFecha(
            @WebParam(name = "fechaInicio")Date fechaInicio, 
            @WebParam(name = "fechaFin")Date fechaFin){
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.obtenerCitasPorFecha(fechaInicio, fechaFin);
    }
    
    @WebMethod(operationName = "listarCitasPorPaciente")
    public ArrayList<CitaMedica> listarCitasPorPaciente(@WebParam(name = "codigoPaciente") String codigoPaciente) {
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.listarCitasPorPaciente(codigoPaciente);
    }
    
    @WebMethod(operationName = "obtenerCitaMedicaPorId")
    public CitaMedica obtenerCitaMedicaPorId(@WebParam(name = "idCitaMedica") int idCitaMedica) {
        boCitaMedica = new CitaMedicaBO();
        return boCitaMedica.obtenerPorId(idCitaMedica);
    }

}
