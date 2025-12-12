package pe.edu.pucp.empresa.bo;

import java.util.ArrayList;

import pe.edu.pucp.empresa.dao.CiudadDAO;
import pe.edu.pucp.empresa.dao.DepartamentoDAO;
import pe.edu.pucp.empresa.model.Ciudad;
import pe.edu.pucp.empresa.model.Departamento;
import pe.edu.pucp.empresa.mysql.CiudadMySQL;
import pe.edu.pucp.empresa.mysql.DepartamentoMySQL;

public class CiudadBO {
    private CiudadDAO daoCiudad;
    private DepartamentoDAO daoDepartamento;

    public CiudadBO() {
        daoCiudad = new CiudadMySQL();
    }

    public Ciudad obtenerCiudadPorId(int idCiudad) {
        Ciudad ciudad = daoCiudad.obtenerPorId(idCiudad);
        return ciudad;
    }

    public ArrayList<Ciudad> listarTodasLasCiudades() {
        ArrayList<Ciudad> ciudades = daoCiudad.listarTodos();
        return ciudades;
    }
}
