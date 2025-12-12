package pe.edu.pucp.usuario.model;

public class TipoDeSangre {
    private static int i=1;
    private int id;
    private String tipo;
    private boolean activo;

    public TipoDeSangre() {}
    
    public TipoDeSangre(String tipo) {
        this.id = i;
        this.tipo = tipo;
        i++;
    }

    public static int getI() {
        return i;
    }

    public static void setI(int i) {
        TipoDeSangre.i = i;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
}
