package pe.edu.pucp.usuario.model;

import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.cita.model.CitaMedica;
import pe.edu.pucp.empresa.model.Consultorio;
import pe.edu.pucp.empresa.model.Especialidad;

public class Medico extends Persona {
  
    private String codigoMedico;
    private String numeroColegiatura;
    private boolean activo;
	
    //Relaciones
    private Especialidad especialidad;
    private ArrayList<Disponibilidad> disponibilidades;
    private ArrayList<CitaMedica> citasMedicas;
    private ArrayList<Consultorio> consultorios;

    //Constructores
    public Medico(){
        this.disponibilidades = new ArrayList<Disponibilidad>();
        this.citasMedicas = new ArrayList<CitaMedica>();
        this.consultorios = new ArrayList<Consultorio>();
    }

    public Medico(String docIdentidad, String nombres, String primerApellido, String segundoApellido,
                    String telefono, String direccion, String email, Date fechaNacimiento, char genero,byte[] foto,
                    Usuario usuario, Especialidad especialidad,String numeroColegiatura){
        super(docIdentidad, nombres, primerApellido, segundoApellido, telefono, direccion, 
                email, fechaNacimiento, genero,foto, usuario);
        this.codigoMedico = getDocIdentidad();
        this.especialidad=especialidad;
        this.numeroColegiatura = numeroColegiatura;
        this.disponibilidades = new ArrayList<Disponibilidad>();
        this.citasMedicas = new ArrayList<CitaMedica>();
        this.consultorios = new ArrayList<Consultorio>();
       
    }

    //Getters y Setters
    public String getCodigoMedico() {
        return this.codigoMedico;
    }

    public void setCodigoMedico(String codigoMedico) {
        this.codigoMedico = codigoMedico;
    }

    public String getNumeroColegiatura() {
        return this.numeroColegiatura;
    }

    public void setNumeroColegiatura(String numeroColegiatura) {
        this.numeroColegiatura = numeroColegiatura;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    
    public Especialidad getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(Especialidad especialidad) {
        this.especialidad = especialidad;
    }

    public ArrayList<Disponibilidad> getDisponibilidades() {
        return new ArrayList<Disponibilidad>(disponibilidades);
    }
    
    public void setDisponibilidades(Disponibilidad disponibilidades) {
        this.disponibilidades.add(disponibilidades);
    }

    public ArrayList<CitaMedica> getCitasMedicas() {
        return new ArrayList<CitaMedica>(citasMedicas);
    }
    
    public void agregartCitasMedicas(CitaMedica citasMedica) {
        this.citasMedicas.add(citasMedica);
    }
    
    public ArrayList<Consultorio> getConsultorios() {
        return new ArrayList<Consultorio>(consultorios);
    }
    
    public void agregartConsultorios(Consultorio consultorio) {
        this.consultorios.add(consultorio);
    }
}

