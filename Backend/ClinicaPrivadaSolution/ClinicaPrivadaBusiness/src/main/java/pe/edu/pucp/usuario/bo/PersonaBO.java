package pe.edu.pucp.usuario.bo;

import java.util.ArrayList;
import pe.edu.pucp.usuario.dao.PersonaDAO;
import pe.edu.pucp.usuario.model.Persona;
import pe.edu.pucp.usuario.mysql.PersonaMySQL;

public class PersonaBO {
    private PersonaDAO daoPaciente = new PersonaMySQL();

    public int insertar(Persona persona) {
        return daoPaciente.insertar(persona);
    }

    public int modificar(Persona persona) {
        return daoPaciente.modificar(persona);
    }

    public int eliminar(String docIdentidad) {
        return daoPaciente.eliminar(docIdentidad);
    }

    public ArrayList<Persona> listarTodos() {
        return daoPaciente.listarTodos();
    }

    public int obtenerPorDocIdentidad(String docIdentidad) {
        return daoPaciente.obtenerPorDocIdentidad(docIdentidad);
    }
    public String obtenerNombreXIdUser(int idUser) {
        return daoPaciente.obtenerNombreXIdUser(idUser);
    }
    public String obtenerDocIdentidadXIdUser(int idUser) {
        return daoPaciente.obtenerDocIdentidadXIdUser(idUser);
    }
    public byte[] obtenerFotoXUser(int idUser) {
        return daoPaciente.obtenerFotoXUser(idUser);
    }
}
