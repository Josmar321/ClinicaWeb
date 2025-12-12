package pe.edu.pucp.empresa.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.empresa.bo.EspecialidadBO;
import pe.edu.pucp.empresa.model.Especialidad;

@WebService(serviceName = "EspecialidadWS", targetNamespace = "http://services.pucp.edu.pe")
public class EspecialidadWS {

    private EspecialidadBO boEspecialidad;
    
    @WebMethod(operationName = "insertarEspecialidad")
    public int insertarEspecialidad(@WebParam(name = "especialidad") Especialidad especialidad) {
        boEspecialidad = new EspecialidadBO();
        return boEspecialidad.insertar(especialidad);
    }
    
    @WebMethod(operationName = "modificarEspecialidad")
    public int modificarEspecialidad(@WebParam(name = "especialidad") Especialidad especialidad) {
        boEspecialidad = new EspecialidadBO();
        return boEspecialidad.modificar(especialidad);
    }
    
    @WebMethod(operationName = "eliminarEspecialidad")
    public int eliminarEspecialidad(@WebParam(name = "idEspecialidad") int idEspecialidad) {
        boEspecialidad = new EspecialidadBO();
        return boEspecialidad.eliminar(idEspecialidad);
    }
    
    @WebMethod(operationName = "listarEspecialidad")
    public ArrayList<Especialidad> listarEspecialidad(){
        boEspecialidad = new EspecialidadBO();
        return boEspecialidad.listarTodos();
    }
    
    @WebMethod
    public ArrayList<Especialidad> listarPorIdLocal(int idLocal) {
        boEspecialidad = new EspecialidadBO();
        return boEspecialidad.listarPorIdLocal(idLocal);
    }

    @WebMethod(operationName = "obtenerEspecialidadPorId")
    public Especialidad obtenerEspecialidadPorId(@WebParam(name = "idEspecialidad") int idEspecialidad) {
        boEspecialidad = new EspecialidadBO();
        return boEspecialidad.obtenerPorId(idEspecialidad);
    }

}
