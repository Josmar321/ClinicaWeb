package pe.edu.pucp.usuario.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.usuario.bo.UsuarioBO;
import pe.edu.pucp.usuario.model.Rol;
import pe.edu.pucp.usuario.model.Usuario;

@WebService(serviceName = "UsuarioWS", 
        targetNamespace = "http://services.pucp.edu.pe")
public class UsuarioWS {

    private UsuarioBO boUsuario = new UsuarioBO();
    
    @WebMethod(operationName = "insertarUsuario")
    public int insertarUsuario(@WebParam(name = "usuario") Usuario usuario, String rol) {
        Rol rolnew = Rol.valueOf(rol);
        usuario.setRol(rolnew);
        return boUsuario.insertar(usuario);
    }
    
    @WebMethod(operationName="verificarUsuario")
    public String verificarUsuario(@WebParam(name="usuario")String user, String pass){
        return boUsuario.verificar(user, pass);
    }
    
    @WebMethod(operationName = "modificarUsuario")
    public int modificarUsuario(@WebParam(name = "usuario") Usuario usuario, String rol) {
        Rol rolnew = Rol.valueOf(rol);
        usuario.setRol(rolnew);
        return boUsuario.modificar(usuario);
    }
    
    @WebMethod(operationName = "eliminarUsuarioPorId")
    public int eliminarUsuarioPorId(@WebParam(name = "idUsuario") int idUsuario) {
        return boUsuario.eliminarPorId(idUsuario);
    }
    
    @WebMethod(operationName = "eliminarUsuarioPorUsername")
    public int eliminarUsuarioPorUsername(@WebParam(name = "username") String username) {
        return boUsuario.eliminarPorUsername(username);
    }
    
    @WebMethod(operationName = "listarUsuario")
    public ArrayList<Usuario> listarUsuario(){
        return boUsuario.listarTodos();
    }
    
    @WebMethod(operationName = "obtenerUsuarioPorId")
    public Usuario obtenerUsuarioPorId(
            @WebParam(name = "idUsuario") int idUsuario){
        return boUsuario.obtenerPorId(idUsuario);
    }
    
    @WebMethod(operationName = "obtenerUsuarioPorUsername")
    public int obtenerUsuarioPorUsername(
            @WebParam(name = "username") String username){
        return boUsuario.obtenerPorUsername(username);
    }

    
}
