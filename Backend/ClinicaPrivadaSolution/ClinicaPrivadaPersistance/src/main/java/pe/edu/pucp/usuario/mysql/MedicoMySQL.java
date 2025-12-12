package pe.edu.pucp.usuario.mysql;

import java.sql.ResultSet;
import java.util.ArrayList;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.usuario.dao.MedicoDAO;
import pe.edu.pucp.usuario.model.Medico;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.empresa.model.Ciudad;
import pe.edu.pucp.empresa.model.Departamento;
import pe.edu.pucp.empresa.model.Especialidad;
import pe.edu.pucp.usuario.dao.PersonaDAO;
import pe.edu.pucp.usuario.model.Usuario;

public class MedicoMySQL implements MedicoDAO{
    private ResultSet rs;

    @Override
    public int insertar(Medico medico) {
        PersonaDAO daoPersona = new PersonaMySQL();
        int medicoExiste = daoPersona.obtenerPorDocIdentidad(medico.getDocIdentidad());

        if (medicoExiste == 0) {
            Map<Integer, Object> parametrosPersona = new HashMap<>();
            parametrosPersona.put(1, medico.getDocIdentidad());
            parametrosPersona.put(2, medico.getNombre());
            parametrosPersona.put(3, medico.getPrimerApellido());
            parametrosPersona.put(4, medico.getSegundoApellido());
            parametrosPersona.put(5, medico.getTelefono());
            parametrosPersona.put(6, medico.getDireccion());
            parametrosPersona.put(7, medico.getEmail());
            parametrosPersona.put(8, medico.getFechaNacimiento());
            parametrosPersona.put(9, String.valueOf(medico.getSexo()));
            parametrosPersona.put(10, medico.getFoto());
            parametrosPersona.put(11, medico.getUsuario().getIdUsuario());
            parametrosPersona.put(12, medico.getCiudad().getId());
            parametrosPersona.put(13, medico.getDepartamento().getId());

            DBManager.getInstance().ejecutarProcedimiento("insertar_persona", parametrosPersona, null);
        }

        try {
            Map<Integer, Object> parametrosMedico = new HashMap<>();
            parametrosMedico.put(1, medico.getDocIdentidad());
            parametrosMedico.put(2, medico.getEspecialidad().getIdEspecialidad());
            parametrosMedico.put(3, medico.getNumeroColegiatura());

            DBManager.getInstance().ejecutarProcedimiento("insertar_medico", parametrosMedico, null);

            System.out.println("medico insertado correctamente");
            return 1;

        } catch (Exception e) {
            System.err.println("error al insertar medico: " + e.getMessage());
            return 0;
        }
    }

    @Override
    public int modificar(Medico medico) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, medico.getDocIdentidad());
        parametrosEntrada.put(2, medico.getNombre());
        parametrosEntrada.put(3, medico.getPrimerApellido());
        parametrosEntrada.put(4, medico.getSegundoApellido());
        parametrosEntrada.put(5, medico.getTelefono());
        parametrosEntrada.put(6, medico.getDireccion());
        parametrosEntrada.put(7, medico.getEmail());
        parametrosEntrada.put(8, medico.getFechaNacimiento());
        parametrosEntrada.put(9, String.valueOf(medico.getSexo()));
        parametrosEntrada.put(10, medico.getFoto());
        parametrosEntrada.put(11, medico.getCiudad().getId());
        parametrosEntrada.put(12, medico.getDepartamento().getId());
        parametrosEntrada.put(13, medico.getNumeroColegiatura());
        parametrosEntrada.put(14, medico.getEspecialidad().getIdEspecialidad());
        
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_medico", parametrosEntrada, null);
        System.out.println("medico modificado correctamente.");
        return resultado;
    }
     @Override
    public ArrayList<Medico> listarTodos() {
        ArrayList<Medico> medicos = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_medicos", null);
        System.out.println("Lectura de medicos...");
        try {
            while (rs.next()) {
                if(medicos == null) medicos = new ArrayList<>();
                Medico medico = new Medico();
                medico.setDocIdentidad(rs.getString("docIdentidad"));
                medico.setCodigoMedico(rs.getString("docIdentidad"));
                medico.setNombre(rs.getString("nombres"));
                medico.setPrimerApellido(rs.getString("primerApellido"));
                medico.setSegundoApellido(rs.getString("segundoApellido"));
                medico.setTelefono(rs.getString("telefono"));
                medico.setDireccion(rs.getString("direccion"));
                medico.setEmail(rs.getString("email"));
                medico.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                medico.setSexo(rs.getString("genero").charAt(0));
                medico.setFoto(rs.getBytes("foto"));
                medico.setNumeroColegiatura(rs.getString("numeroColegiatura"));
                
                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("ciudad_id"));
                ciudad.setNombre(rs.getString("ciudad_nombre"));
                medico.setCiudad(ciudad);
                
                Departamento departamento = new Departamento();
                departamento.setId(rs.getInt("departamento_id"));
                departamento.setNombre(rs.getString("departamento_nombre"));
                medico.setDepartamento(departamento);
                
                medico.setActivo(rs.getBoolean("activo"));
                
                Especialidad especialidad = new Especialidad();
                especialidad.setIdEspecialidad(rs.getInt("idEspecialidad"));
                especialidad.setNombre(rs.getString("nombreEspecialidad"));
                medico.setEspecialidad(especialidad);
                
                /*
                Usuario usuario = new Usuario();
                usuario.setUsername(rs.getString("username"));
                medico.setUsuario(usuario);
                */

                //admin.setCodigoAdministrador(rs.getString("docIdentidad")); 

                medicos.add(medico);
            }
        } catch (Exception ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return medicos;
    }

    @Override
    public int eliminar(String codigoMedico) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, codigoMedico);

        try {
            int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_medico", parametrosEntrada, null);
            if (resultado > 0) {
                System.out.println("Médico eliminado correctamente.");
                return 1;
            } else {
                System.out.println("No se encontró un médico con el código indicado.");
                return 0;
            }
        } catch (Exception ex) {
            System.err.println("Error al eliminar médico: " + ex.getMessage());
            return 0;
        }
    }

    @Override
    public int eliminar(int codigoMedicoNumerico) {
        return eliminar(String.valueOf(codigoMedicoNumerico));
    }

    @Override
    public Medico obtenerPorId(String codigoMedico) {
        Medico medico = null;
        Map<Integer, Object> parametros = new HashMap<>();
        parametros.put(1, codigoMedico);

        rs = null;

        try {
            rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_medico_por_id", parametros);
            System.out.println("Buscando médico por código...");

            if (rs.next()) {
                medico = new Medico();
                medico.setDocIdentidad(rs.getString("docIdentidad"));
                medico.setNombre(rs.getString("nombres"));
                medico.setPrimerApellido(rs.getString("primerApellido"));
                medico.setSegundoApellido(rs.getString("segundoApellido"));
                medico.setTelefono(rs.getString("telefono"));
                medico.setDireccion(rs.getString("direccion"));
                medico.setEmail(rs.getString("email"));
                medico.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                medico.setSexo(rs.getString("genero").charAt(0));
                medico.setFoto(rs.getBytes("foto"));
                
                medico.setCodigoMedico(rs.getString("codigoMedico"));
                medico.setNumeroColegiatura(rs.getString("numeroColegiatura"));
                medico.setActivo(rs.getBoolean("activo"));
                
                Especialidad especialidad = new Especialidad();
                especialidad.setIdEspecialidad(rs.getInt("idEspecialidad"));
                especialidad.setNombre(rs.getString("nombreEspecialidad"));
                medico.setEspecialidad(especialidad);
                
                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("ciudad_id"));
                ciudad.setNombre(rs.getString("ciudad_nombre"));
                medico.setCiudad(ciudad);
                
                Departamento departamento = new Departamento();
                departamento.setId(rs.getInt("departamento_id"));
                departamento.setNombre(rs.getString("departamento_nombre"));
                medico.setDepartamento(departamento);
                
                /*
                Usuario usuario = new Usuario();
                usuario.setUsername(rs.getString("username"));
                medico.setUsuario(usuario);
                */
            }

            rs.close();
        } catch (Exception ex) {
            System.err.println("ERROR al obtener médico: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return medico;
    }

    

    @Override
    public Medico obtenerMedicoXUser(int idUser) {
         Medico medico = null;
            Map<Integer, Object> parametros = new HashMap<>();
            parametros.put(1, idUser);
        try {
            rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtenerDatosMedicoPorUsuario", parametros);
            System.out.println("Buscando médico por user...");

            if (rs.next()) {
                medico = new Medico();

                // Asignar valores al objeto Medico desde el ResultSet
                medico.setCodigoMedico(rs.getString("codigoMedico"));
                medico.setNumeroColegiatura(rs.getString("numeroColegiatura"));
              
                medico.setActivo(rs.getBoolean("medicoActivo"));

                // Suponiendo que tu clase Medico hereda o incluye datos de Persona
                medico.setNombre(rs.getString("nombres"));
                medico.setPrimerApellido(rs.getString("primerApellido"));
                medico.setSegundoApellido(rs.getString("segundoApellido"));
                medico.setEmail(rs.getString("email"));
                medico.setTelefono(rs.getString("telefono"));
                medico.setDireccion(rs.getString("direccion"));
                medico.setFechaNacimiento(rs.getDate("fechaNacimiento"));
                medico.setSexo(rs.getString("genero").charAt(0));
                medico.setFoto(rs.getBytes("foto"));
                Especialidad esp = new Especialidad();
                esp.setIdEspecialidad(rs.getInt("idEspecialidad"));
                medico.setEspecialidad(esp);
            }

        } catch (Exception e) {
            System.err.println("Error al obtener datos del médico: " + e.getMessage());
        }

        return medico;
    }
    
    @Override
    public ArrayList<Medico> obtenerMedicosParaCitaMedica(int idLocal, int idEspecialidad, String dia) {
        ArrayList<Medico> medicos = new ArrayList<>();
        Map<Integer, Object> parametros = new HashMap<>();
        parametros.put(1, idLocal);
        parametros.put(2, idEspecialidad);
        parametros.put(3, dia);

        try {
            ResultSet rs = DBManager.getInstance()
                    .ejecutarProcedimientoLectura("obtener_medicos_para_cita_medica", parametros);

            while (rs.next()) {
                Medico medico = new Medico();
                medico.setCodigoMedico(rs.getString("codigoMedico"));
                medico.setNumeroColegiatura(rs.getString("numeroColegiatura"));
                medico.setActivo(rs.getBoolean("activo"));

                medico.setNombre(rs.getString("nombres"));
                medico.setPrimerApellido(rs.getString("primerApellido"));
                medico.setSegundoApellido(rs.getString("segundoApellido"));

                Especialidad esp = new Especialidad();
                esp.setIdEspecialidad(rs.getInt("idEspecialidad"));
                esp.setNombre(rs.getString("nombreEspecialidad"));
                medico.setEspecialidad(esp);

                medicos.add(medico);
            }

            rs.close();
        } catch (Exception ex) {
            System.err.println("Error al obtener médicos para cita médica: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return medicos;
    }


}
