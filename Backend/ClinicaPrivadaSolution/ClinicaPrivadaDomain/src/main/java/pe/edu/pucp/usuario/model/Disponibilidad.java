package pe.edu.pucp.usuario.model;

import java.util.Date;
import javax.xml.datatype.XMLGregorianCalendar;
public class Disponibilidad {
    private int idDisponibilidad;
    private Dia dia;
    private Date horaInicio;
    private Date horaFin;
    private Medico medico;
    private boolean activo;
    
    
    public Disponibilidad() {}
    
    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }
    
    public void setIdDisponibilidad(int idDisponibilidad) {
        this.idDisponibilidad = idDisponibilidad;
    }

    //Getters y setters
    public int getIdDisponibilidad() {
        return this.idDisponibilidad;
    }
    
    public Dia getDia() {
        return this.dia;
    }

    public void setDia(Dia dia) {
        this.dia = dia;
    }

    public Date getHoraInicio() {
        return this.horaInicio;
    }

    public void setHoraInicio(Date horaInicio) {
        this.horaInicio = horaInicio;
    }

    public Date getHoraFin() {
        return this.horaFin;
    }

    public void setHoraFin(Date horaFin) {
        this.horaFin = horaFin;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}

