package pe.edu.pucp.main;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import pe.edu.pucp.cita.model.Diagnostico;
import pe.edu.pucp.cita.model.HistorialClinico;
import pe.edu.pucp.cita.model.Tratamiento;
import pe.edu.pucp.cita.model.CitaMedica;
import pe.edu.pucp.cita.bo.DiagnosticoBO;
import pe.edu.pucp.cita.bo.HistorialClinicoBO;
import pe.edu.pucp.cita.bo.TratamientoBO;
import pe.edu.pucp.cita.bo.CitaMedicaBO;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import pe.edu.pucp.cita.model.EstadoCita;
import pe.edu.pucp.cita.model.Modalidad;
import pe.edu.pucp.empresa.model.Especialidad;
import pe.edu.pucp.usuario.model.Medico;
import pe.edu.pucp.usuario.model.Paciente;
import pe.edu.pucp.usuario.bo.AdministradorBO;
import pe.edu.pucp.usuario.bo.MedicoBO;
import pe.edu.pucp.usuario.bo.PacienteBO;
import pe.edu.pucp.usuario.dao.PacienteDAO;
import pe.edu.pucp.usuario.model.Administrador;
import pe.edu.pucp.usuario.model.Rol;
import pe.edu.pucp.usuario.model.Usuario;
import pe.edu.pucp.usuario.mysql.PacienteMySQL;

import pe.edu.pucp.empresa.model.Empresa;
import pe.edu.pucp.empresa.model.Local;
import pe.edu.pucp.empresa.bo.EmpresaBO;
import pe.edu.pucp.empresa.bo.EspecialidadBO;
import pe.edu.pucp.empresa.bo.LocalBO;
import pe.edu.pucp.empresa.model.Departamento;
import pe.edu.pucp.usuario.bo.PersonaBO;
import pe.edu.pucp.usuario.bo.UsuarioBO;

public class Principal {
    public static void main(String[] args) throws IOException, Exception{

        /*  public Administrador(String docIdentidad, String nombres, String primerApellido, String segundoApellido,
                        String telefono, String direccion, String email, Date fechaNacimiento, char genero,byte[] foto,
                        Usuario usuario){
        super(docIdentidad, nombres, primerApellido, segundoApellido, telefono, direccion, email, fechaNacimiento, genero,foto, usuario);
        this.codigoAdministrador = getDocIdentidad();
        
    }*/
//        PersonaBO boPersona =new PersonaBO();
//        byte[] foto = boPersona.obtenerFotoXUser(49);
//        
//        if (foto != null) {
//            System.out.println("Foto asignada a persona. Tamaño: " + foto);
//        } else {
//            System.out.println("No se pudo obtener la foto.");
//        }
          MedicoBO boMedico=new MedicoBO();
          Medico prueba =new Medico();
          prueba=boMedico.obtenerMedicoXUser(44);
          System.out.println("El nombre es: " + prueba.getNombre()+ " Colegiatura"+prueba.getNumeroColegiatura());         
    }
}

