package pe.edu.pucp.usuario.model;

public class Usuario {
    private static int i=1;
    private int idUsuario;
    private String username;
    private String password;
    private Rol rol;
    private boolean activo;
	
    //Constructores
    public Usuario() {
    }

    public Usuario(String username, String password,Rol rol) {
        this.idUsuario = i;
        this.username = username;
        this.password = password;
        this.rol=rol;
        i++;
    }

    //Getters y Setters

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
        
    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
}

