
package pe.edu.pucp.usuario.mysql;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.empresa.model.Ciudad;
import pe.edu.pucp.empresa.model.Departamento;
import pe.edu.pucp.usuario.dao.PacienteDAO;
import pe.edu.pucp.usuario.dao.PersonaDAO;
import pe.edu.pucp.usuario.model.Paciente;
import pe.edu.pucp.usuario.model.TipoDeSangre;
import pe.edu.pucp.usuario.model.Usuario;


public class PacienteMySQL implements PacienteDAO{
    private ResultSet rs;

    @Override
    public int insertar(Paciente paciente) {
        try {
            Map<Integer, Object> parametrosPersona = new HashMap<>();
            parametrosPersona.put(1, paciente.getDocIdentidad());
            parametrosPersona.put(2, paciente.getNombre());
            parametrosPersona.put(3, paciente.getPrimerApellido());
            parametrosPersona.put(4, paciente.getSegundoApellido());
            parametrosPersona.put(5, paciente.getTelefono());
            parametrosPersona.put(6, paciente.getDireccion());
            parametrosPersona.put(7, paciente.getEmail());
            parametrosPersona.put(8, paciente.getFechaNacimiento());
            parametrosPersona.put(9, String.valueOf(paciente.getSexo()));
            parametrosPersona.put(10, paciente.getFoto());
            parametrosPersona.put(11, paciente.getUsuario().getIdUsuario());
            parametrosPersona.put(12, paciente.getCiudad().getId());
            parametrosPersona.put(13, paciente.getDepartamento().getId());
            

            DBManager.getInstance().ejecutarProcedimiento("insertar_persona", parametrosPersona, null);

            Map<Integer, Object> parametrosPaciente = new HashMap<>();
            parametrosPaciente.put(1, paciente.getTipoSangre().getId());
            parametrosPaciente.put(2, paciente.getPeso());
            parametrosPaciente.put(3, paciente.getAltura());
            parametrosPaciente.put(4, paciente.getDocIdentidad());
            

            DBManager.getInstance().ejecutarProcedimiento("insertar_paciente", parametrosPaciente, null);

            System.out.println("Se ha realizado el registro del paciente.");
            return 1;

        } catch (Exception e) {
            System.err.println("Error al insertar paciente: " + e.getMessage());
            return 0;
        }
    }



    @Override
    public int modificar(Paciente paciente) {
        try {
            Map<Integer, Object> parametros = new HashMap<>();
            parametros.put(1, paciente.getDocIdentidad());
            parametros.put(2, paciente.getNombre());
            parametros.put(3, paciente.getPrimerApellido());
            parametros.put(4, paciente.getSegundoApellido());
            parametros.put(5, paciente.getTelefono());
            parametros.put(6, paciente.getDireccion());
            parametros.put(7, paciente.getEmail());
            parametros.put(8, paciente.getFechaNacimiento());
            parametros.put(9, String.valueOf(paciente.getSexo()));
            parametros.put(10, paciente.getFoto());
            //parametros.put(11, paciente.getUsuario().getUsername());
            parametros.put(11, paciente.getCiudad().getId());
            parametros.put(12, paciente.getDepartamento().getId());
            parametros.put(13, paciente.getTipoSangre().getId());
            parametros.put(14, paciente.getPeso());
            parametros.put(15, paciente.getAltura());

            int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_paciente", parametros, null);
            System.out.println("Paciente modificado correctamente.");
            return resultado;

        } catch (Exception ex) {
            System.err.println("Error al modificar paciente: " + ex.getMessage());
            return 0;
        }
    }
    
    @Override
    public int eliminar(String codigoPaciente) {
        try {
            Map<Integer, Object> parametros = new HashMap<>();
            parametros.put(1, codigoPaciente);

            int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_paciente", parametros, null);
            System.out.println("Paciente eliminado correctamente.");
            return resultado;
        } catch (Exception ex) {
            System.err.println("Error al eliminar paciente: " + ex.getMessage());
            return 0;
        }
    }



    @Override
    public int eliminar(int codigoComoEntero) {
        String codigoPaciente = String.valueOf(codigoComoEntero);

        try {
            Map<Integer, Object> parametros = new HashMap<>();
            parametros.put(1, codigoPaciente);

            int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_paciente", parametros, null);
            System.out.println("Paciente eliminado correctamente.");
            return resultado;

        } catch (Exception ex) {
            System.err.println("Error al eliminar paciente: " + ex.getMessage());
            return 0;
        }
    }



    @Override
    public ArrayList<Paciente> listarTodos() {
        ArrayList<Paciente> pacientes = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_pacientes", null);
        System.out.println("Lectura de pacientes...");
        try {
            while (rs.next()) {
                if(pacientes == null) pacientes = new ArrayList<>();
                Paciente paciente = new Paciente();
                paciente.setDocIdentidad(rs.getString("docIdentidad"));
                paciente.setNombre(rs.getString("nombres"));
                paciente.setPrimerApellido(rs.getString("primerApellido"));
                paciente.setSegundoApellido(rs.getString("segundoApellido"));
                
                paciente.setTelefono(rs.getString("telefono"));
                paciente.setDireccion(rs.getString("direccion"));
                paciente.setEmail(rs.getString("email"));
                paciente.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                paciente.setSexo(rs.getString("genero").charAt(0));
                paciente.setFoto(rs.getBytes("foto"));
                
                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("ciudad_id"));
                ciudad.setNombre(rs.getString("ciudad_nombre"));
                paciente.setCiudad(ciudad);
                
                Departamento departamento = new Departamento();
                departamento.setId(rs.getInt("departamento_id"));
                departamento.setNombre(rs.getString("departamento_nombre"));
                paciente.setDepartamento(departamento);
                
                paciente.setActivo(rs.getBoolean("activo"));
                
                paciente.setPeso(rs.getDouble("peso"));
                paciente.setAltura(rs.getDouble("altura"));
                
                TipoDeSangre tipoSangre = new TipoDeSangre();
                tipoSangre.setId(rs.getInt("tipoDeSangreID"));
                tipoSangre.setTipo(rs.getString("tipoSangre_nombre"));
                paciente.setTipoSangre(tipoSangre);
                
                /*
                Usuario usuario = new Usuario();
                usuario.setUsername(rs.getString("username"));
                paciente.setUsuario(usuario);
                */


                pacientes.add(paciente);
            }
        } catch (Exception ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return pacientes;
    }

    
    @Override
    public Paciente obtenerPorId(String codigoPaciente) {
        Paciente paciente = null;
        Map<Integer, Object> parametros = new HashMap<>();
        parametros.put(1, codigoPaciente);

        rs = null;

        try {
            rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_paciente_por_id", parametros);
            System.out.println("Buscando paciente por código...");

            if (rs.next()) {
                paciente = new Paciente();
                paciente.setCodigoPaciente(rs.getString("codigoPaciente"));
                paciente.setDocIdentidad(rs.getString("docIdentidad"));
                paciente.setNombre(rs.getString("nombres"));
                paciente.setPrimerApellido(rs.getString("primerApellido"));
                paciente.setSegundoApellido(rs.getString("segundoApellido"));
                paciente.setTelefono(rs.getString("telefono"));
                paciente.setDireccion(rs.getString("direccion"));
                paciente.setEmail(rs.getString("email"));
                paciente.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                paciente.setSexo(rs.getString("genero").charAt(0));
                paciente.setFoto(rs.getBytes("foto"));
                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("ciudad_id"));
                ciudad.setNombre(rs.getString("ciudad_nombre"));
                paciente.setCiudad(ciudad);
                
                Departamento departamento = new Departamento();
                departamento.setId(rs.getInt("departamento_id"));
                departamento.setNombre(rs.getString("departamento_nombre"));
                paciente.setDepartamento(departamento);
                
                paciente.setActivo(rs.getBoolean("activo"));
                
                paciente.setPeso(rs.getDouble("peso"));
                paciente.setAltura(rs.getDouble("altura"));
                
                TipoDeSangre tipoSangre = new TipoDeSangre();
                tipoSangre.setId(rs.getInt("tipoDeSangreID"));
                tipoSangre.setTipo(rs.getString("tipoSangre_nombre"));
                paciente.setTipoSangre(tipoSangre);
            }

            rs.close();
        } catch (Exception ex) {
            System.err.println("ERROR al obtener paciente: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return paciente;
    }

    @Override
    public Paciente obtenerPacienteXUser(int idUsuario) {
        Paciente paciente = null;
        Map<Integer, Object> parametros = new HashMap<>();
        parametros.put(1, idUsuario);

        try {
            rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtenerDatosPacientePorUsuario", parametros);
            System.out.println("Buscando paciente por user...");

            if (rs.next()) {
                paciente = new Paciente();

                // Datos de Paciente
                paciente.setCodigoPaciente(rs.getString("codigoPaciente"));
                paciente.setPeso(rs.getDouble("peso"));
                paciente.setAltura(rs.getDouble("altura"));
                paciente.setActivo(rs.getBoolean("pacienteActivo"));

                // Datos de Persona
                paciente.setNombre(rs.getString("nombres"));
                paciente.setPrimerApellido(rs.getString("primerApellido"));
                paciente.setSegundoApellido(rs.getString("segundoApellido"));
                paciente.setEmail(rs.getString("email"));
                paciente.setTelefono(rs.getString("telefono"));
                paciente.setDireccion(rs.getString("direccion"));
                paciente.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                paciente.setSexo(rs.getString("genero").charAt(0));
                paciente.setFoto(rs.getBytes("foto"));

                // Relaciones si necesitas
                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("ciudad_id"));
                paciente.setCiudad(ciudad);

                Departamento departamento = new Departamento();
                departamento.setId(rs.getInt("departamento_id"));
                paciente.setDepartamento(departamento);

                TipoDeSangre tipo = new TipoDeSangre();
                tipo.setId(rs.getInt("tipoDeSangreID"));
                paciente.setTipoSangre(tipo);
            }

        } catch (Exception e) {
            System.err.println("Error al obtener datos del paciente: " + e.getMessage());
        }

        return paciente;
    }

}
