package pe.edu.pucp.empresa.model;

import java.util.ArrayList;

public class Local {
    private int idLocal;
    private String direccion;
    private String ubigeo;
    private Ciudad ciudad;
    private Departamento departamento;
    private boolean activo;
    
    //Relaciones
    private Empresa empresa;


    private ArrayList<Especialidad> especialidades;
    private ArrayList<Consultorio> consultorios;

    //Constructores
    public Local(){
        this.especialidades = new ArrayList<Especialidad>();
        this.consultorios = new ArrayList<Consultorio>();
    }

    public Local(String direccion, String ubigeo, Ciudad ciudad, Departamento departamento){
        this.direccion = direccion;
        this.ubigeo = ubigeo;
        this.ciudad = ciudad;
        this.departamento = departamento;
        this.especialidades = new ArrayList<Especialidad>();
        this.consultorios = new ArrayList<Consultorio>();
    }

    //Getters y Setters
    
    public ArrayList<Especialidad> getEspecialidades() {
        return especialidades;
    }
  
    public ArrayList<Consultorio> getConsultorios() {
        return consultorios;
    }

    public void setEspecialidades(ArrayList<Especialidad> especialidades) {
        this.especialidades = especialidades;
    }

    public void setConsultorios(ArrayList<Consultorio> consultorios) {
        this.consultorios = consultorios;
    }
    
    public int getIdLocal() {
        return this.idLocal;
    }

    public void setIdLocal(int idLocal) {
        this.idLocal = idLocal;
    }
    

    public String getDireccion() {
        return this.direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getUbigeo() {
        return this.ubigeo;
    }

    public void setUbigeo(String ubigeo) {
        this.ubigeo = ubigeo;
    }
    
    public Ciudad getCiudad() {
        return this.ciudad;
    }

    public void setCiudad(Ciudad ciudad) {
        this.ciudad = ciudad;
    }
    
    public Departamento getDepartamento() {
        return this.departamento;
    }

    public void setDepartamento(Departamento departamento) {
        this.departamento = departamento;
    }
    
    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    public Empresa getEmpresa() {
        return empresa;
    }

    public void setEmpresa(Empresa empresa) {
        this.empresa = empresa;
    }
    
    public void agregarEspecialidad(Especialidad especialidad) {
        this.especialidades.add(especialidad);
    }

    public void agregarConsultorio(Consultorio consultorio) {
        this.consultorios.add(consultorio);
    }
    
    @Override
    public String toString() {
        return "Local ID: " + idLocal + "\n"
             + "Direccion: " + direccion + "\n"
             + "Ubigeo: " + ubigeo + "\n"
             + "Ciudad: " + ciudad + "\n"
             + "Departamento: " + departamento + "\n"
             + "Empresa ID: " + (empresa != null ? empresa.getIdEmpresa() : "N/A") + "\n"
             + "Activo: " + (activo ? "Si" : "No") + "\n";
    }

}