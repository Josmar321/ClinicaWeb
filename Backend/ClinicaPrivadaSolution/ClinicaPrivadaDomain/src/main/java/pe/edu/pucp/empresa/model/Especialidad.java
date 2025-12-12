package pe.edu.pucp.empresa.model;

import java.util.ArrayList;
import pe.edu.pucp.usuario.model.Medico;

public class Especialidad {

    private int idEspecialidad;
    private String nombre;
    private boolean activo;
	
    //Relaicones
    private ArrayList<Medico> medicos;
    private ArrayList<Local> locales;

    //Constructores
    public Especialidad() {
        this.medicos = new ArrayList<Medico>();
        this.locales = new ArrayList<Local>();
    }

	
    //Getters y Setters
    public int getIdEspecialidad() {
        return this.idEspecialidad;
    }

    
    public void setIdEspecialidad(int idEspecialidad) {
        this.idEspecialidad = idEspecialidad;
    }
    
	
    public String getNombre() {
        return this.nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public ArrayList<Medico> getMedico() {
        return new ArrayList<Medico>(medicos);
    }
    
    public void agregarMedico(Medico medico) {
        this.medicos.add(medico);
    }
    
    public ArrayList<Local> getLocal() {
        return new ArrayList<Local>(locales);
    }
    
    public void agregarMedico(Local local) {
        this.locales.add(local);
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public ArrayList<Medico> getMedicos() {
        return medicos;
    }

    public void setMedicos(ArrayList<Medico> medicos) {
        this.medicos = medicos;
    }

    public ArrayList<Local> getLocales() {
        return locales;
    }

    public void setLocales(ArrayList<Local> locales) {
        this.locales = locales;
    }
}