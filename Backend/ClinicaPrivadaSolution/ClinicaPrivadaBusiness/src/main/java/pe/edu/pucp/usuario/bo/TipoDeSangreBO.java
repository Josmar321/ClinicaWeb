
package pe.edu.pucp.usuario.bo;

import java.util.ArrayList;
import pe.edu.pucp.usuario.dao.TipoSangreDAO;
import pe.edu.pucp.usuario.model.TipoDeSangre;
import pe.edu.pucp.usuario.mysql.TipoDeSangreMySQL;

public class TipoDeSangreBO {
    private TipoSangreDAO daoTipoSangre = new TipoDeSangreMySQL();
    public int insertar(){
        return 0;
    }
    
    public ArrayList<TipoDeSangre> listarTodos() {
        return daoTipoSangre.listarTodos();
    }

}
