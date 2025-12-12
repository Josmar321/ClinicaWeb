package pe.edu.pucp.usuario.model;

import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.cita.model.CitaMedica;

public class Paciente extends Persona {
    
    private String codigoPaciente;
    private TipoDeSangre tipoSangreID;
    private double peso;
    private double altura;
    private boolean activo;
    //Relaciones
    private ArrayList<CitaMedica> citasMedicas;

    // Constructores
    public Paciente(){
        this.citasMedicas = new ArrayList<CitaMedica>();
    }
	
    public Paciente(String docIdentidad, String nombres, String primerApellido, String segundoApellido,
                    String telefono, String direccion, String email, Date fechaNacimiento, char genero,byte[] foto,
                    Usuario usuario, TipoDeSangre tipoSangreID, double peso, double altura) {
        super(docIdentidad, nombres, primerApellido, segundoApellido, telefono, direccion, email, fechaNacimiento, genero,foto, usuario);
        this.codigoPaciente = getDocIdentidad();
        this.tipoSangreID = tipoSangreID;
        this.peso = peso;
        this.altura = altura;
        this.citasMedicas = new ArrayList<CitaMedica>();
        
    }

    //Getters y Setters
    public String getCodigoPaciente() {
        return this.codigoPaciente;
    }

    public void setCodigoPaciente(String codigoPaciente) {
        this.codigoPaciente = codigoPaciente;
    }

    public TipoDeSangre getTipoSangre() {
        return this.tipoSangreID;
    }

    public void setTipoSangre(TipoDeSangre tipoSangreID) {
        this.tipoSangreID = tipoSangreID;
    }

    public double getPeso() {
        return this.peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public double getAltura() {
        return this.altura;
    }

    public void setAltura(double altura) {
        this.altura = altura;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
	
    public ArrayList<CitaMedica> getCitasMedicas() {
        return new ArrayList<CitaMedica>(citasMedicas);
    }
    
    public void agregartCitasMedicas(CitaMedica citasMedica) {
        this.citasMedicas.add(citasMedica);
    }
}

