package pe.edu.pucp.cita.model;

public class Tratamiento {
    private int idTratamiento;
    private String descripcionTratamiento;
    private boolean activo;
    
    private CitaMedica citaMedica;

    //Constructores
    public Tratamiento() {
    }
    
    public Tratamiento(int diasDuracion, String descripcionTratamiento) {
        this.descripcionTratamiento = descripcionTratamiento;
    }

    public int getIdTratamiento() {
        return idTratamiento;
    }

    public void setIdTratamiento(int idTratamiento) {
        this.idTratamiento = idTratamiento;
    }

    public String getDescripcionTratamiento() {
        return descripcionTratamiento;
    }

    public void setDescripcionTratamiento(String descripcionTratamiento) {
        this.descripcionTratamiento = descripcionTratamiento;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public CitaMedica getCitaMedica() {
        return citaMedica;
    }

    public void setCitaMedica(CitaMedica citaMedica) {
        this.citaMedica = citaMedica;
    }
    
}
