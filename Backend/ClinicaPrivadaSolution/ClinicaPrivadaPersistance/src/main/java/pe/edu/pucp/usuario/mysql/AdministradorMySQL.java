package pe.edu.pucp.usuario.mysql;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.empresa.model.Ciudad;
import pe.edu.pucp.empresa.model.Departamento;
import pe.edu.pucp.usuario.dao.AdministradorDAO;
import pe.edu.pucp.usuario.dao.PersonaDAO;
import pe.edu.pucp.usuario.model.Administrador;
import pe.edu.pucp.usuario.model.Usuario;


public class AdministradorMySQL implements AdministradorDAO{
    private ResultSet rs;
    
    @Override
    public int insertar(Administrador administrador) {
        PersonaDAO daoPersona = new PersonaMySQL();
        int medicoExiste = daoPersona.obtenerPorDocIdentidad(administrador.getDocIdentidad());

        if (medicoExiste == 0) {
            Map<Integer, Object> parametrosPersona = new HashMap<>();
            parametrosPersona.put(1, administrador.getDocIdentidad());
            parametrosPersona.put(2, administrador.getNombre());
            parametrosPersona.put(3, administrador.getPrimerApellido());
            parametrosPersona.put(4, administrador.getSegundoApellido());
            parametrosPersona.put(5, administrador.getTelefono());
            parametrosPersona.put(6, administrador.getDireccion());
            parametrosPersona.put(7, administrador.getEmail());
            parametrosPersona.put(8, administrador.getFechaNacimiento());
            parametrosPersona.put(9, String.valueOf(administrador.getSexo()));
            parametrosPersona.put(10, administrador.getFoto());
            parametrosPersona.put(11, administrador.getUsuario().getIdUsuario());
            parametrosPersona.put(12, administrador.getCiudad().getId());
            parametrosPersona.put(13, administrador.getDepartamento().getId());

            DBManager.getInstance().ejecutarProcedimiento("insertar_persona", parametrosPersona, null);
        }

        try {
            Map<Integer, Object> parametrosAdmin= new HashMap<>();
            parametrosAdmin.put(1, administrador.getDocIdentidad());

            DBManager.getInstance().ejecutarProcedimiento("insertar_administrador", parametrosAdmin, null);

            System.out.println("administrador insertado correctamente");
            return 1;

        } catch (Exception e) {
            System.err.println("error al insertar administrador: " + e.getMessage());
            return 0;
        }
    }

    @Override
    public int modificar(Administrador admin) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        parametrosEntrada.put(1, admin.getDocIdentidad());
        parametrosEntrada.put(2, admin.getNombre());
        parametrosEntrada.put(3, admin.getPrimerApellido());
        parametrosEntrada.put(4, admin.getSegundoApellido());
        parametrosEntrada.put(5, admin.getTelefono());
        parametrosEntrada.put(6, admin.getDireccion());
        parametrosEntrada.put(7, admin.getEmail());
        parametrosEntrada.put(8, admin.getFechaNacimiento());
        parametrosEntrada.put(9, String.valueOf(admin.getSexo()));
        parametrosEntrada.put(10, admin.getFoto());
//        parametrosEntrada.put(11, admin.getUsuario().getUsername());
        parametrosEntrada.put(11, admin.getCiudad().getId());
        parametrosEntrada.put(12, admin.getDepartamento().getId());

        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_administrador", parametrosEntrada, null);

        System.out.println("Se ha actualizado correctamente el administrador.");
        return resultado;
    }
    @Override
    public int eliminar(String codigoAdministrador) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, codigoAdministrador);

        try {
            int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_administrador", parametrosEntrada, null);
            if (resultado > 0) {
                System.out.println("Administrador eliminado ");
                return 1;
            } else {
                System.out.println("No se encontro un administrador con dicho codigo");
                return 0;
            }
        } catch (Exception ex) {
            System.err.println("Error al eliminar administrador" + ex.getMessage());
            return 0;
        }
    }

    @Override
    public ArrayList<Administrador> listarTodos() {
        ArrayList<Administrador> administradores = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_administradores", null);
        System.out.println("Lectura de administradores...");
        try {
            while (rs.next()) {
                if(administradores == null) administradores = new ArrayList<>();
                Administrador admin = new Administrador();
                admin.setDocIdentidad(rs.getString("docIdentidad"));
                admin.setNombre(rs.getString("nombres"));
                admin.setPrimerApellido(rs.getString("primerApellido"));
                admin.setSegundoApellido(rs.getString("segundoApellido"));
                
                admin.setTelefono(rs.getString("telefono"));
                admin.setDireccion(rs.getString("direccion"));
                admin.setEmail(rs.getString("email"));
                admin.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                admin.setSexo(rs.getString("genero").charAt(0));
                admin.setFoto(rs.getBytes("foto"));
                
                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("ciudad_id"));
                ciudad.setNombre(rs.getString("ciudad_nombre"));
                admin.setCiudad(ciudad);
                
                Departamento departamento = new Departamento();
                departamento.setId(rs.getInt("departamento_id"));
                departamento.setNombre(rs.getString("departamento_nombre"));
                admin.setDepartamento(departamento);
                
                admin.setActivo(rs.getBoolean("activo"));
                
                /*
                Usuario usuario = new Usuario();
                usuario.setUsername(rs.getString("username"));
                admin.setUsuario(usuario);
                */

                //admin.setCodigoAdministrador(rs.getString("docIdentidad")); 

                administradores.add(admin);
            }
        } catch (Exception ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return administradores;
    }


    @Override
    public Administrador obtenerPorId(String codigoAdministrador) {
        Administrador admin = null;
        Map<Integer, Object> parametros = new HashMap<>();
        parametros.put(1, codigoAdministrador);

        rs = null;

        try {
            rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_administrador_por_id", parametros);
            System.out.println("Buscando administrador por código...");

            if (rs.next()) {
                admin = new Administrador();
                admin.setDocIdentidad(rs.getString("docIdentidad"));
                admin.setNombre(rs.getString("nombres"));
                admin.setPrimerApellido(rs.getString("primerApellido"));
                admin.setSegundoApellido(rs.getString("segundoApellido"));
                admin.setTelefono(rs.getString("telefono"));
                admin.setDireccion(rs.getString("direccion"));
                admin.setEmail(rs.getString("email"));
                admin.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                admin.setSexo(rs.getString("genero").charAt(0));
                admin.setFoto(rs.getBytes("foto"));
                
                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("ciudad_id"));
                ciudad.setNombre(rs.getString("ciudad_nombre"));
                admin.setCiudad(ciudad);
                
                Departamento departamento = new Departamento();
                departamento.setId(rs.getInt("departamento_id"));
                departamento.setNombre(rs.getString("departamento_nombre"));
                admin.setDepartamento(departamento);
                
                admin.setActivo(rs.getBoolean("activo"));

                admin.setCodigoAdministrador(rs.getString("docIdentidad")); 
            }

            rs.close();
        } catch (Exception ex) {
            System.err.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return admin;
    }

    @Override
    public int eliminar(int idModelo) {
        return eliminar(String.valueOf(idModelo));
    }
}
