-- =================================================
-- | SCRIPT 03: Elimina Procedimientos Almacenados |
-- =================================================

-- ===========
-- | Persona |
-- ===========
DROP PROCEDURE IF EXISTS insertar_persona;
DROP PROCEDURE IF EXISTS eliminar_persona;
DROP PROCEDURE IF EXISTS listar_personas;
DROP PROCEDURE IF EXISTS modificar_persona;
DROP PROCEDURE IF EXISTS obtener_persona_por_docIdentidad;

-- ===========
-- | Usuario |
-- ===========
DROP PROCEDURE IF EXISTS insertar_usuario;
DROP PROCEDURE IF EXISTS modificar_usuario;
DROP PROCEDURE IF EXISTS eliminar_usuario;
DROP PROCEDURE IF EXISTS eliminar_usuario_username;
DROP PROCEDURE IF EXISTS obtener_usuario_por_id;
DROP PROCEDURE IF EXISTS obtener_usuario_por_username;
DROP PROCEDURE IF EXISTS listar_usuarios;
DROP PROCEDURE IF EXISTS verificar_usuario;

-- ==========
-- | Medico |
-- ==========
DROP PROCEDURE IF EXISTS insertar_medico;
DROP PROCEDURE IF EXISTS modificar_medico;
DROP PROCEDURE IF EXISTS eliminar_medico;
DROP PROCEDURE IF EXISTS obtener_medico_por_id;
DROP PROCEDURE IF EXISTS listar_medicos;
DROP PROCEDURE IF EXISTS obtener_medicos_para_cita_medica;

-- ============
-- | Paciente |
-- ============
DROP PROCEDURE IF EXISTS insertar_paciente;
DROP PROCEDURE IF EXISTS modificar_paciente;
DROP PROCEDURE IF EXISTS eliminar_paciente;
DROP PROCEDURE IF EXISTS obtener_paciente_por_id;
DROP PROCEDURE IF EXISTS listar_pacientes;

-- =================
-- | Administrador |
-- =================
DROP PROCEDURE IF EXISTS insertar_administrador;
DROP PROCEDURE IF EXISTS modificar_administrador;
DROP PROCEDURE IF EXISTS eliminar_administrador;
DROP PROCEDURE IF EXISTS obtener_administrador_por_id;
DROP PROCEDURE IF EXISTS listar_administradores;

-- ===============
-- | Cita Médica |
-- ===============
DROP PROCEDURE IF EXISTS insertar_cita_medica;
DROP PROCEDURE IF EXISTS modificar_cita_medica_administrador;
DROP PROCEDURE IF EXISTS modificar_cita_medica_medico;
DROP PROCEDURE IF EXISTS modificar_cita_medica_paciente;
DROP PROCEDURE IF EXISTS eliminar_cita_medica;
DROP PROCEDURE IF EXISTS cancelar_cita;
DROP PROCEDURE IF EXISTS listar_citas_medicas;
DROP PROCEDURE IF EXISTS obtener_cita_medica_por_id;

-- ===============
-- | Diagnostico |
-- ===============
DROP PROCEDURE IF EXISTS insertar_diagnostico;
DROP PROCEDURE IF EXISTS modificar_diagnostico;
DROP PROCEDURE IF EXISTS eliminar_diagnostico;
DROP PROCEDURE IF EXISTS obtener_diagnostico_por_id;
DROP PROCEDURE IF EXISTS listar_diagnosticos;

-- ===============
-- | Tratamiento |
-- ===============
DROP PROCEDURE IF EXISTS insertar_tratamiento;
DROP PROCEDURE IF EXISTS modificar_tratamiento;
DROP PROCEDURE IF EXISTS eliminar_tratamiento;
DROP PROCEDURE IF EXISTS obtener_tratamiento_por_id;
DROP PROCEDURE IF EXISTS listar_tratamientos;

-- =========
-- | Local |
-- =========
DROP PROCEDURE IF EXISTS insertar_local;
DROP PROCEDURE IF EXISTS modificar_local;
DROP PROCEDURE IF EXISTS eliminar_local;
DROP PROCEDURE IF EXISTS obtener_local_por_id;
DROP PROCEDURE IF EXISTS listar_locales;

-- ==========
-- | Ciudad |
-- ==========
DROP PROCEDURE IF EXISTS listar_ciudades;
DROP PROCEDURE IF EXISTS obtener_ciudad_por_id;

-- ===========
-- | Empresa |
-- ===========
DROP PROCEDURE IF EXISTS insertar_empresa;
DROP PROCEDURE IF EXISTS modificar_empresa;
DROP PROCEDURE IF EXISTS listar_empresa;
DROP PROCEDURE IF EXISTS eliminar_empresa;

-- =====================
-- | Historial Clínico |
-- =====================
DROP PROCEDURE IF EXISTS insertar_historial_clinico;
DROP PROCEDURE IF EXISTS modificar_historial_clinico;
DROP PROCEDURE IF EXISTS eliminar_historial_clinico;
DROP PROCEDURE IF EXISTS listar_historial_paciente_con_citas;

-- ==================
-- | Disponibilidad |
-- ==================
DROP PROCEDURE IF EXISTS insertar_disponibilidad;
DROP PROCEDURE IF EXISTS modificar_disponibilidad;
DROP PROCEDURE IF EXISTS obtener_disponibilidad_por_id;
DROP PROCEDURE IF EXISTS listar_todas_disponibilidades;
DROP PROCEDURE IF EXISTS eliminar_disponibilidad;

-- ===============
-- | Consultorio |
-- ===============
DROP PROCEDURE IF EXISTS insertar_consultorio;
DROP PROCEDURE IF EXISTS modificar_consultorio;
DROP PROCEDURE IF EXISTS eliminar_consultorio;
DROP PROCEDURE IF EXISTS obtener_consultorio_por_id;
DROP PROCEDURE IF EXISTS listar_consultorios;
DROP PROCEDURE IF EXISTS listar_consultorios_por_local;
DROP PROCEDURE IF EXISTS listar_consultorios_por_local_y_medico;

-- ===============
-- | Especialidad |
-- ===============
DROP PROCEDURE IF EXISTS insertar_especialidad;
DROP PROCEDURE IF EXISTS modificar_especialidad;
DROP PROCEDURE IF EXISTS eliminar_especialidad;
DROP PROCEDURE IF EXISTS listar_especialidades;
DROP PROCEDURE IF EXISTS obtener_especialidad_por_id;

-- ===============
-- | Departamento |
-- ===============
DROP PROCEDURE IF EXISTS insertar_departamento;
DROP PROCEDURE IF EXISTS modificar_departamento;
DROP PROCEDURE IF EXISTS eliminar_departamento;
DROP PROCEDURE IF EXISTS listar_departamentos;

-- ======================
-- | Local-Especialidad |
-- ======================
DROP PROCEDURE IF EXISTS insertar_local_especialidad;
DROP PROCEDURE IF EXISTS eliminar_local_especialidad;
DROP PROCEDURE IF EXISTS listar_especialidades_por_local;

-- ========================================================================================================================
-- 													EXTRA
-- ========================================================================================================================

-- =======================
-- | Funcionalidad Login |
-- =======================
DROP PROCEDURE IF EXISTS login_usuario;

-- =============================
-- | Roles de Usuario en Login |
-- =============================
DROP PROCEDURE IF EXISTS obtener_roles_usuario;

-- =======================
-- | Reportes por fechas |
-- =======================
DROP PROCEDURE IF EXISTS reporte_citas_por_fecha;
DROP PROCEDURE IF EXISTS reporte_diagnosticos_por_fecha;

-- =================================
-- | Citas por Local y Consultorio |
-- =================================
DROP PROCEDURE IF EXISTS obtener_citas_por_local_y_consultorio;

-- ===============================
-- | Diagnostico por Cita Médica |
-- ===============================
DROP PROCEDURE IF EXISTS obtener_diagnostico_por_cita;

-- ===============================
-- | Tratamiento por Cita Médica |
-- ===============================
DROP PROCEDURE IF EXISTS obtener_tratamiento_por_cita;

-- ================================
-- | Citas de Médicos y Pacientes |
-- ================================
DROP PROCEDURE IF EXISTS listar_citas_por_medico;
DROP PROCEDURE IF EXISTS listar_citas_por_paciente;
DROP PROCEDURE IF EXISTS obtener_proxima_cita_por_paciente;
DROP PROCEDURE IF EXISTS obtener_proxima_cita_por_medico;
DROP PROCEDURE IF EXISTS listar_citas_futuras_por_paciente;
DROP PROCEDURE IF EXISTS listar_citas_futuras_por_medico;

DROP PROCEDURE IF EXISTS ObtenerDocIdentidadPersona;