package pe.edu.pucp.usuario.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.usuario.bo.AdministradorBO;
import pe.edu.pucp.usuario.model.Administrador;

@WebService(serviceName = "AdministradorWS", targetNamespace = "http://services.pucp.edu.pe")
public class AdministradorWS {

    private AdministradorBO boAdministrador;
    
    @WebMethod(operationName = "insertarAdministrador")
    public int insertarAdministrador(@WebParam(name = "administrador") Administrador administrador) {
        boAdministrador = new AdministradorBO();
        return boAdministrador.insertar(administrador);
    }
    
    @WebMethod(operationName = "modificarAdministrador")
    public int modificarAdministrador(@WebParam(name = "administrador") Administrador administrador) {
        boAdministrador = new AdministradorBO();
        return boAdministrador.modificar(administrador);
    }
    
    @WebMethod(operationName = "eliminarAdministrador")
    public int eliminarAdministrador(@WebParam(name = "idAdministrador") String idAdministrador) {
        boAdministrador = new AdministradorBO();
        return boAdministrador.eliminar(idAdministrador);
    }
    
    @WebMethod(operationName = "listarAdministrador")
    public ArrayList<Administrador> listarAdministrador(){
        boAdministrador = new AdministradorBO();
        return boAdministrador.listarTodos();
    }
    
    @WebMethod(operationName = "obtenerAdministradorPorId")
    public Administrador obtenerAdministradorPorId(
            @WebParam(name = "idAdministrador") String idAdministrador){
        boAdministrador = new AdministradorBO();
        return boAdministrador.obtenerPorId(idAdministrador);
    }
}
