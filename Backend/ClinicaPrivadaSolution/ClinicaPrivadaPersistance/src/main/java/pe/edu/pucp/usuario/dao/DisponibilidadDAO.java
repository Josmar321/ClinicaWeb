package pe.edu.pucp.usuario.dao;

import java.util.ArrayList;
import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.usuario.model.Disponibilidad;

public interface DisponibilidadDAO extends ICrud<Disponibilidad>{
     public ArrayList<Disponibilidad> obtenerDisponibilidadXMedico(String codigoMedico);
     public Disponibilidad obtenerPorId(int id);
}
