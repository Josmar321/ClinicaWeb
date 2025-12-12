package pe.edu.pucp.usuario.dao;

import pe.edu.pucp.dao.ICrud;
import pe.edu.pucp.usuario.model.Persona;

public interface PersonaDAO extends ICrud<Persona>{
    int obtenerPorDocIdentidad(String docIdentidad);
    String obtenerNombreXIdUser(int idUsuario);
    byte[] obtenerFotoXUser(int idUser);
    String obtenerDocIdentidadXIdUser(int idUsuario);
}
