package pe.edu.pucp.cita.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Date;
import pe.edu.pucp.cita.dao.HistorialClinicoDAO;
import pe.edu.pucp.cita.model.CitaMedica;
import pe.edu.pucp.cita.model.EstadoCita;
import pe.edu.pucp.cita.model.HistorialClinico;
import pe.edu.pucp.cita.model.Modalidad;
import pe.edu.pucp.config.DBManager;

public class HistorialClinicoMySQL implements HistorialClinicoDAO{
    private ResultSet rs;
    
    @Override
    
    public int insertar(HistorialClinico historialClinico) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        Map<Integer, Object> parametrosSalida = new HashMap<>();
        
        parametrosEntrada.put(1, historialClinico.getFechaCreacion());
        parametrosEntrada.put(2, historialClinico.getObsGenerales());
        parametrosEntrada.put(3, historialClinico.getPaciente().getCodigoPaciente());
        parametrosEntrada.put(4, historialClinico.getCitasMedicas().get(0).getIdCita());

        DBManager.getInstance().ejecutarProcedimiento("insertar_historial_clinico", parametrosEntrada, parametrosSalida);
        
        historialClinico.setIdHistorial((int) parametrosSalida.get(1));
        
        System.out.println("Se ha registrado el historial clínico correctamente.");
        
        return historialClinico.getIdHistorial();
    }
    
    @Override
    public int modificar(HistorialClinico historial) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, historial.getIdHistorial());
        parametrosEntrada.put(2, historial.getObsGenerales());

        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_historial_clinico", parametrosEntrada, null);

        System.out.println("Se ha actualizado el historial clínico correctamente.");

        return resultado;
    }
    
    @Override
    public int eliminar(int idHistorial) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idHistorial);
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_historial_clinico", parametrosEntrada, null);
        System.out.println("Se ha realizado la eliminacion del historial");
        return resultado;
    }
    
    @Override
    public ArrayList<HistorialClinico> listarTodos() {
        return null;
    }
    
    @Override
     public HistorialClinico obtenerHistorialConCitas(String codigoPaciente) {
        HistorialClinico historial = null;
        ArrayList<CitaMedica> citasMedicas = new ArrayList<>();

        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, codigoPaciente);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_historial_paciente_con_citas", parametrosEntrada);

        System.out.println("Lectura del historial clínico y citas médicas...");

        try {
            if (rs.next()) {
                historial = new HistorialClinico();
                historial.setIdHistorial(rs.getInt("idHistorial"));
                historial.setFechaCreacion(rs.getDate("fechaCreacion"));  
                historial.setObsGenerales(rs.getString("obsGenerales"));
                historial.setActivo(true);
            }
            
            while (rs.next()) {
                CitaMedica cita = new CitaMedica();
                cita.setIdCita(rs.getInt("idCitaMedica"));
                cita.setFecha(rs.getDate("fecha"));
                cita.setHora(rs.getDate("hora"));
                cita.setPrecio(rs.getDouble("precio"));
                cita.setEstado(EstadoCita.valueOf(rs.getString("estado")));
                cita.setModalidad(Modalidad.valueOf(rs.getString("modalidad")));
                
                citasMedicas.add(cita);
            }

            if (historial != null) {
                historial.setCitasMedicas(citasMedicas);
            }

        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return historial;
    }

    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
