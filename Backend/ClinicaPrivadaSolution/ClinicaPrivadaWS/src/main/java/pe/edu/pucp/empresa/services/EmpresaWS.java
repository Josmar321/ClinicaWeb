package pe.edu.pucp.empresa.services;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import pe.edu.pucp.empresa.bo.EmpresaBO;
import pe.edu.pucp.empresa.model.Empresa;

@WebService(serviceName = "EmpresaWS", targetNamespace = "http://services.pucp.edu.pe")
public class EmpresaWS {

    private EmpresaBO boEmpresa;
    
    @WebMethod(operationName = "insertarEmpresa")
    public int insertarEmpresa(@WebParam(name = "empresa") Empresa empresa) {
        boEmpresa = new EmpresaBO();
        return boEmpresa.insertar(empresa);
    }
    
    @WebMethod(operationName = "modificarEmpresa")
    public int modificarEmpresa(@WebParam(name = "diagnostico") Empresa empresa) {
        boEmpresa = new EmpresaBO();
        return boEmpresa.modificar(empresa);
    }
    
    @WebMethod(operationName = "eliminarEmpresa")
    public int eliminarEmpresa(@WebParam(name = "idEmpresa") int idEmpresa) {
        boEmpresa = new EmpresaBO();
        return boEmpresa.eliminar(idEmpresa);
    }
    
    @WebMethod(operationName = "listarEmpresa")
    public Empresa listarEmpresa(){
        boEmpresa = new EmpresaBO();
        return boEmpresa.listarEmpresa();
    }
}
