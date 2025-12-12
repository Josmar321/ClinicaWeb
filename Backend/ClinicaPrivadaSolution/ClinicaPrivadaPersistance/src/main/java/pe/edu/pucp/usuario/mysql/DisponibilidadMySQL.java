/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.usuario.mysql;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.usuario.dao.DisponibilidadDAO;
import pe.edu.pucp.usuario.model.Dia;
import pe.edu.pucp.usuario.model.Disponibilidad;
import pe.edu.pucp.usuario.model.Medico;
/**
 *
 * @author andre
 */
public class DisponibilidadMySQL implements DisponibilidadDAO{
    private ResultSet rs;
    @Override
    public int insertar(Disponibilidad disponibilidad) {
            Map<Integer, Object> parametrosSalida = new HashMap<>();
            Map<Integer, Object> parametrosEntrada = new HashMap<>();

            parametrosSalida.put(1, Types.INTEGER); // _idConsultorio
            parametrosEntrada.put(2, disponibilidad.getDia().toString());
            SimpleDateFormat sdfHora = new SimpleDateFormat("HH:mm:ss");
            String horaFormateada = sdfHora.format(disponibilidad.getHoraInicio());
            parametrosEntrada.put(3,horaFormateada);
            String horaFinFormateada = sdfHora.format(disponibilidad.getHoraFin());
            parametrosEntrada.put(4, horaFinFormateada);
            parametrosEntrada.put(5,disponibilidad.getMedico().getCodigoMedico());
            parametrosEntrada.put(6, disponibilidad.isActivo() ? 1 : 0);

            DBManager.getInstance().ejecutarProcedimiento("insertar_disponibilidad", parametrosEntrada, parametrosSalida);
            disponibilidad.setIdDisponibilidad((int) parametrosSalida.get(1));

            System.out.println("Se ha insertado la disponibilidad correctamente.");
            return disponibilidad.getIdDisponibilidad();
    }

    @Override
    public int modificar(Disponibilidad disponibilidad) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        
        parametrosEntrada.put(1, disponibilidad.getIdDisponibilidad());
        parametrosEntrada.put(2, disponibilidad.isActivo() ? 1 : 0);
        
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_disponibilidad", parametrosEntrada, null);
        
        System.out.println("Se ha realizado la modificación de la disponibilidad.");
        
        return resultado;
    }

    @Override
    public int eliminar(int idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Disponibilidad> listarTodos() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Disponibilidad> obtenerDisponibilidadXMedico(String codigoMedico) {
        
        System.out.println(codigoMedico);
        Map<Integer, Object> parametros = new HashMap<>();
        parametros.put(1, codigoMedico);

        rs = null;
        ArrayList<Disponibilidad> disponibilidades = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_disponibilidad_por_medico", parametros);
        System.out.println("Lectura de disponibilidades...");
        try {
            while (rs.next()) {
                if(disponibilidades == null) disponibilidades = new ArrayList<>();
                Disponibilidad disponibilidad = new Disponibilidad();
                disponibilidad.setIdDisponibilidad(rs.getInt("idDisponibilidad"));
                Dia dia = Dia.valueOf(rs.getString("dia"));
                disponibilidad.setDia(dia);
                disponibilidad.setHoraInicio(rs.getTime("horaInicio"));
                disponibilidad.setHoraFin(rs.getTime("horaFin"));
                Medico medico = new Medico();
                medico.setCodigoMedico(rs.getString("codigoMedico"));
                disponibilidad.setMedico(medico);
                disponibilidad.setActivo(rs.getBoolean("activo"));
                
                disponibilidades.add(disponibilidad);
            }
        } catch (Exception ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }
        return disponibilidades;
    }
    
    @Override
    public Disponibilidad obtenerPorId(int id) {
        Disponibilidad disponibilidad = null;
        Map<Integer, Object> parametros = new HashMap<>();
        parametros.put(1, id);

        rs = null;

        try {
            rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_disponibilidad_por_id", parametros);
            System.out.println("Buscando médico por código...");

            if (rs.next()) {
                disponibilidad = new Disponibilidad();
                disponibilidad.setIdDisponibilidad(id);
                Dia dia = Dia.valueOf(rs.getString("dia"));
                disponibilidad.setDia(dia);
                disponibilidad.setHoraInicio(rs.getTime("horaInicio"));
                disponibilidad.setHoraFin(rs.getTime("horaFin"));
                Medico medico = new Medico();
                medico.setCodigoMedico(rs.getString("codigoMedico"));
                disponibilidad.setMedico(medico);
                disponibilidad.setActivo(rs.getBoolean("activo"));
            }
            rs.close();
        } catch (Exception ex) {
            System.err.println("ERROR al obtener médico: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return disponibilidad;
    }
    
}
