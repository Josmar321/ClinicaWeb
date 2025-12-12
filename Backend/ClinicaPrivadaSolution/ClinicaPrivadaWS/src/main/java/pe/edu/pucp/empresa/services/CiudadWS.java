package pe.edu.pucp.empresa.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.empresa.bo.CiudadBO;
import pe.edu.pucp.empresa.model.Ciudad;

@WebService(serviceName = "CiudadWS", targetNamespace = "http://services.pucp.edu.pe")
public class CiudadWS {

    private CiudadBO boCiudad;
    
    @WebMethod(operationName = "obtenerCiudadPorId")
    public Ciudad obtenerCiudadPorId(
            @WebParam(name = "idCiudad") int idCiudad){
        boCiudad = new CiudadBO();
        return boCiudad.obtenerCiudadPorId(idCiudad);
    }
    
    @WebMethod(operationName = "listarCiudades")
    public ArrayList<Ciudad> listarCiudades(){
        boCiudad = new CiudadBO();
        return boCiudad.listarTodasLasCiudades();
    }
}
