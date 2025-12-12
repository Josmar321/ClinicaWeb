package pe.edu.pucp.empresa.bo;

import java.util.ArrayList;
import pe.edu.pucp.empresa.dao.DepartamentoDAO;
import pe.edu.pucp.empresa.model.Departamento;
import pe.edu.pucp.empresa.mysql.DepartamentoMySQL;

public class DepartamentoBO {
    private final DepartamentoDAO daoDepartamento;

    public DepartamentoBO() {
        daoDepartamento = new DepartamentoMySQL(); 
    }

    public int insertar(Departamento departamento) {
        return daoDepartamento.insertar(departamento);
    }

    public int modificar(Departamento departamento) {
        return daoDepartamento.modificar(departamento);
    }
    
    public int eliminar(int  id) {
        return daoDepartamento.eliminar(id);
    }
    
    public ArrayList<Departamento> listarTodos() {
        return daoDepartamento.listarTodos();
    }
}
