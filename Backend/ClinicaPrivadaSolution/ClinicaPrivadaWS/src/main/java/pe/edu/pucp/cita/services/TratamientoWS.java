package pe.edu.pucp.cita.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.cita.bo.TratamientoBO;
import pe.edu.pucp.cita.model.Tratamiento;

@WebService(serviceName = "TratamientoWS", targetNamespace = "http://services.pucp.edu.pe")
public class TratamientoWS {

    private TratamientoBO boTratamiento;
    
    @WebMethod(operationName = "insertarTratamiento")
    public int insertarTratamiento(@WebParam(name = "tratamiento") Tratamiento tratamiento) {
        boTratamiento = new TratamientoBO();
        return boTratamiento.insertar(tratamiento);
    }
    
    @WebMethod(operationName = "modificarTratamiento")
    public int modificarTratamiento(@WebParam(name = "tratamiento") Tratamiento tratamiento) {
        boTratamiento = new TratamientoBO();
        return boTratamiento.modificar(tratamiento);
    }
    
    @WebMethod(operationName = "eliminarTratamiento")
    public int eliminarTratamiento(@WebParam(name = "idTratamiento") int idTratamiento) {
        boTratamiento = new TratamientoBO();
        return boTratamiento.eliminar(idTratamiento);
    }
    
    @WebMethod(operationName = "listarTratamientos")
    public ArrayList<Tratamiento> listarTratamientos(){
        boTratamiento = new TratamientoBO();
        return boTratamiento.listarTodos();
    }
    
    @WebMethod(operationName = "obtenerTratamientoPorId")
    public Tratamiento obtenerTratamientoPorId(
            @WebParam(name = "idTratamiento") int idTratamiento){
        boTratamiento = new TratamientoBO();
        return boTratamiento.obtenerPorId(idTratamiento);
    }
}
