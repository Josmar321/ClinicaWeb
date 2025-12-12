package pe.edu.pucp.empresa.bo;

import pe.edu.pucp.empresa.dao.EmpresaDAO;
import pe.edu.pucp.empresa.model.Empresa;
import pe.edu.pucp.empresa.mysql.EmpresaMySQL;

public class EmpresaBO {
    private final EmpresaDAO daoEmpresa;

    public EmpresaBO() {
        daoEmpresa = new EmpresaMySQL(); 
    }

    public int insertar(Empresa empresa) {
        return daoEmpresa.insertar(empresa);
    }

    public int modificar(Empresa empresa) {
        return daoEmpresa.modificar(empresa);
    }
    
    public int eliminar(int  id) {
        return daoEmpresa.eliminar(id);
    }
    
    public Empresa listarEmpresa(){
        return daoEmpresa.listarEmpresa();
    }
}
