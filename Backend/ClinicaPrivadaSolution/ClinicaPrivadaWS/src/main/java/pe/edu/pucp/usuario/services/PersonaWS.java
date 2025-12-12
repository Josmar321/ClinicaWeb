package pe.edu.pucp.usuario.services;

import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import java.util.ArrayList;
import pe.edu.pucp.usuario.bo.AdministradorBO;
import pe.edu.pucp.usuario.bo.MedicoBO;
import pe.edu.pucp.usuario.bo.PacienteBO;
import pe.edu.pucp.usuario.bo.PersonaBO;
import pe.edu.pucp.usuario.model.Persona;

@WebService(serviceName = "PersonaWS", 
        targetNamespace = "http://services.pucp.edu.pe")
public class PersonaWS {

    private PersonaBO boPersona;
    private AdministradorBO boAdmin;
    private MedicoBO boMedico;
    private PacienteBO boPaciente;
    
    @WebMethod(operationName = "insertarPersona")
    public int insertarPersona(@WebParam(name = "persona") Persona persona) {
        boPersona = new PersonaBO();
        return boPersona.insertar(persona);
    }
    
    @WebMethod(operationName = "modificarPersona")
    public int modificarPersona(@WebParam(name = "persona") Persona persona) {
        boPersona = new PersonaBO();
        return boPersona.modificar(persona);
    }
    
    @WebMethod(operationName = "eliminarPersona")
    public int eliminarPersona(@WebParam(name = "docIdentidad") String docIdentidad) {
        boPersona = new PersonaBO();
        return boPersona.eliminar(docIdentidad);
    }
    
    @WebMethod(operationName = "listarPersona")
    public ArrayList<Persona> listarPersona(){
        return null;
    }
    
    @WebMethod(operationName = "obtenerPersonaPorDocIndentidad")
    public int obtenerPersonaPorDocIndentidad(
            @WebParam(name = "docIdentidad") String docIdentidad){
        boPersona = new PersonaBO();
        return boPersona.obtenerPorDocIdentidad(docIdentidad);
    }
    @WebMethod(operationName = "obtenerNombreXIdUser")
    public String obtenerNombreXIdUser(
            @WebParam(name = "docIdentidad") int idUser){
        boPersona = new PersonaBO();
        return boPersona.obtenerNombreXIdUser(idUser);
    }
    @WebMethod(operationName = "obtenerDocIdentidadXIdUser")
    public String obtenerDocIdentidadXIdUser(
            @WebParam(name = "idUsuario") int idUser){
        boPersona = new PersonaBO();
        return boPersona.obtenerDocIdentidadXIdUser(idUser);
    }
    @WebMethod(operationName = "obtenerFotoXUser")
    public byte[] obtenerFotoXUser(
            @WebParam(name = "docIdentidad") int idUser){
        boPersona = new PersonaBO();
        return boPersona.obtenerFotoXUser(idUser);
    }
}
