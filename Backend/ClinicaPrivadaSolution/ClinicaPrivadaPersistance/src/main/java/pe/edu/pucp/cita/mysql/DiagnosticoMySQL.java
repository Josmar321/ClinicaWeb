package pe.edu.pucp.cita.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.cita.dao.DiagnosticoDAO;
import pe.edu.pucp.cita.model.Diagnostico;
import pe.edu.pucp.config.DBManager;

public class DiagnosticoMySQL implements DiagnosticoDAO{
    
    private ResultSet rs;
    @Override
    public int insertar(Diagnostico diagnostico) {
        int resultado = 0;
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();


            parametrosEntrada.put(1, diagnostico.getCitaMedica().getIdCita());
            parametrosEntrada.put(2, diagnostico.getDescripcionDiagnostico());
            parametrosEntrada.put(3, diagnostico.getFecha());
            
            resultado = DBManager.getInstance().ejecutarProcedimiento("insertar_diagnostico", parametrosEntrada, null);

        } catch (Exception ex) {
            System.out.println("ERROR en DiagnosticoMySQL -> insertar: " + ex.getMessage());
        }
        return resultado;
    }

    @Override
    public int modificar(Diagnostico diagnostico) {
        int resultado = 0;
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            
            // El ID del diagnóstico es el mismo que el de la cita
            parametrosEntrada.put(1, diagnostico.getIdDiagnostico());
            parametrosEntrada.put(2, diagnostico.getDescripcionDiagnostico());
            parametrosEntrada.put(3, diagnostico.getFecha());
            
            resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_diagnostico", parametrosEntrada, null);

        } catch (Exception ex) {
            System.out.println("ERROR en DiagnosticoMySQL -> modificar: " + ex.getMessage());
        }
        return resultado;
    }
    
    @Override
    public int eliminar(int idDiagnostico) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, idDiagnostico);
        
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_diagnostico", parametrosEntrada, null);
        
        System.out.println("El diagnóstico con ID " + idDiagnostico + " ha sido eliminado correctamente.");
        
        return resultado;  
    }

    public ArrayList<Diagnostico> listarTodos() {
        ArrayList<Diagnostico> diagnosticos = new ArrayList<>();
        
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_diagnosticos", null);
        System.out.println("Lectura de diagnósticos...");

        try {
            while (rs.next()) {
                Diagnostico diagnostico = new Diagnostico();
                
                diagnostico.setIdDiagnostico(rs.getInt("idDiagnostico"));
                diagnostico.setDescripcionDiagnostico(rs.getString("descripcionDiagnostico"));
                diagnostico.setFecha(rs.getDate("fecha"));
                diagnostico.setActivo(true);
                
                diagnosticos.add(diagnostico);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        
        return diagnosticos;
    }
    
    @Override
    public Diagnostico obtenerPorId(int idCita) {
        Diagnostico diagnostico = null;
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idCita);
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_diagnostico_por_id", parametrosEntrada);
        try {
            if (rs.next()) {
                diagnostico = new Diagnostico();
                // CORRECCIÓN: Se usa la columna correcta 'idDiagnostico'
                diagnostico.setIdDiagnostico(rs.getInt("idDiagnostico"));
                diagnostico.setDescripcionDiagnostico(rs.getString("descripcionDiagnostico"));
                diagnostico.setFecha(rs.getDate("fecha"));
                diagnostico.setActivo(rs.getBoolean("activo"));
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return diagnostico;
    }
    
    @Override
    public ArrayList<Diagnostico> obtenerDiagnosticosPorFecha(Date fechaInicio, Date fechaFin) {
        ArrayList<Diagnostico> diagnosticos = new ArrayList<>();

        // Crear el mapa para los parámetros de entrada
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, fechaInicio);
        parametrosEntrada.put(2, fechaFin);
        
        // Ejecutar el procedimiento para obtener diagnósticos por fecha
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("reporte_diagnosticos_por_fecha", parametrosEntrada);

        System.out.println("Lectura de diagnósticos entre las fechas " + fechaInicio + " y " + fechaFin);

        try {
            while (rs.next()) {
                Diagnostico diagnostico = new Diagnostico();
                diagnostico.setIdDiagnostico(rs.getInt("idDiagnostico"));
                diagnostico.setDescripcionDiagnostico(rs.getString("descripcionDiagnostico"));
                diagnostico.setFecha(rs.getDate("fecha"));
                diagnostico.setActivo(rs.getBoolean("activo"));

                diagnosticos.add(diagnostico);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return diagnosticos;
    }

    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
