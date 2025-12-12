package pe.edu.pucp.usuario.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.usuario.dao.UsuarioDAO;
import pe.edu.pucp.usuario.model.Rol;
import pe.edu.pucp.usuario.model.Usuario;

public class UsuarioMySQL implements UsuarioDAO{
    private ResultSet rs;

    @Override
    public int insertar(Usuario usuario) {
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            Map<Integer,Object> parametrosSalida = new HashMap<>();
            parametrosSalida.put(1, Types.INTEGER);
            parametrosEntrada.put(2, usuario.getUsername());
            parametrosEntrada.put(3, usuario.getPassword());
            parametrosEntrada.put(4, usuario.getRol().toString());
          

            DBManager.getInstance().ejecutarProcedimiento("insertar_usuario", parametrosEntrada,parametrosSalida);
            usuario.setIdUsuario((int) parametrosSalida.get(1));

            System.out.println("Se ha realizado el registro del usuario.");
            return usuario.getIdUsuario();

        } catch (Exception e) {
            System.err.println("Error al insertar usuario: " + e.getMessage());
            return 0;
        }
    }
    @Override
    public String verificar(String user,String password) {
    try {
        // Parámetros de entrada (posición, valor)
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1,user);
        parametrosEntrada.put(2, password);
        // Parámetros de salida (posición, tipo SQL)
        Map<Integer, Object> parametrosSalida = new HashMap<>();
        parametrosSalida.put(3, Types.BOOLEAN); // p_existe
        parametrosSalida.put(4, Types.VARCHAR); // p_rol
        // Ejecutar procedimiento almacenado
        DBManager.getInstance().ejecutarProcedimiento("verificar_usuario", parametrosEntrada, parametrosSalida);
        // Obtener resultados de salida
        Boolean existe = (Boolean) parametrosSalida.get(3);
        String rol = (String) parametrosSalida.get(4);
        if (Boolean.TRUE.equals(existe)) {
            return rol;
        } else {
            return null;
        }
    } catch (Exception ex) {
        System.err.println("Error al verificar usuario: " + ex.getMessage());
        return null;
    }
}

    @Override
    public int modificar(Usuario usuario) {
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            parametrosEntrada.put(1, usuario.getIdUsuario());
            parametrosEntrada.put(2, usuario.getUsername());
            parametrosEntrada.put(3, usuario.getPassword());
            parametrosEntrada.put(4, usuario.getRol().toString());
            parametrosEntrada.put(5, usuario.isActivo());   

            int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_usuario", parametrosEntrada, null);
            System.out.println("Usuario modificado correctamente.");
            return resultado;

        } catch (Exception ex) {
            System.err.println("Error al modificar usuario: " + ex.getMessage());
            return 0;
        }
    }
    
    @Override
    public int eliminar(int idUsuario) {
        try {
            Map<Integer, Object> parametros = new HashMap<>();
            parametros.put(1, idUsuario);

            int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_usuario", parametros, null);
            System.out.println("Usuario eliminado correctamente.");
            return resultado;
        } catch (Exception ex) {
            System.err.println("Error al eliminar usuario: " + ex.getMessage());
            return 0;
        }
    }
    
    @Override
    public ArrayList<Usuario> listarTodos() {
        ArrayList<Usuario> usuarios = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_usuarios", null);
        System.out.println("Lectura de usuarios...");
        try {
            while (rs.next()) {
                if(usuarios == null) usuarios = new ArrayList<>();
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setRol(Rol.valueOf(rs.getString("rol")));
                usuario.setActivo(rs.getBoolean("activo"));
                usuarios.add(usuario);
            }
        }catch(SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return usuarios;
    }
    
    @Override
    public Usuario obtenerPorId(int idUsuario) {
        Usuario usuario = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idUsuario);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_usuario_por_id", parametrosEntrada);
        System.out.println("Lectura de usuario...");
        try{
            if(rs.next()){
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setRol(Rol.valueOf(rs.getString("rol")));
                usuario.setActivo(rs.getBoolean("activo"));
            }
        }catch(SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return usuario;
    }
    
    @Override
    public int obtenerPorUsername(String username) {
        Usuario usuario = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, username);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_usuario_por_username", parametrosEntrada);
        System.out.println("Lectura de usuario...");
        try{
            if(rs.next()){
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idUsuario"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setRol(Rol.valueOf(rs.getString("rol")));
                usuario.setActivo(rs.getBoolean("activo"));
            }
        }catch(SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        if (usuario != null && usuario.getIdUsuario() > 0) {
            return usuario.getIdUsuario();
        } else {
            return 0;
        }

    }
    
    @Override
    public int eliminar(String username) {
        try {
            Map<Integer, Object> parametros = new HashMap<>();
            parametros.put(1, username);

            int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_usuario_username", parametros, null);
            System.out.println("Usuario eliminado correctamente.");
            return resultado;
        } catch (Exception ex) {
            System.err.println("Error al eliminar usuario: " + ex.getMessage());
            return 0;
        }
    }
}