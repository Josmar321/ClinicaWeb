package pe.edu.pucp.empresa.model;

public class Ciudad {
    private static int i=1;
    private int id;
    private String nombre;
    private Departamento departamento;
    private boolean activo;

    public Ciudad() {}
    
    public Ciudad(String nombre, Departamento departamento) {
        this.id = i;
        this.nombre = nombre;
        this.departamento = departamento;
        i++;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
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
