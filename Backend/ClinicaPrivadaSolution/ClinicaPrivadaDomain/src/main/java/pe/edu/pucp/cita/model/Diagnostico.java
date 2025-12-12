package pe.edu.pucp.cita.model;

import java.time.LocalDate;
import java.util.Date;

public class Diagnostico {
    private int idDiagnostico;
    private String descripcionDiagnostico;
    private Date fecha;
    private boolean activo;
    
    //Relaciones
    //private HistorialClinico historialClinico;
    private CitaMedica citaMedica;
    //Constructores
    public Diagnostico() {}
	
    public Diagnostico( String descripcionDiagnostico, Date fecha) {
        this.descripcionDiagnostico = descripcionDiagnostico;
        this.fecha = fecha;
    }

    public Date getFecha() {
        return this.fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getDescripcionDiagnostico() {
        return descripcionDiagnostico;
    }

    public void setDescripcionDiagnostico(String descripcionDiagnostico) {
        this.descripcionDiagnostico = descripcionDiagnostico;
    }

    public CitaMedica getCitaMedica() {
        return citaMedica;
    }

    public void setCitaMedica(CitaMedica citaMedica) {
        this.citaMedica = citaMedica;
    }

    public int getIdDiagnostico() {
        return idDiagnostico;
    }

    public void setIdDiagnostico(int idDiagnostico) {
        this.idDiagnostico = idDiagnostico;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

}

