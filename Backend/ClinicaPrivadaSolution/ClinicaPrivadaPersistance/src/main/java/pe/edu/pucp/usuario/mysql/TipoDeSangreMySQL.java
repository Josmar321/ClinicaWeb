
package pe.edu.pucp.usuario.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.usuario.dao.TipoSangreDAO;
import pe.edu.pucp.usuario.model.TipoDeSangre;


public class TipoDeSangreMySQL implements TipoSangreDAO{
    private ResultSet rs;
    @Override
    public int insertar(TipoDeSangre modelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int modificar(TipoDeSangre modelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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
    public ArrayList<TipoDeSangre> listarTodos() {
            ArrayList<TipoDeSangre> tiposSangre = null;
    rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_tipos_sangre", null);
    System.out.println("Lectura de tipos de sangre...");
    try {
        while (rs.next()) {
            if (tiposSangre == null) tiposSangre = new ArrayList<>();
            TipoDeSangre tipoSangre = new TipoDeSangre();

            tipoSangre.setId(rs.getInt("id"));
            tipoSangre.setTipo(rs.getString("tipo"));
            tipoSangre.setActivo(true); // o rs.getBoolean("activo") si lo obtienes de la BD

            tiposSangre.add(tipoSangre);
        }
    } catch (SQLException ex) {
        System.out.println("ERROR: " + ex.getMessage());
    } finally {
        DBManager.getInstance().cerrarConexion();
    }
    return tiposSangre;
    }
    
}
