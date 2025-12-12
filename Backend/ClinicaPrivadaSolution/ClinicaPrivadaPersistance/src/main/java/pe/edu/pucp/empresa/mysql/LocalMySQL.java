package pe.edu.pucp.empresa.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.pucp.config.DBManager;
import pe.edu.pucp.empresa.dao.LocalDAO;
import pe.edu.pucp.empresa.model.Ciudad;
import pe.edu.pucp.empresa.model.Consultorio;
import pe.edu.pucp.empresa.model.Departamento;
import pe.edu.pucp.empresa.model.Empresa;
import pe.edu.pucp.empresa.model.Especialidad;
import pe.edu.pucp.empresa.model.Local;
import pe.edu.pucp.usuario.model.Medico;

public class LocalMySQL implements LocalDAO {

    private ResultSet rs;

    @Override
    public int insertar(Local local) {
        Map<Integer, Object> parametrosSalida = new HashMap<>();
        Map<Integer, Object> parametrosEntrada = new HashMap<>();

        parametrosSalida.put(1, Types.INTEGER);
        parametrosEntrada.put(2, local.getDireccion());
        parametrosEntrada.put(3, local.getUbigeo());
        parametrosEntrada.put(4, local.getCiudad().getId());
        parametrosEntrada.put(5, local.getDepartamento().getId());
        parametrosEntrada.put(6, local.getEmpresa().getIdEmpresa());

        DBManager.getInstance().ejecutarProcedimiento("insertar_local", parametrosEntrada, parametrosSalida);
        local.setIdLocal((int) parametrosSalida.get(1));
        Map<Integer, Object> parametrosEntrada2 = new HashMap<>();
        parametrosEntrada2.put(1, local.getIdLocal());
        System.out.println(local.getEspecialidades().size());
        for (Especialidad especialidad : local.getEspecialidades()) {
            parametrosEntrada2.put(2, especialidad.getIdEspecialidad());
            DBManager.getInstance().ejecutarProcedimiento("insertar_local_especialidad", parametrosEntrada2, null);
            System.out.println("Se ha insertado una especialidad para el local correctamente.");
        }
        
        // Insertar consultorios
        for (Consultorio consultorio : local.getConsultorios()) {
            Map<Integer, Object> parametrosInsertCons = new HashMap<>();
            Map<Integer, Object> parametrosSalidaCons = new HashMap<>();

            parametrosInsertCons.put(2, consultorio.getNumConsultorio());
            parametrosInsertCons.put(3, consultorio.getPiso());
            parametrosInsertCons.put(4, local.getIdLocal());
            parametrosInsertCons.put(5, consultorio.getMedico().getCodigoMedico());
            parametrosInsertCons.put(6, true); // activo = true

            parametrosSalidaCons.put(1, Types.INTEGER);

            DBManager.getInstance().ejecutarProcedimiento("insertar_consultorio", parametrosInsertCons, parametrosSalidaCons);
            consultorio.setIdConsultorio((int) parametrosSalidaCons.get(1));
            System.out.println("Consultorio insertado con ID: " + consultorio.getIdConsultorio());
        }

        
        System.out.println("Se ha insertado el local correctamente.");
        return local.getIdLocal();
    }

    @Override
    public int modificar(Local local) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, local.getIdLocal());
        parametrosEntrada.put(2, local.getDireccion());
        parametrosEntrada.put(3, local.getUbigeo());
        parametrosEntrada.put(4, local.getCiudad().getId());
        parametrosEntrada.put(5, local.getDepartamento().getId());
        parametrosEntrada.put(6, local.isActivo()); 

        int resultado = DBManager.getInstance().ejecutarProcedimiento("modificar_local", parametrosEntrada, null);
        System.out.println("Se ha modificado el local correctamente.");

        // Obtener especialidades anteriores desde la BD
        ArrayList<Especialidad> especialidadesAnteriores = new ArrayList<>();
        Map<Integer, Object> parametrosLectura = new HashMap<>();
        parametrosLectura.put(1, local.getIdLocal());
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_especialidades_por_local", parametrosLectura);
        try {
            while (rs.next()) {
                Especialidad esp = new Especialidad();
                esp.setIdEspecialidad(rs.getInt("idEspecialidad"));
                especialidadesAnteriores.add(esp);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al leer especialidades anteriores: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        // Comparar listas y aplicar lógica de inserción/eliminación
        ArrayList<Integer> anteriores = new ArrayList<>();
        for (Especialidad esp : especialidadesAnteriores) {
            anteriores.add(esp.getIdEspecialidad());
        }

        ArrayList<Integer> actuales = new ArrayList<>();
        for (Especialidad esp : local.getEspecialidades()) {
            actuales.add(esp.getIdEspecialidad());
        }

        // Insertar las que están en actuales pero no en anteriores
        for (int idActual : actuales) {
            if (!anteriores.contains(idActual)) {
                Map<Integer, Object> parametrosInsert = new HashMap<>();
                parametrosInsert.put(1, local.getIdLocal());
                parametrosInsert.put(2, idActual);
                DBManager.getInstance().ejecutarProcedimiento("insertar_local_especialidad", parametrosInsert, null);
                System.out.println("Especialidad insertada: " + idActual);
            }
        }

        // Eliminar las que están en anteriores pero no en actuales
        for (int idAnterior : anteriores) {
            if (!actuales.contains(idAnterior)) {
                Map<Integer, Object> parametrosEliminar = new HashMap<>();
                parametrosEliminar.put(1, local.getIdLocal());
                parametrosEliminar.put(2, idAnterior);
                DBManager.getInstance().ejecutarProcedimiento("eliminar_local_especialidad", parametrosEliminar, null);
                System.out.println("Especialidad eliminada: " + idAnterior);
            }
        }
        
        
        // Obtener consultorios anteriores desde la BD
        ArrayList<Integer> idsConsultoriosBD = new ArrayList<>();
        Map<Integer, Object> parametrosConsultorios = new HashMap<>();
        parametrosConsultorios.put(1, local.getIdLocal());

        ResultSet rsConsultorios = DBManager.getInstance().ejecutarProcedimientoLectura("listar_consultorios_por_local", parametrosConsultorios);
        try {
            while (rsConsultorios.next()) {
                idsConsultoriosBD.add(rsConsultorios.getInt("idConsultorio"));
            }
        } catch (SQLException ex) {
            System.out.println("ERROR al leer consultorios anteriores: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        // Insertar consultorios nuevos
        ArrayList<Integer> idsConsultoriosActuales = new ArrayList<>();
        for (Consultorio cons : local.getConsultorios()) {
            if (cons.getIdConsultorio() == 0) {
                Map<Integer, Object> in = new HashMap<>();
                Map<Integer, Object> out = new HashMap<>();
                out.put(1, Types.INTEGER);
                in.put(2, cons.getNumConsultorio());
                in.put(3, cons.getPiso());
                in.put(4, local.getIdLocal());
                in.put(5, cons.getMedico().getCodigoMedico());
                in.put(6, true); // activo

                DBManager.getInstance().ejecutarProcedimiento("insertar_consultorio", in, out);
                int nuevoId = (int) out.get(1);
                cons.setIdConsultorio(nuevoId);
                System.out.println("Consultorio insertado (nuevo): " + nuevoId);
                idsConsultoriosActuales.add(nuevoId);
            } else {
                idsConsultoriosActuales.add(cons.getIdConsultorio());
            }
        }

        // Eliminar (lógicamente) consultorios que ya no están
        for (int idBD : idsConsultoriosBD) {
            if (!idsConsultoriosActuales.contains(idBD)) {
                Map<Integer, Object> paramEliminar = new HashMap<>();
                paramEliminar.put(1, idBD);
                DBManager.getInstance().ejecutarProcedimiento("eliminar_consultorio", paramEliminar, null);
                System.out.println("Consultorio eliminado (lógico): " + idBD);
            }
        }

        return resultado;
    }


    @Override
    public int eliminar(int idLocal) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idLocal);

        int resultado = DBManager.getInstance().ejecutarProcedimiento("eliminar_local", parametrosEntrada, null);
        System.out.println("Se ha eliminado el local correctamente.");
        return resultado;
    }

    @Override
    public ArrayList<Local> listarTodos() {
        ArrayList<Local> locales = new ArrayList<>();
        rs = DBManager.getInstance().ejecutarProcedimientoLectura("listar_locales", null);
        System.out.println("Lectura de locales...");

        try {
            while (rs.next()) {
                Local local = new Local();
                local.setIdLocal(rs.getInt("idLocal"));
                local.setDireccion(rs.getString("direccion"));
                local.setUbigeo(rs.getString("ubigeo"));
                
                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("ciudad_id"));
                local.setCiudad(ciudad);
                
                Departamento departamento = new Departamento();
                departamento.setId(rs.getInt("departamento_id"));
                local.setDepartamento(departamento);
                local.setActivo(rs.getBoolean("activo"));

                Empresa empresa = new Empresa();
                empresa.setIdEmpresa(rs.getInt("idEmpresa"));
                local.setEmpresa(empresa);

                locales.add(local);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        return locales;
    }

    @Override
    public Local obtenerLocalPorId(int idLocal) {
        Map<Integer, Object> parametrosEntrada = new HashMap<>();
        parametrosEntrada.put(1, idLocal);

        rs = DBManager.getInstance().ejecutarProcedimientoLectura("obtener_local_por_id", parametrosEntrada);
        System.out.println("Lectura de local por ID...");

        Local local = null;

        try {
            if (rs.next()) {
                local = new Local();
                local.setIdLocal(rs.getInt("idLocal"));
                local.setDireccion(rs.getString("direccion"));
                local.setUbigeo(rs.getString("ubigeo"));

                Ciudad ciudad = new Ciudad();
                ciudad.setId(rs.getInt("ciudad_id"));
                local.setCiudad(ciudad);

                Departamento departamento = new Departamento();
                departamento.setId(rs.getInt("departamento_id"));
                local.setDepartamento(departamento);

                local.setActivo(rs.getBoolean("activo"));

                Empresa empresa = new Empresa();
                empresa.setIdEmpresa(rs.getInt("idEmpresa"));
                local.setEmpresa(empresa);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
        } finally {
            DBManager.getInstance().cerrarConexion();
        }

        //Cargar especialidades activas
        if (local != null) {
            ArrayList<Especialidad> especialidades = new ArrayList<>();
            Map<Integer, Object> parametrosEsp = new HashMap<>();
            parametrosEsp.put(1, idLocal);

            ResultSet rsEsp = DBManager.getInstance()
                                       .ejecutarProcedimientoLectura("listar_especialidades_por_local", parametrosEsp);

            try {
                while (rsEsp.next()) {
                    Especialidad esp = new Especialidad();
                    esp.setIdEspecialidad(rsEsp.getInt("idEspecialidad"));
                    especialidades.add(esp);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR al leer especialidades del local: " + ex.getMessage());
            } finally {
                DBManager.getInstance().cerrarConexion();
            }

            local.setEspecialidades(especialidades);
            
            // Cargar consultorios del local
            ArrayList<Consultorio> consultorios = new ArrayList<>();
            Map<Integer, Object> parametrosCons = new HashMap<>();
            parametrosCons.put(1, idLocal);

            ResultSet rsCons = DBManager.getInstance()
                                         .ejecutarProcedimientoLectura("listar_consultorios_por_local", parametrosCons);

            try {
                while (rsCons.next()) {
                    Consultorio cons = new Consultorio();
                    cons.setIdConsultorio(rsCons.getInt("idConsultorio"));
                    cons.setNumConsultorio(rsCons.getInt("numConsultorio"));
                    cons.setPiso(rsCons.getInt("piso"));
                    cons.setActivo(rsCons.getBoolean("activo"));

                    Medico medico = new Medico();
                    medico.setCodigoMedico(rsCons.getString("codigoMedico"));
                    cons.setMedico(medico);

                    consultorios.add(cons);
                }
            } catch (SQLException ex) {
                System.out.println("ERROR al leer consultorios del local: " + ex.getMessage());
            } finally {
                DBManager.getInstance().cerrarConexion();
            }

            local.setConsultorios(consultorios);
        }
        
        return local;
    }


    @Override
    public int eliminar(String idModelo) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
