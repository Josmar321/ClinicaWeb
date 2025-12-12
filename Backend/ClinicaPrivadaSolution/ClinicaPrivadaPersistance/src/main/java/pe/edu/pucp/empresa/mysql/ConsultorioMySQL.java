package pe.edu.pucp.empresa.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.empresa.dao.ConsultorioDAO;
import pe.edu.pucp.empresa.model.Consultorio;
import pe.edu.pucp.empresa.model.Local;

public class ConsultorioMySQL implements ConsultorioDAO {

    private ResultSet rs;

    @Override
        public int insertar(Consultorio consultorio) {
            Map<Integer, Object> parametrosSalida = new HashMap<>();
            Map<Integer, Object> parametrosEntrada = new HashMap<>();

            parametrosSalida.put(1, Types.INTEGER); // _idConsultorio
            parametrosEntrada.put(2, consultorio.getNumConsultorio());
            parametrosEntrada.put(3, consultorio.getPiso());
            parametrosEntrada.put(4, consultorio.getLocal().getIdLocal()); // suponiendo que está relacionado con Local
            parametrosEntrada.put(5, consultorio.isActivo());

            DBManager.getInstance().ejecutarProcedimiento("insertar_consultorio", parametrosEntrada, parametrosSalida);
            consultorio.setIdConsultorio((int) parametrosSalida.get(1));

            System.out.println("Se ha insertado el consultorio correctamente.");
            return consultorio.getIdConsultorio();
        }

    @Override
    public int modificar(Consultorio consultorio) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        parametrosEntrada.put(1, consultorio.getIdConsultorio());
        parametrosEntrada.put(2, consultorio.getNumConsultorio());
        parametrosEntrada.put(3, consultorio.getPiso());
        parametrosEntrada.put(4, consultorio.getMedico().getCodigoMedico());
        parametrosEntrada.put(5, consultorio.isActivo());

        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_consultorio", parametrosEntrada, null);
        System.out.println("Se ha modificado el consultorio correctamente.");
        return resultado;
    }

    @Override
    public int eliminar(int idConsultorio) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idConsultorio);

        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_consultorio", parametrosEntrada, null);
        System.out.println("Se ha eliminado el consultorio correctamente.");
        return resultado;
    }

    @Override
    public ArrayList<Consultorio> listarTodos() {
        ArrayList<Consultorio> consultorios = new ArrayList<>();
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_consultorios", null);
        System.out.println("Lectura de consultorios...");

        try {
            while (rs.next()) {
                Consultorio consultorio = new Consultorio();
                consultorio.setIdConsultorio(rs.getInt("idConsultorio"));
                consultorio.setNumConsultorio(rs.getInt("numConsultorio"));
                consultorio.setPiso(rs.getInt("piso"));
                consultorio.setActivo(rs.getBoolean("activo"));

                // Puedes completar relaciones como Médico y Local si es necesario
                consultorios.add(consultorio);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return consultorios;
    }

    @Override
    public Consultorio obtenerPorId(int idConsultorio) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idConsultorio);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_consultorio_por_id", parametrosEntrada);
        System.out.println("Lectura de consultorio por ID...");

        Consultorio consultorio = null;

        try {
            if (rs.next()) {
                consultorio = new Consultorio();
                consultorio.setIdConsultorio(rs.getInt("idConsultorio"));
                consultorio.setNumConsultorio(rs.getInt("numConsultorio"));
                consultorio.setPiso(rs.getInt("piso"));
                consultorio.setActivo(rs.getBoolean("activo"));

                Local local = new Local();
                local.setIdLocal(rs.getInt("idLocal"));
                consultorio.setLocal(local);
            }

        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return consultorio;
    }

    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public ArrayList<Consultorio> listarPorIdLocal(int idLocal) {
        ArrayList<Consultorio> consultorios = new ArrayList<>();
        Map<Integer, Object> parametros = new HashMap<>();
        parametros.put(1, idLocal);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_consultorios_por_local", parametros);

        try {
            while (rs.next()) {
                Consultorio consultorio = new Consultorio();
                consultorio.setIdConsultorio(rs.getInt("idConsultorio"));
                consultorio.setNumConsultorio(rs.getInt("numConsultorio"));
                consultorio.setPiso(rs.getInt("piso"));
                consultorio.setActivo(rs.getBoolean("activo"));

                // Asocia el local al consultorio
                Local local = new Local();
                local.setIdLocal(idLocal);
                consultorio.setLocal(local);

                consultorios.add(consultorio);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return consultorios;
    }

    @Override
    public ArrayList<Consultorio> listarPorIdLocalYMedico(int idLocal, String codigoMedico) {
        ArrayList<Consultorio> consultorios = new ArrayList<>();
        Map<Integer, Object> parametros = new HashMap<>();
        parametros.put(1, idLocal);
        parametros.put(2, codigoMedico);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_consultorios_por_local_y_medico", parametros);

        try {
            while (rs.next()) {
                Consultorio consultorio = new Consultorio();
                consultorio.setIdConsultorio(rs.getInt("idConsultorio"));
                consultorio.setNumConsultorio(rs.getInt("numConsultorio"));
                consultorio.setPiso(rs.getInt("piso"));
                consultorio.setActivo(rs.getBoolean("activo"));

                // Asocia el local
                Local local = new Local();
                local.setIdLocal(idLocal);
                consultorio.setLocal(local);

                consultorios.add(consultorio);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return consultorios;
    }

}
