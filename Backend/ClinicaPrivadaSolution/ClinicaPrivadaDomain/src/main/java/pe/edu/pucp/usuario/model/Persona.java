package pe.edu.pucp.usuario.model;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Date;
import pe.edu.pucp.cita.model.HistorialClinico;
import pe.edu.pucp.empresa.model.Ciudad;
import pe.edu.pucp.empresa.model.Departamento;

public abstract class Persona{
    private String docIdentidad;
    private String nombre;
    private String primerApellido;
    private String segundoApellido;
    private String telefono;
    private String direccion;
    private String email;
    private Date fechaNacimiento;
    private char sexo;
    private byte[] foto;
    private Ciudad ciudad;
    private Departamento departamento;
    private boolean activo;

    //Relaciones
    private Usuario usuario;
    private HistorialClinico historialClinico;

    //Constructores
    public Persona(){}

    public Persona(String docIdentidad, String nombre, String primerApellido, String segundoApellido, String telefono, 
        String direccion, String email, Date fechaNacimiento, char sexo,byte[] foto, Usuario usuario){
        this.docIdentidad = docIdentidad;
        this.nombre = nombre;
        this.primerApellido = primerApellido;
        this.segundoApellido = segundoApellido;
        this.telefono = telefono;
        this.direccion = direccion;
        this.email = email;
        this.fechaNacimiento = fechaNacimiento;
        this.sexo = sexo;
        this.foto=foto;
        this.usuario = usuario;
    }

    //Getters y Setters
    public String getDocIdentidad() {
        return this.docIdentidad;
    }

    public void setDocIdentidad(String docIdentidad) {
        this.docIdentidad = docIdentidad;
    }

    public String getNombre() {
        return this.nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPrimerApellido() {
        return this.primerApellido;
    }

    public void setPrimerApellido(String primerApellido) {
        this.primerApellido = primerApellido;
    }

    public String getSegundoApellido() {
        return this.segundoApellido;
    }

    public void setSegundoApellido(String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }

    public String getTelefono() {
        return this.telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return this.direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getFechaNacimiento() {
        return this.fechaNacimiento;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public char getSexo() {
        return this.sexo;
    }

    public void setSexo(char sexo) {
        this.sexo = sexo;
    }
    
    public byte[] cargarFotos(String ruta) {
        try {
            return Files.readAllBytes(Path.of(ruta));
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public byte[] getFoto() {
        return this.foto;
    }
    
    public void setFoto(byte[] foto) {
        this.foto = foto;
    }

    public Usuario getUsuario() {
        return this.usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public HistorialClinico getHistorialClinico() {
        return this.historialClinico;
    }

    public void setHistorialClinico(HistorialClinico historialClinico) {
        this.historialClinico = historialClinico;
    }

    public Ciudad getCiudad() {
        return ciudad;
    }

    public void setCiudad(Ciudad ciudad) {
        this.ciudad = ciudad;
    }

    public Departamento getDepartamento() {
        return departamento;
    }

    public void setDepartamento(Departamento departamento) {
        this.departamento = departamento;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
