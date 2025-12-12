package pe.edu.pucp.empresa.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.empresa.dao.EmpresaDAO;
import pe.edu.pucp.empresa.model.Empresa;

public class EmpresaMySQL implements EmpresaDAO{
    
    private ResultSet rs;
    
    @Override
    public int insertar(Empresa empresa) {
        
        Map<Integer,Object> parametrosSalida = new HashMap<>();
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, empresa.getIdEmpresa());
        parametrosEntrada.put(3, empresa.getRazonSocial());
        parametrosEntrada.put(4, empresa.getRuc());
        parametrosEntrada.put(5, empresa.getTelefonoDeContacto());
        parametrosEntrada.put(6, empresa.getLogo());
        parametrosEntrada.put(7, empresa.getLinkInstagram());
        parametrosEntrada.put(8, empresa.getLinkFacebook());
        parametrosEntrada.put(9, empresa.isActivo());
        DBManager.getInstance().ejecutarProcedimiento("insertar_empresa", parametrosEntrada, parametrosSalida);
        empresa.setIdEmpresa((int) parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la empresa");
        return empresa.getIdEmpresa();
    }
    
    @Override
    public int modificar(Empresa empresa) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, empresa.getIdEmpresa());
        parametrosEntrada.put(2, empresa.getTelefonoDeContacto());
        parametrosEntrada.put(3, empresa.getLogo());
        parametrosEntrada.put(4, empresa.getLinkInstagram());
        parametrosEntrada.put(5, empresa.getLinkFacebook());
        parametrosEntrada.put(6, empresa.isActivo());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_empresa", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion de la empresa");
        return resultado;
    }
    
    @Override
    public int eliminar(int idEmpresa) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idEmpresa);
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_empresa", parametrosEntrada, null);
        System.out.println("Se ha realizado la eliminacion de la empresa");
        return resultado;
    }
    
    @Override
    public ArrayList<Empresa> listarTodos() {
        return null;
    }
    
    @Override
    public Empresa listarEmpresa() {
        Empresa empresa = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_empresa", null);

        try {
            if (rs.next()) {
                empresa = new Empresa();
                empresa.setIdEmpresa(rs.getInt("idEmpresa"));
                empresa.setRazonSocial(rs.getString("razonSocial"));
                empresa.setRuc(rs.getString("ruc"));
                empresa.setTelefonoDeContacto(rs.getString("telefonoDeContacto"));
                empresa.setLogo(rs.getBytes("logo"));
                empresa.setLinkInstagram(rs.getString("linkInstagram"));
                empresa.setLinkFacebook(rs.getString("linkFacebook"));
                empresa.setActivo(rs.getBoolean("activo"));
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return empresa;
    }

    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
