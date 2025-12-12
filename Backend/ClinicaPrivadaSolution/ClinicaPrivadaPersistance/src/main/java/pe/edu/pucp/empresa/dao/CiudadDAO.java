package pe.edu.pucp.empresa.dao;

import java.util.ArrayList;
import pe.edu.pucp.empresa.model.Ciudad;

public interface CiudadDAO {
    ArrayList<Ciudad> listarTodos();
    Ciudad obtenerPorId(int idCiudad);
}