package pe.edu.pucp.cita.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.cita.dao.CitaMedicaDAO;
import pe.edu.pucp.cita.model.CitaMedica;
import pe.edu.pucp.cita.model.EstadoCita;
import pe.edu.pucp.cita.model.HistorialClinico;
import pe.edu.pucp.cita.model.Modalidad;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.empresa.model.Ciudad;
import pe.edu.pucp.empresa.model.Consultorio;
import pe.edu.pucp.empresa.model.Departamento;
import pe.edu.pucp.empresa.model.Local;
import pe.edu.pucp.usuario.model.Medico;
import pe.edu.pucp.usuario.model.Paciente;

public class CitaMedicaMySQL implements CitaMedicaDAO{
    
    private ResultSet rs;
    
    @Override
public int insertar(CitaMedica citaMedica) {
    int resultado = 0; // Inicia en 0 (fallo) por defecto
    try {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        parametrosEntrada.put(1, citaMedica.getFecha());
        parametrosEntrada.put(2, new java.sql.Time(citaMedica.getHora().getTime()));
        parametrosEntrada.put(3, citaMedica.getPrecio());
        parametrosEntrada.put(4, citaMedica.getEstado().toString());
        parametrosEntrada.put(5, citaMedica.getModalidad().toString());
        parametrosEntrada.put(6, citaMedica.getPaciente().getCodigoPaciente());
        parametrosEntrada.put(7, citaMedica.getMedico().getCodigoMedico());
        parametrosEntrada.put(8, citaMedica.getConsultorio().getIdConsultorio());
        
        Integer idHistorial = null;
        if (citaMedica.getHistorialClinico() != null) {
            idHistorial = citaMedica.getHistorialClinico().getIdHistorial();
        }
        parametrosEntrada.put(9, idHistorial);

        // AHORA SÍ CAPTURAMOS EL RESULTADO REAL
        resultado = DBManager.getInstance().ejecutarProcedimiento(
            "insertar_cita_medica", parametrosEntrada, null
        );

        if(resultado > 0) {
            System.out.println("Se ha realizado el registro de la cita correctamente.");
        }

    } catch (Exception ex) {
        System.out.println("ERROR GRAVE en CitaMedicaMySQL al insertar: " + ex.getMessage());
        return 0; // En caso de cualquier excepción, devuelve 0
    }
    // Devolvemos el resultado real (0 si falló, 1 si tuvo éxito)
    return resultado;
}
    
        @Override
    public int modificar(CitaMedica citaMedica) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, citaMedica.getIdCita());
        parametrosEntrada.put(2, citaMedica.getFecha());
        parametrosEntrada.put(3, new java.sql.Time(citaMedica.getHora().getTime()));

        parametrosEntrada.put(4, citaMedica.getPrecio());
        parametrosEntrada.put(5, citaMedica.getEstado().toString());
        parametrosEntrada.put(6, citaMedica.getModalidad().toString());
        parametrosEntrada.put(7, citaMedica.getPaciente().getCodigoPaciente());
        parametrosEntrada.put(8, citaMedica.getMedico().getCodigoMedico());
        parametrosEntrada.put(9, citaMedica.getConsultorio().getIdConsultorio());
        parametrosEntrada.put(10, citaMedica.getHistorialClinico().getIdHistorial());
        parametrosEntrada.put(11, citaMedica.isActivo());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_cita_medica_administrador", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion de la cita");
        return resultado;
    }
    
    @Override
    public int eliminar(int idCitaMedica) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idCitaMedica);
        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_cita_medica", parametrosEntrada, null);
        System.out.println("Se ha realizado la eliminacion de la cita");
        return resultado;
    }
    
    @Override
    public ArrayList<CitaMedica> listarTodos() {
        ArrayList<CitaMedica> citas = null;
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_citas_medicas", null);
        System.out.println("Lectura de citas...");
        try{
            while(rs.next()){
                if(citas == null) citas = new ArrayList<>();
                CitaMedica cita = new CitaMedica();
                
                // Asignar los valores desde el ResultSet a los atributos del objeto CitaMedica
                cita.setIdCita(rs.getInt("idCitaMedica"));
                cita.setFecha(rs.getDate("fecha"));
                cita.setHora(rs.getTime("hora"));
                cita.setPrecio(rs.getDouble("precio"));
                // Manejamos con ENUM
                cita.setEstado(EstadoCita.valueOf(rs.getString("estado")));
                cita.setModalidad(Modalidad.valueOf(rs.getString("modalidad")));
                
                // Obtener relaciones de otras tablas
                Paciente paciente = new Paciente();
                paciente.setCodigoPaciente(rs.getString("codigoPaciente"));
                cita.setPaciente(paciente);
                
                Medico medico = new Medico();
                medico.setCodigoMedico(rs.getString("codigoMedico"));
                cita.setMedico(medico);
                
                Consultorio consultorio = new Consultorio();
                consultorio.setIdConsultorio(rs.getInt("idConsultorio"));
                cita.setConsultorio(consultorio);
                
                HistorialClinico historial = new HistorialClinico();
                historial.setIdHistorial(rs.getInt("idHistorial"));
                cita.setHistorialClinico(historial);
                
                cita.setActivo(true);
                
                citas.add(cita);
            }
        }catch(SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
        }finally{
            DBManager.getInstance().cerrarConexion();
        }
        return citas;
    }
    
    
    
    @Override
    public int modificarCitaMedico(CitaMedica citaMedica) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, citaMedica.getIdCita());
        parametrosEntrada.put(2, new java.sql.Time(citaMedica.getHora().getTime()));
        parametrosEntrada.put(3, citaMedica.getEstado().toString());
        parametrosEntrada.put(4, citaMedica.getModalidad().toString());
        parametrosEntrada.put(5, citaMedica.isActivo());
        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_cita_medica_medico", parametrosEntrada, null);
        System.out.println("Se ha realizado la modificacion de la cita");
        return resultado;
    }
    @Override
    public int modificarCitaPaciente(CitaMedica citaMedica) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        parametrosEntrada.put(1, citaMedica.getIdCita());
        parametrosEntrada.put(2, new java.sql.Time(citaMedica.getHora().getTime()));
        parametrosEntrada.put(3, citaMedica.getModalidad().toString()); 
        parametrosEntrada.put(4, citaMedica.isActivo()); 

        int resultado = DBManager.getInstance().ejecutarProcedimiento(
            "modificar_cita_medica_paciente", 
            parametrosEntrada, 
            null
        );

        System.out.println("Se ha realizado la modificación de la cita médica.");

        return resultado; 
    }


    
    @Override
    public int cancelarCitaMedica(int idCitaMedica) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idCitaMedica);

        int resultado = DBManager.getInstance().ejecutarProcedimiento("cancelar_cita", parametrosEntrada, null);

        System.out.println("La cita médica con ID " + idCitaMedica + " ha sido cancelada correctamente.");

        return resultado;
    }
    
    @Override
    public ArrayList<CitaMedica> obtenerCitasPorFecha(Date fechaInicio, Date fechaFin) {
        ArrayList<CitaMedica> citas = new ArrayList<>();

        System.out.println("==== INICIANDO OBTENCIÓN DE CITAS POR FECHA ====");
        System.out.println("Fecha Inicio: " + fechaInicio);
        System.out.println("Fecha Fin: " + fechaFin);

        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, fechaInicio);
        parametrosEntrada.put(2, fechaFin);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("reporte_citas_por_fecha", parametrosEntrada);

        System.out.println("Lectura de citas médicas entre las fechas " + fechaInicio + " y " + fechaFin);

        try {
            while (rs.next()) {
                CitaMedica cita = new CitaMedica();
                cita.setIdCita(rs.getInt("idCitaMedica"));
                cita.setFecha(rs.getDate("fecha"));
                cita.setHora(rs.getTime("hora")); // Asegúrate de usar getTime si es TIME
                cita.setPrecio(rs.getDouble("precio"));
                cita.setEstado(EstadoCita.valueOf(rs.getString("estado")));
                cita.setModalidad(Modalidad.valueOf(rs.getString("modalidad")));

                // Paciente con nombres y apellidos
                Paciente paciente = new Paciente();
                paciente.setCodigoPaciente(rs.getString("codigoPaciente"));
                paciente.setNombre(rs.getString("nombresPaciente"));
                paciente.setPrimerApellido(rs.getString("primerApellidoPaciente"));
                paciente.setSegundoApellido(rs.getString("segundoApellidoPaciente"));
                cita.setPaciente(paciente);

                // Médico con nombres y apellidos
                Medico medico = new Medico();
                medico.setCodigoMedico(rs.getString("codigoMedico"));
                medico.setNombre(rs.getString("nombresMedico"));
                medico.setPrimerApellido(rs.getString("primerApellidoMedico"));
                medico.setSegundoApellido(rs.getString("segundoApellidoMedico"));
                cita.setMedico(medico);

                // Consultorio y Local
                Consultorio consultorio = new Consultorio();
                consultorio.setIdConsultorio(rs.getInt("idConsultorio"));
                consultorio.setNumConsultorio(rs.getInt("numConsultorio"));
                consultorio.setPiso(rs.getInt("piso"));

                Local local = new Local();
                local.setIdLocal(rs.getInt("idLocal"));
                local.setDireccion(rs.getString("direccionLocal"));

                // Crear Departamento
                Departamento departamento = new Departamento();
                departamento.setNombre(rs.getString("departamentoLocal"));

                // Crear Ciudad y asignar Departamento
                Ciudad ciudad = new Ciudad();
                ciudad.setNombre(rs.getString("ciudadLocal"));
                ciudad.setDepartamento(departamento);

                // Asignar ciudad y departamento al local
                local.setCiudad(ciudad);
                local.setDepartamento(departamento);


                consultorio.setLocal(local);
                cita.setConsultorio(consultorio);

                // Historial clínico
                HistorialClinico historial = new HistorialClinico();
                historial.setIdHistorial(rs.getInt("idHistorial"));
                cita.setHistorialClinico(historial);

                cita.setActivo(true);
                citas.add(cita);

                // Debug
                System.out.println("   - ID: " + cita.getIdCita());
                System.out.println("   - Fecha: " + cita.getFecha());
                System.out.println("   - Hora: " + cita.getHora());
                System.out.println("   - Estado: " + cita.getEstado());
                System.out.println("   - Modalidad: " + cita.getModalidad());

                System.out.println("   - Paciente: " + paciente.getCodigoPaciente() + " - " + paciente.getNombre() + " " + paciente.getPrimerApellido() + " " + paciente.getSegundoApellido());
                System.out.println("   - Médico: " + medico.getCodigoMedico() + " - " + medico.getNombre() + " " + medico.getPrimerApellido() + " " + medico.getSegundoApellido());

                System.out.println("   - Consultorio ID: " + consultorio.getIdConsultorio());
                System.out.println("       * Número: " + consultorio.getNumConsultorio());
                System.out.println("       * Piso: " + consultorio.getPiso());
                System.out.println("       * Dirección: " + local.getDireccion());
                System.out.println("       * Ciudad: " + local.getCiudad().getNombre());
                System.out.println("       * Departamento: " + local.getDepartamento().getNombre());

                System.out.println("   - Historial ID: " + historial.getIdHistorial());
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return citas;
    }


    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    @Override
    public ArrayList<CitaMedica> listarCitasPorPaciente(String codigoPaciente) {
        ArrayList<CitaMedica> citas = new ArrayList<>();
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, codigoPaciente);

        ResultSet rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_citas_por_paciente", parametrosEntrada);

        try {
            while (rs.next()) {
                CitaMedica cita = new CitaMedica();
                cita.setIdCita(rs.getInt("idCitaMedica"));
                cita.setFecha(rs.getDate("fecha"));
                cita.setHora(rs.getTime("hora"));
                cita.setPrecio(rs.getDouble("precio"));
                cita.setEstado(EstadoCita.valueOf(rs.getString("estado")));
                cita.setModalidad(Modalidad.valueOf(rs.getString("modalidad")));

                Paciente paciente = new Paciente();
                paciente.setCodigoPaciente(rs.getString("codigoPaciente"));
                cita.setPaciente(paciente);

                Medico medico = new Medico();
                medico.setCodigoMedico(rs.getString("codigoMedico"));
                cita.setMedico(medico);

                Consultorio consultorio = new Consultorio();
                consultorio.setIdConsultorio(rs.getInt("idConsultorio"));
                cita.setConsultorio(consultorio);

                HistorialClinico historial = new HistorialClinico();
                historial.setIdHistorial(rs.getInt("idHistorial"));
                cita.setHistorialClinico(historial);

                cita.setActivo(rs.getBoolean("activo"));

                citas.add(cita);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar citas por paciente: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return citas;
    }
    
    @Override
    public CitaMedica obtenerPorId(int idCitaMedica) {
        CitaMedica cita = null;
        try {
            Map<Integer, Object> parametrosEntrada = new HashMap<>();
            parametrosEntrada.put(1, idCitaMedica);

            ResultSet rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_cita_medica_por_id", parametrosEntrada);

            if (rs.next()) {
                cita = new CitaMedica();
                cita.setIdCita(rs.getInt("idCitaMedica"));
                cita.setFecha(rs.getDate("fecha"));
                cita.setHora(rs.getTime("hora"));
                cita.setPrecio(rs.getDouble("precio"));
                cita.setEstado(EstadoCita.valueOf(rs.getString("estado")));
                cita.setModalidad(Modalidad.valueOf(rs.getString("modalidad")));

                Paciente paciente = new Paciente();
                paciente.setCodigoPaciente(rs.getString("codigoPaciente"));
                cita.setPaciente(paciente);

                Medico medico = new Medico();
                medico.setCodigoMedico(rs.getString("codigoMedico"));
                cita.setMedico(medico);

                Consultorio consultorio = new Consultorio();
                consultorio.setIdConsultorio(rs.getInt("idConsultorio"));
                cita.setConsultorio(consultorio);

                int idHistorial = rs.getInt("idHistorial");
                if (!rs.wasNull()) {
                    HistorialClinico historial = new HistorialClinico();
                    historial.setIdHistorial(idHistorial);
                    cita.setHistorialClinico(historial);
                }

                cita.setActivo(rs.getBoolean("activo"));
            }
        } catch (SQLException ex) {
            System.err.println("Error al obtener cita por ID: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return cita;
    }


}
