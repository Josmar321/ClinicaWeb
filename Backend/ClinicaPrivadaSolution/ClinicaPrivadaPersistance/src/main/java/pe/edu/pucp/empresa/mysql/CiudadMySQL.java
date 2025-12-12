package pe.edu.pucp.empresa.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.empresa.dao.CiudadDAO;
import pe.edu.pucp.empresa.model.Ciudad;
import pe.edu.pucp.empresa.model.Departamento;

public class CiudadMySQL implements CiudadDAO {

    private ResultSet rs;

    @Override
    public ArrayList<Ciudad> listarTodos() {
        ArrayList<Ciudad> ciudades = new ArrayList<>();
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_ciudades", null);
        System.out.println("Lectura de ciudades...");

        try {
            while (rs.next()) {
                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("idCiudad"));
                ciudad.setNombre(rs.getString("nombreCiudad"));
                ciudad.setActivo(rs.getBoolean("activo"));

                Departamento dpto = new Departamento();
                dpto.setId(rs.getInt("departamento_id"));
                dpto.setNombre(rs.getString("nombreDepartamento"));

                ciudad.setDepartamento(dpto);

                ciudades.add(ciudad);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return ciudades;
    }

    @Override
    public Ciudad obtenerPorId(int idCiudad) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idCiudad);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_ciudad_por_id", parametrosEntrada);
        System.out.println("Lectura de ciudad por ID...");

        Ciudad ciudad = null;

        try {
            if (rs.next()) {
                ciudad = new Ciudad();
                ciudad.setId(rs.getInt("idCiudad"));
                ciudad.setNombre(rs.getString("nombreCiudad"));
                ciudad.setActivo(rs.getBoolean("activo"));

                Departamento dpto = new Departamento();
                dpto.setId(rs.getInt("departamento_id"));
                dpto.setNombre(rs.getString("nombreDepartamento"));

                ciudad.setDepartamento(dpto);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return ciudad;
    }
}
