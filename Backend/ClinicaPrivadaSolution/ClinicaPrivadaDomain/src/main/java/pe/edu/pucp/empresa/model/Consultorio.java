package pe.edu.pucp.empresa.model;

import pe.edu.pucp.usuario.model.Medico;

public class Consultorio {
    private int idConsultorio;
    private int numConsultorio;
    private int piso;
    private boolean activo;
    
    // Relaciones
    private Medico medico;
    private Local local;

    // Constructores
    public Consultorio() {}

    public Consultorio(int idConsultorio, int numConsultorio, int piso) {
        this.idConsultorio = idConsultorio;
        this.numConsultorio = numConsultorio;
        this.piso = piso;
    }

    // Getters y Setters
    public int getIdConsultorio() {
        return idConsultorio;
    }

    public void setIdConsultorio(int idConsultorio) {
        this.idConsultorio = idConsultorio;
    }

    public int getNumConsultorio() {
        return numConsultorio;
    }

    public void setNumConsultorio(int numConsultorio) {
        this.numConsultorio = numConsultorio;
    }

    public int getPiso() {
        return piso;
    }

    public void setPiso(int piso) {
        this.piso = piso;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public Local getLocal() {
        return local;
    }

    public void setLocal(Local local) {
        this.local = local;
    }
    
}
