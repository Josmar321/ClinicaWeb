package pe.edu.pucp.cita.model;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;
import pe.edu.pucp.empresa.model.Consultorio;
import pe.edu.pucp.usuario.model.Medico;
import pe.edu.pucp.usuario.model.Paciente;

public class CitaMedica {
    private int idCita;
    private Date fecha;
    private Date hora;
    private double precio;
    private EstadoCita estado;
    private Modalidad modalidad;
    private boolean activo;

    //Relaciones
    private Medico medico;
    private Paciente paciente;
    private Consultorio consultorio;
    private HistorialClinico historialClinico;

    //Constructores
    public CitaMedica(){}

    public CitaMedica(Date fecha, Date hora, EstadoCita estado, 
                      double precio, Modalidad modalidad) {
        this.fecha = fecha;
        this.hora = hora;
        this.precio = precio;
        this.estado = estado;
        this.modalidad = modalidad;
    }

    //Getters y Setters
    public int getIdCita() {
        return this.idCita;
    }
    

    public Consultorio getConsultorio() {
        return consultorio;
    }

    
    public void setIdCita(int idCita) {
    this.idCita = idCita;
    }
     
    public void setConsultorio(Consultorio consultorio) {
        this.consultorio = consultorio;
    }

    public Date getFecha() {
        return this.fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Date getHora() {
        return this.hora;
    }

    public void setHora(Date hora) {
        this.hora = hora;
    }
    
    public double getPrecio(){
        return this.precio;
    }
    
    public void setPrecio(double precio){
        this.precio = precio;
    }
    
    public EstadoCita getEstado() {
        return this.estado;
    }

    public void setEstado(EstadoCita estado) {
        this.estado = estado;
    }

    public Modalidad getModalidad() {
        return this.modalidad;
    }

    public void setModalidad(Modalidad modalidad) {
        this.modalidad = modalidad;
    }

    public Medico getMedico() {
        return this.medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public Paciente getPaciente() {
        return this.paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public HistorialClinico getHistorialClinico() {
        return historialClinico;
    }

    public void setHistorialClinico(HistorialClinico historialClinico) {
        this.historialClinico = historialClinico;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    @Override
    public String toString() {
        return "CitaMedica:" + "fecha=" + fecha + ", hora=" + hora + ", precio=" + precio + ", estado=" + estado + ", modalidad=" + modalidad;
    }

}
