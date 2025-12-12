package pe.edu.pucp.empresa.dao;

import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.empresa.model.Empresa;

public interface EmpresaDAO extends ICrud<Empresa>{
    public Empresa listarEmpresa();
}
