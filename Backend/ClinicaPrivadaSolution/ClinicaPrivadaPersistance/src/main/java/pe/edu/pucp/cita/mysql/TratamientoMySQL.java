package pe.edu.pucp.cita.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.cita.dao.TratamientoDAO;
import pe.edu.pucp.cita.model.Tratamiento;
import pe.edu.pucp.config.DBManager;

public class TratamientoMySQL implements TratamientoDAO {

    private ResultSet rs;

    @Override
    public int insertar(Tratamiento tratamiento) {
        int resultado = 0;
        try {
            // Ya no se usan parámetros de salida, solo de entrada
            Map<Integer, Object> parametrosEntrada = new HashMap<>();

            // Parámetros para el procedimiento almacenado corregido
            parametrosEntrada.put(1, tratamiento.getCitaMedica().getIdCita());
            parametrosEntrada.put(2, tratamiento.getDescripcionTratamiento());

            resultado = DBManager.getInstance().ejecutarProcedimiento("insertar_tratamiento", parametrosEntrada, null);

        } catch (Exception ex) {
            System.out.println("ERROR en TratamientoMySQL -> insertar: " + ex.getMessage());
        }
        return resultado;
    }

    @Override
    public int modificar(Tratamiento tratamiento) {
        int resultado = 0;
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            
            // El ID del tratamiento es el mismo que el de la cita
            parametrosEntrada.put(1, tratamiento.getIdTratamiento());
            parametrosEntrada.put(2, tratamiento.getDescripcionTratamiento());
            
            resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_tratamiento", parametrosEntrada, null);

        } catch (Exception ex) {
            System.out.println("ERROR en TratamientoMySQL -> modificar: " + ex.getMessage());
        }
        return resultado;
    }

    @Override
    public int eliminar(int idTratamiento) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idTratamiento);
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_tratamiento", parametrosEntrada, null);
        System.out.println("El tratamiento con ID " + idTratamiento + " ha sido eliminado correctamente.");
        return resultado;
    }

    @Override
    public ArrayList<Tratamiento> listarTodos() {
        ArrayList<Tratamiento> tratamientos = new ArrayList<>();
        
        // CORRECCIÓN: Se usa el nombre de procedimiento lógico. Verifica que coincida con el tuyo.
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_tratamientos", null);
        
        try {
            while (rs.next()) {
                Tratamiento tratamiento = new Tratamiento();
                tratamiento.setIdTratamiento(rs.getInt("idTratamiento"));
                tratamiento.setDescripcionTratamiento(rs.getString("descripcionTratamiento"));
                tratamiento.setActivo(rs.getBoolean("activo"));
                tratamientos.add(tratamiento);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return tratamientos;
    }

    @Override
    public Tratamiento obtenerPorId(int idCita) { // El ID que se pasa es el de la Cita
        Tratamiento tratamiento = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idCita);


        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_tratamiento_por_id", parametrosEntrada);
        
        try {
            if (rs.next()) {
                tratamiento = new Tratamiento();
                tratamiento.setIdTratamiento(rs.getInt("idTratamiento"));
                tratamiento.setDescripcionTratamiento(rs.getString("descripcionTratamiento"));
                tratamiento.setActivo(rs.getBoolean("activo"));
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return tratamiento;
    }

    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
