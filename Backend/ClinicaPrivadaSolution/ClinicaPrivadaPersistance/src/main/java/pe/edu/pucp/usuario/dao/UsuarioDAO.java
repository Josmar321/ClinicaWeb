package pe.edu.pucp.usuario.dao;

import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.usuario.model.Usuario;

public interface UsuarioDAO extends ICrud<Usuario>{
    Usuario obtenerPorId(int idUsuario);
    int obtenerPorUsername(String username);
    String verificar(String user,String password) ;
}