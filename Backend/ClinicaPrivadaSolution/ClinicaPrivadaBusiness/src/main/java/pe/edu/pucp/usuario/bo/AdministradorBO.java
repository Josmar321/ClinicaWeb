package pe.edu.pucp.usuario.bo;

import pe.edu.pucp.usuario.dao.AdministradorDAO;
import pe.edu.pucp.usuario.mysql.AdministradorMySQL;
import pe.edu.pucp.usuario.model.Administrador;
import java.util.ArrayList;

public class AdministradorBO {
    private AdministradorDAO daoAdministrador = new AdministradorMySQL();

    public int insertar(Administrador admin) {
        return daoAdministrador.insertar(admin);
    }

    public int modificar(Administrador admin) {
        return daoAdministrador.modificar(admin);
    }

    public int eliminar(String codigoAdmin) {
        return daoAdministrador.eliminar(codigoAdmin);
    }

    public ArrayList<Administrador> listarTodos() {
        return daoAdministrador.listarTodos();
    }

    public Administrador obtenerPorId(String codigoAdmin) {
        return daoAdministrador.obtenerPorId(codigoAdmin);
    }
}
