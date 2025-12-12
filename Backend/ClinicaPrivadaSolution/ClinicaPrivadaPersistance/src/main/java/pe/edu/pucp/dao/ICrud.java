package pe.edu.pucp.dao;

import java.util.ArrayList;

public interface ICrud<T> {
    int insertar(T modelo);
    int modificar(T modelo);
    int eliminar(int idModelo);
    int eliminar(String idModelo);
    ArrayList<T> listarTodos();
}