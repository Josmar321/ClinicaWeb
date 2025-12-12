package pe.edu.pucp.usuario.model;

import java.util.Date;

public class Administrador extends Persona {
    
    private String codigoAdministrador;
    private boolean activo;
    //Constructores
    public Administrador(){}
    
    public Administrador(String docIdentidad, String nombres, String primerApellido, String segundoApellido,
                        String telefono, String direccion, String email, Date fechaNacimiento, char genero,byte[] foto,
                        Usuario usuario){
        super(docIdentidad, nombres, primerApellido, segundoApellido, telefono, direccion, email, fechaNacimiento, genero,foto, usuario);
        this.codigoAdministrador = getDocIdentidad();
        
    }
    
    //Getters y Setters
    public String getCodigoAdministrador(){
        return this.codigoAdministrador;
    }

    public void setCodigoAdministrador(String codigoAdministrador) {
        this.codigoAdministrador = codigoAdministrador;
    }

    
    public  boolean isActivo(){
        return activo;
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
