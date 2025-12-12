package pe.edu.pucp.empresa.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.empresa.dao.DepartamentoDAO;
import pe.edu.pucp.empresa.model.Departamento;

public class DepartamentoMySQL implements DepartamentoDAO{
    private ResultSet rs;
    
    @Override
    public int insertar(Departamento departamento) {
        
        Map<Integer,Object> parametrosSalida = new HashMap<>();
        Map<Integer,Object> parametrosEntrada = new HashMap<>();
        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, departamento.getId());
        parametrosEntrada.put(3, departamento.getNombre());
        parametrosEntrada.put(4, departamento.isActivo());
        DBManager.getInstance().ejecutarProcedimiento("insertar_departamento", parametrosEntrada, parametrosSalida);
        departamento.setId((int) parametrosSalida.get(1));
        System.out.println("Se ha realizado el registro de la cita");
        return departamento.getId();
    }
    
    @Override
    public int modificar(Departamento departamento) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, departamento.getId());
        parametrosEntrada.put(2, departamento.getNombre());
        parametrosEntrada.put(3, departamento.isActivo());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_departamento", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion de la departamento");
        return resultado;
    }

    @Override
    public int eliminar(int idDepartamento) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idDepartamento); 
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_departamento", parametrosEntrada, null);
        System.out.println("Se ha realizado la eliminacion de la departamento");
        return resultado;   
    }
    
    @Override
    public ArrayList<Departamento> listarTodos() {
        ArrayList<Departamento> departamentos = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_departamentos", null);
        System.out.println("Lectura de departamentos...");
        try {
            while (rs.next()) {
                if(departamentos == null) departamentos = new ArrayList<>();
                Departamento departamento = new Departamento();
                
                departamento.setId(rs.getInt("id"));
                departamento.setNombre(rs.getString("nombre"));
                departamento.setActivo(true);
                departamentos.add(departamento);
            }
        }catch(SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return departamentos;
    }

    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
