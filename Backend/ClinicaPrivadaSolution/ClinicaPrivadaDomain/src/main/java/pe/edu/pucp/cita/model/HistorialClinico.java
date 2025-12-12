package pe.edu.pucp.cita.model;

import java.util.Date;
import java.util.ArrayList;
import pe.edu.pucp.usuario.model.Paciente;

public class HistorialClinico {
    private static int i=1;
    private int idHistorial;
    private Date fechaCreacion;
    private String obsGenerales;
    private boolean activo;
    
    //Relaciones
    private ArrayList<CitaMedica> citasMedicas;
    private Paciente paciente;

    //Constructores
    public HistorialClinico(){
        this.citasMedicas = new ArrayList<CitaMedica>();
    }
    
    public HistorialClinico(int id){
        this.idHistorial = id;
        this.citasMedicas = new ArrayList<CitaMedica>();
    }
    
    public HistorialClinico(Date fechaCreacion, String obsGenerales) {
        this.idHistorial = i;
        this.fechaCreacion = fechaCreacion;
        this.obsGenerales = obsGenerales;
        this.citasMedicas = new ArrayList<CitaMedica>();
        i++;
    }

    public int getIdHistorial() {
        return idHistorial;
    }

    public void setIdHistorial(int idHistorial) {
        this.idHistorial = idHistorial;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public String getObsGenerales() {
        return obsGenerales;
    }

    public void setObsGenerales(String obsGenerales) {
        this.obsGenerales = obsGenerales;
    }
    
    public ArrayList<CitaMedica> getCitasMedicas() {
        return new ArrayList<CitaMedica>(citasMedicas);
    }
    
    public void agregarCitasMedicas(CitaMedica citaMedica) {
        this.citasMedicas.add(citaMedica);
    }

    public void setCitasMedicas(ArrayList<CitaMedica> citasMedicas) {
        this.citasMedicas = citasMedicas;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
