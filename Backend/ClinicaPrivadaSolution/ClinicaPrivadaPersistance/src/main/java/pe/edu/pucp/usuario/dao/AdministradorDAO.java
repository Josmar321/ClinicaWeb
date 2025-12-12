package pe.edu.pucp.usuario.dao;

import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.usuario.model.Administrador;

public interface AdministradorDAO extends ICrud<Administrador>{
    Administrador obtenerPorId(String codigoAdministrador);
}
