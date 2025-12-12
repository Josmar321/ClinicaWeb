package pe.edu.pucp.empresa.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.pucp.empresa.bo.DepartamentoBO;
import pe.edu.pucp.empresa.model.Departamento;

@WebService(serviceName = "DepartamentoWS", targetNamespace = "http://services.pucp.edu.pe")
public class DepartamentoWS {

    private DepartamentoBO boDepartamento;
    
    @WebMethod(operationName = "insertarDepartamento")
    public int insertarDepartamento(@WebParam(name = "departamento") Departamento departamento) {
        boDepartamento = new DepartamentoBO();
        return boDepartamento.insertar(departamento);
    }
    
    @WebMethod(operationName = "modificarDepartamento")
    public int modificarDepartamento(@WebParam(name = "departamento") Departamento departamento) {
        boDepartamento = new DepartamentoBO();
        return boDepartamento.modificar(departamento);
    }
    
    @WebMethod(operationName = "eliminarDepartamento")
    public int eliminarDepartamento(@WebParam(name = "idDepartamento") int idDepartamento) {
        boDepartamento = new DepartamentoBO();
        return boDepartamento.eliminar(idDepartamento);
    }
    
    @WebMethod(operationName = "listarDepartamentos")
    public ArrayList<Departamento> listarDepartamentos(){
        boDepartamento = new DepartamentoBO();
        return boDepartamento.listarTodos();
    }
}
