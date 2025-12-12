package pe.edu.pucp.empresa.bo;

import java.util.ArrayList;

import pe.edu.pucp.empresa.dao.LocalDAO;
import pe.edu.pucp.empresa.model.Local;
import pe.edu.pucp.empresa.mysql.LocalMySQL;

public class LocalBO {
    
    private LocalDAO daoLocal;

    public LocalBO() {
        daoLocal = new LocalMySQL();
    }

    public Local obtenerLocalPorId(int idLocal) {
        return daoLocal.obtenerLocalPorId(idLocal);
    }

    public int insertar(Local local) {
        return daoLocal.insertar(local);
    }

    public int modificar(Local local) {
        return daoLocal.modificar(local);
    }

    public int eliminar(int idLocal) {
        return daoLocal.eliminar(idLocal);
    }

    public ArrayList<Local> listarTodos() {
        return daoLocal.listarTodos();
    }
}

