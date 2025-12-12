package pe.edu.pucp.empresa.model;

public class Departamento {
    
    private static int i=1;
    private int id;
    private String nombre;
    private boolean activo;

    public Departamento() {}
    
    public Departamento(String nombre) {
        this.id = i;
        this.nombre = nombre;
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

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
}
