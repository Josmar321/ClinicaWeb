package pe.edu.pucp.empresa.dao;

import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.empresa.model.Local;

public interface LocalDAO extends ICrud<Local>{
    Local obtenerLocalPorId(int idLocal);
}
