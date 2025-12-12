package pe.edu.pucp.empresa.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.empresa.dao.EspecialidadDAO;
import pe.edu.pucp.empresa.model.Especialidad;

public class EspecialidadMySQL implements EspecialidadDAO {
    private ResultSet rs;

    @Override

    public int insertar(Especialidad especialidad) {
        
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        Map<Integer, Object> parametrosSalida = new HashMap<>();
        parametrosSalida.put(1, Types.INTEGER);
        
        parametrosEntrada.put(2, especialidad.getNombre());
        parametrosEntrada.put(3, especialidad.isActivo());
        
        DBManager.getInstance().ejecutarProcedimiento("insertar_especialidad", parametrosEntrada, parametrosSalida);
        
        especialidad.setIdEspecialidad((int) parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la especialidad");
        return especialidad.getIdEspecialidad();
    }


    @Override
    public int modificar(Especialidad especialidad) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, especialidad.getIdEspecialidad());
        parametrosEntrada.put(2, especialidad.getNombre());
        parametrosEntrada.put(3, especialidad.isActivo());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_especialidad", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion de la especialidad");
        return resultado;
    }

    @Override
    public int eliminar(int idEspecialidad) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idEspecialidad); 
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_especialidad", parametrosEntrada, null);
        System.out.println("Se ha realizado la eliminacion de la especialidad");
        return resultado;   
    }
    
    @Override
    public ArrayList<Especialidad> listarTodos() {
        ArrayList<Especialidad> especialidades = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_especialidades", null);
        System.out.println("Lectura de especialidades...");
        try {
            while (rs.next()) {
                if(especialidades == null) especialidades = new ArrayList<>();
                Especialidad especialidad = new Especialidad();
                
                especialidad.setIdEspecialidad(rs.getInt("idEspecialidad"));
                especialidad.setNombre(rs.getString("nombre"));
                especialidad.setActivo(rs.getBoolean("activo"));
                especialidades.add(especialidad);
            }
        }catch(SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return especialidades;
    }

    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public ArrayList<Especialidad> listarPorIdLocal(int idLocal) {
        ArrayList<Integer> idsEspecialidades = new ArrayList<>();
        ArrayList<Especialidad> especialidades = new ArrayList<>();

        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idLocal);

        ResultSet rs = DBManager.getInstance()
                                .ejecutarProcedimientoLectura("listar_especialidades_por_local", parametrosEntrada);

        try {
            while (rs.next()) {
                idsEspecialidades.add(rs.getInt("idEspecialidad"));
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar especialidades por local: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion(); // Cerramos solo después de terminar el while
        }

        for (int idEsp : idsEspecialidades) {
            Especialidad esp = obtenerPorId(idEsp);
            if (esp != null && esp.isActivo()) {
                especialidades.add(esp);
            }
        }

        return especialidades;
    }

    
    @Override
    public Especialidad obtenerPorId(int idEspecialidad) {
        Especialidad especialidad = null;

        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            parametrosEntrada.put(1, idEspecialidad);

            ResultSet rs = DBManager.getInstance()
                                    .ejecutarProcedimientoLectura("obtener_especialidad_por_id", parametrosEntrada);

            if (rs.next()) {
                especialidad = new Especialidad();
                especialidad.setIdEspecialidad(rs.getInt("idEspecialidad"));
                especialidad.setNombre(rs.getString("nombre"));
                especialidad.setActivo(rs.getBoolean("activo"));
            }

        } catch (SQLException ex) {
            System.out.println("Error al obtener especialidad por ID: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return especialidad;
    }

  
}
