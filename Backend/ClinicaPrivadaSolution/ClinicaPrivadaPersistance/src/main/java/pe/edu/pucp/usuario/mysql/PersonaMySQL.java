
package pe.edu.pucp.usuario.mysql;

import java.sql.Blob;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.usuario.dao.PersonaDAO;
import pe.edu.pucp.usuario.model.Persona;
import pe.edu.pucp.usuario.model.Rol;
import pe.edu.pucp.usuario.model.Usuario;
public class PersonaMySQL implements PersonaDAO{
    private ResultSet rs;

    @Override
    public int obtenerPorDocIdentidad(String docIdentidad) {
        int estoRetornara=0;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, docIdentidad);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_persona_por_docIdentidad", parametrosEntrada);
        System.out.println("Lectura de persona...");
        try{
            if(rs.next()){
                estoRetornara = 1;
            }
        }catch(SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return estoRetornara;
    }
    @Override
    public int insertar(Persona persona) {
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            parametrosEntrada.put(1, persona.getDocIdentidad());
            parametrosEntrada.put(2, persona.getNombre());
            parametrosEntrada.put(3, persona.getPrimerApellido());
            parametrosEntrada.put(4, persona.getSegundoApellido());
            parametrosEntrada.put(5, persona.getTelefono());
            parametrosEntrada.put(6, persona.getDireccion());
            parametrosEntrada.put(7, persona.getEmail());
            parametrosEntrada.put(8, persona.getFechaNacimiento());
            parametrosEntrada.put(9, String.valueOf(persona.getSexo()));
            parametrosEntrada.put(10, persona.getFoto());
            parametrosEntrada.put(11, persona.getUsuario().getUsername());
            parametrosEntrada.put(12, persona.getCiudad().getId());
            parametrosEntrada.put(13, persona.getDepartamento().getId());
            DBManager.getInstance().ejecutarProcedimiento("insertar_persona", parametrosEntrada,null);

            System.out.println("Se ha realizado el registro del usuario.");
            return 1;

        } catch (Exception e) {
            System.err.println("Error al insertar usuario: " + e.getMessage());
            return 0;
        }
    }
    
    @Override
    public int modificar(Persona persona) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        parametrosEntrada.put(1, persona.getDocIdentidad());
        parametrosEntrada.put(2, persona.getNombre());
        parametrosEntrada.put(3, persona.getPrimerApellido());
        parametrosEntrada.put(4, persona.getSegundoApellido());
        parametrosEntrada.put(5, persona.getTelefono());
        parametrosEntrada.put(6, persona.getDireccion());
        parametrosEntrada.put(7, persona.getEmail());
        parametrosEntrada.put(8, persona.getFechaNacimiento());
        parametrosEntrada.put(9, String.valueOf(persona.getSexo()));
        parametrosEntrada.put(10, persona.getFoto());
        parametrosEntrada.put(11, persona.getUsuario().getUsername());

        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_persona", parametrosEntrada, null);
        System.out.println("medico modificado correctamente.");
        return resultado;
    }
    
    @Override
    public int eliminar(String docIdentidad) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, docIdentidad);

        try {
            int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_persona", parametrosEntrada, null);
            if (resultado > 0) {
                System.out.println("Persona eliminada correctamente.");
                return 1;
            } else {
                System.out.println("No se encontró una persona con el código indicado.");
                return 0;
            }
        } catch (Exception ex) {
            System.err.println("Error al eliminar persona: " + ex.getMessage());
            return 0;
        }
    }
    
    
    @Override
    public ArrayList<Persona> listarTodos() {
        return null;
    }
    /*
    @Override
    public ArrayList<Persona> listarTodos() {
        ArrayList<Persona> personas = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_personas", null);
        System.out.println("Lectura de personas...");
        try {
            while (rs.next()) {
                if(personas == null) personas = new ArrayList<>();
                //Persona persona = new Persona();
                Persona persona =  new Persona();
                persona.setDocIdentidad(rs.getString("docIdentidad"));
                persona.setNombre(rs.getString("nombres"));
                persona.setPrimerApellido(rs.getString("primerApellido"));
                persona.setSegundoApellido(rs.getString("segundoApellido"));
                persona.setActivo(rs.getBoolean("activo"));
                personas.add(persona);
            }
        }catch(SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return personas;
    }*/
    
    /*
    @Override
    public int obtenerPorIdPadre(String docIdentidad) {
        
        int estoRetornara=0;
        try {
            con = DBManager.getInstance().getConnection();
            String sql = "SELECT p.docIdentidad, p.nombres, p.primerApellido, "
                       + "p.segundoApellido, p.telefono, p.direccion, "
                       + "p.email, p.fechaNacimiento, p.genero, p.foto "
                       + "FROM Persona p WHERE p.docIdentidad = ?";

            pst = con.prepareStatement(sql);
            pst.setString(1, docIdentidad);
            rs = pst.executeQuery();
            
            if (rs.next()) {
                // Solo si existe una fila en el ResultSet
                estoRetornara = 1;
            }
        } catch(SQLException ex){
            System.out.println(ex.getMessage());
        } finally {
            //Cerramos la conexión.
            try { rs.close(); } catch(SQLException ex) { System.out.println(ex.getMessage()); }
            try { con.close(); } catch(SQLException ex) { System.out.println(ex.getMessage()); }
        }
        return estoRetornara;
    }
    */

    @Override
    public int eliminar(int idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public String obtenerNombreXIdUser(int idUsuario) {
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            Map<Integer, Object> parametrosSalida = new HashMap<>();

            
            parametrosEntrada.put(1, idUsuario);
            
            parametrosSalida.put(2, Types.VARCHAR);
            parametrosSalida.put(3,Types.VARCHAR);
            

            // Ejecutar el procedimiento
            DBManager.getInstance().ejecutarProcedimiento("ObtenerNombrePersona", parametrosEntrada, parametrosSalida);

            // Obtener el resultado desde el parámetro de salida
            String nombre = (String) parametrosSalida.get(2);
            String apellido=(String)parametrosSalida.get(3);
            String completo = nombre+" "+apellido;
            return completo;

        } catch (Exception e) {
            System.err.println("Error al obtener nombre: " + e.getMessage());
            return null;
        }
    }

    @Override
    public String obtenerDocIdentidadXIdUser(int idUsuario) {
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            Map<Integer, Object> parametrosSalida = new HashMap<>();

            
            parametrosEntrada.put(1, idUsuario);
            
            parametrosSalida.put(2, Types.VARCHAR);
            

            // Ejecutar el procedimiento
            DBManager.getInstance().ejecutarProcedimiento("ObtenerDocIdentidadPersona", parametrosEntrada, parametrosSalida);

            // Obtener el resultado desde el parámetro de salida
            String docId = (String) parametrosSalida.get(2);
            return docId;

        } catch (Exception e) {
            System.err.println("Error al obtener el documento de identidad: " + e.getMessage());
            return null;
        }
    }
    
    @Override
    public byte[] obtenerFotoXUser(int idUser) {
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            Map<Integer, Object> parametrosSalida = new HashMap<>();

            parametrosEntrada.put(1, idUser);
            parametrosSalida.put(2, Types.BLOB); // Tipo de salida esperado

            // Ejecutar el procedimiento
            DBManager.getInstance().ejecutarProcedimiento("obtenerFotoPersona", parametrosEntrada, parametrosSalida);

            Object resultado = parametrosSalida.get(2);

            if (resultado == null) {
                System.out.println("No se encontró la foto.");
                return null;
            }

            if (resultado instanceof byte[]) {
                return (byte[]) resultado;
            } else if (resultado instanceof Blob) {
                Blob blob = (Blob) resultado;
                return blob.getBytes(1, (int) blob.length());
            } else {
                System.out.println("Tipo inesperado en la respuesta: " + resultado.getClass());
                return null;
            }

        } catch (Exception e) {
            System.err.println("Error al obtener foto: " + e.getMessage());
            return null;
        }
    }
}