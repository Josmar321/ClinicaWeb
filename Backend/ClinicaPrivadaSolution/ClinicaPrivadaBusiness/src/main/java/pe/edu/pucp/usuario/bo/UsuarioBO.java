package pe.edu.pucp.usuario.bo;

import java.util.ArrayList;
import pe.edu.pucp.usuario.dao.UsuarioDAO;
import pe.edu.pucp.usuario.model.Usuario;
import pe.edu.pucp.usuario.mysql.UsuarioMySQL;

public class UsuarioBO {
    private UsuarioDAO daoUsuario = new UsuarioMySQL();

    public int insertar(Usuario usuario) {
        return daoUsuario.insertar(usuario);
    }
    
    public String verificar(String user,String pass){
        return daoUsuario.verificar(user,pass);
    }
    public int modificar(Usuario usuario) {
        return daoUsuario.modificar(usuario);
    }

    public int eliminarPorId(int idUsuario) {
        return daoUsuario.eliminar(idUsuario);
    }
    
    public int eliminarPorUsername(String username) {
        return daoUsuario.eliminar(username);
    }

    public ArrayList<Usuario> listarTodos() {
        return daoUsuario.listarTodos();
    }

    public Usuario obtenerPorId(int idUsuario) {
        return daoUsuario.obtenerPorId(idUsuario);
    }
    
    public int obtenerPorUsername(String username) {
        return daoUsuario.obtenerPorUsername(username);
    }

}
