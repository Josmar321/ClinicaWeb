-- ==============================
-- | SCRIPT 05: Datos de Prueba |
-- ==============================

-- ======================
-- | Tabla Especialidad |
-- ======================

INSERT INTO Especialidad (nombre) VALUES 
('Pediatría'),
('Cardiología'),
('Dermatología'),
('Neurología'),
('Ginecología');

-- =================
-- | Tabla Usuario |
-- =================

INSERT INTO Usuario (username, password, rol) VALUES 
('admin001', MD5('adminpass123'), 'ADMINISTRADOR'),
('medico001', MD5('medicopass123'), 'MEDICO'),
('medico002', MD5('medicopass456'), 'MEDICO'),
('medico003', MD5('medicopass789'), 'MEDICO'),
('medico004', MD5('medicopass101'), 'MEDICO'),
('medico005', MD5('medicopass202'), 'MEDICO'),
('paciente001', MD5('pacientepass123'), 'PACIENTE'),
('paciente002', MD5('pacientepass456'), 'PACIENTE'),
('adminprueba1', MD5('pruebaadmin1'), 'ADMINISTRADOR'),
('admindoctor1', MD5('pruebadoctor1'), 'MEDICO'),
('adminpaciente1', MD5('pacienteprueba1'), 'PACIENTE');

-- ================
-- | Tabla Medico |
-- ================

-- Insertar en Persona
INSERT INTO Persona (
    docIdentidad, nombres, primerApellido, segundoApellido, telefono, direccion, email,
    fechaNacimiento, genero, idUsuario, ciudad_id, departamento_id
) VALUES 
('12345678', 'Carlos', 'Ramírez', 'Flores', '987654321', 'Av. Salud 123', 'carlos.ramirez@correo.com',
 '1980-05-20', 'M', 2, 1, 1),
('87654321', 'Lucía', 'Gómez', 'Torres', '912345678', 'Jr. Médico 456', 'lucia.gomez@correo.com',
 '1975-11-12', 'F', 3, 2, 1),
('33334444', 'Luis', 'Torres', 'Campos', '900123456', 'Av. Las Palmas 100', 'luis.torres@correo.com',
 '1982-01-01', 'M', 4, 3, 1),
('44445555', 'Ana', 'Valverde', 'Ríos', '900234567', 'Calle Los Cedros 200', 'ana.valverde@correo.com',
 '1987-02-02', 'F', 5, 2, 1),
('55556666', 'Elena', 'Muñoz', 'Silva', '900345678', 'Jr. Jardines 300', 'elena.munoz@correo.com',
 '1990-03-03', 'F', 6, 3, 1);

-- Insertar en Medico
INSERT INTO Medico (codigoMedico, numeroColegiatura, idEspecialidad) VALUES
('33334444', 'CMP009001', 1),
('12345678', 'CMP001234', 2),
('87654321', 'CMP005678', 3),
('44445555', 'CMP009002', 4),
('55556666', 'CMP009003', 5);

-- ==================
-- | Tabla Paciente |
-- ==================

-- Insertar en Persona
INSERT INTO Persona (
    docIdentidad, nombres, primerApellido, segundoApellido, telefono, direccion, email,
    fechaNacimiento, genero, idUsuario, ciudad_id, departamento_id
) VALUES 
('11112222', 'Javier', 'Quispe', 'Mendoza', '955667788', 'Calle Esperanza 101', 'javier.quispe@correo.com',
 '2000-03-10', 'M', 7, 1, 1),
('22221111', 'María', 'Rojas', 'Palacios', '966778899', 'Av. Libertad 202', 'maria.rojas@correo.com',
 '1998-07-25', 'F', 8, 1, 1);

-- Insertar en Paciente
INSERT INTO Paciente (codigoPaciente, peso, altura, tipoDeSangreID) VALUES
('11112222', 70.5, 1.75, 1),
('22221111', 60.2, 1.62, 8);

-- =======================
-- | Tabla Administrador |
-- =======================

-- Insertar en Persona
INSERT INTO Persona (
    docIdentidad, nombres, primerApellido, segundoApellido, telefono, direccion, email,
    fechaNacimiento, genero, idUsuario, ciudad_id, departamento_id
) VALUES 
('99998888', 'Andrea', 'Salinas', 'Velarde', '901112233', 'Av. Central 789', 'andrea.salinas@clinica.com',
 '1990-08-15', 'F', 1, 1, 1);

-- Insertar en Administrador
INSERT INTO Administrador (codigoAdministrador) VALUES
('99998888');

-- ========================
-- | Tabla Disponibilidad |
-- ========================

-- Disponibilidad para el médico '12345678' (Carlos Ramírez)
INSERT INTO Disponibilidad (dia, horaInicio, horaFin, codigoMedico) VALUES
('LUNES', '08:00:00', '12:00:00', '12345678'),
('MIERCOLES', '14:00:00', '18:00:00', '12345678'),
('VIERNES', '08:00:00', '12:00:00', '12345678');

-- Disponibilidad para el médico '87654321' (Lucía Gómez)
INSERT INTO Disponibilidad (dia, horaInicio, horaFin, codigoMedico) VALUES
('MARTES', '09:00:00', '13:00:00', '87654321'),
('JUEVES', '15:00:00', '19:00:00', '87654321'),
('SABADO', '08:00:00', '11:00:00', '87654321');

-- Disponibilidad para el médico '33334444' (Luis Torres - Pediatría)
INSERT INTO Disponibilidad (dia, horaInicio, horaFin, codigoMedico) VALUES
('LUNES', '09:00:00', '13:00:00', '33334444'),
('MIERCOLES', '15:00:00', '18:00:00', '33334444');

-- Disponibilidad para el médico '44445555' (Ana Valverde - Neurología)
INSERT INTO Disponibilidad (dia, horaInicio, horaFin, codigoMedico) VALUES
('MARTES', '08:30:00', '12:30:00', '44445555'),
('VIERNES', '14:00:00', '17:00:00', '44445555');

-- Disponibilidad para el médico '55556666' (Elena Muñoz - Ginecología)
INSERT INTO Disponibilidad (dia, horaInicio, horaFin, codigoMedico) VALUES
('JUEVES', '09:00:00', '12:00:00', '55556666'),
('SABADO', '13:00:00', '16:00:00', '55556666');


-- =================
-- | Tabla Empresa |
-- =================

INSERT INTO Empresa (
    razonSocial, ruc, telefonoDeContacto, linkInstagram, linkFacebook
) VALUES (
    'NeoSalud', '20987654321', '901234567',
    'https://instagram.com/neosalud',
    'https://facebook.com/neosalud'
);

-- ===============
-- | Tabla Local |
-- ===============

INSERT INTO Local (
    direccion, ubigeo, ciudad_id, departamento_id, idEmpresa
) VALUES 
('Av. Salud 999, San Borja', '150101', 1, 1, 1),
('Jr. Pacífico 456, Chosica', '150102', 2, 1, 1),
('Calle Central 789, SJL', '150103', 3, 1, 1);

-- =====================
-- | Tabla Consultorio |
-- =====================

INSERT INTO Consultorio (numConsultorio, piso, idLocal, codigoMedico) VALUES
(101, 1, 1, '12345678'),
(102, 1, 2, '87654321'),
(103, 2, 3, '33334444'),
(104, 3, 1, '44445555'),
(105, 2, 2, '55556666');

-- ==========================
-- | Tabla HistorialClinico |
-- ==========================

INSERT INTO HistorialClinico (
    fechaCreacion, obsGenerales, codigoPaciente, idCitaMedica
) VALUES 
('2024-05-01', 'Paciente con antecedentes de alergia estacional.', '11112222', NULL),
('2024-05-15', 'Paciente presenta historial de migraña leve.', '22221111', NULL);

-- ====================
-- | Tabla CitaMedica |
-- ====================

INSERT INTO CitaMedica (
    fecha, hora, precio, estado, modalidad,
    codigoPaciente, codigoMedico, idConsultorio, idHistorial
) VALUES 
('2024-06-01', '09:00:00', 150.00, 'REALIZADA', 'PRESENCIAL',
 '11112222', '12345678', 1, NULL),  -- Consultorio 1 de Carlos Ramírez

('2024-06-03', '10:30:00', 130.00, 'REALIZADA', 'PRESENCIAL',
 '22221111', '87654321', 2, NULL);  -- Consultorio 2 de Lucía Gómez
 
 -- Cita programada con Pediatría
INSERT INTO CitaMedica (
    fecha, hora, precio, estado, modalidad,
    codigoPaciente, codigoMedico, idConsultorio, idHistorial
) VALUES 
('2024-06-10', '08:00:00', 120.00, 'PROGRAMADA', 'PRESENCIAL',
 '11112222', '33334444', 3, NULL);

-- Cita programada con Neurología
INSERT INTO CitaMedica (
    fecha, hora, precio, estado, modalidad,
    codigoPaciente, codigoMedico, idConsultorio, idHistorial
) VALUES 
('2024-06-11', '10:00:00', 160.00, 'PROGRAMADA', 'VIRTUAL',
 '22221111', '44445555', 4, NULL);

-- Cita programada con Ginecología
INSERT INTO CitaMedica (
    fecha, hora, precio, estado, modalidad,
    codigoPaciente, codigoMedico, idConsultorio, idHistorial
) VALUES 
('2024-06-15', '09:30:00', 140.00, 'PROGRAMADA', 'PRESENCIAL',
 '22221111', '55556666', 5, NULL);


-- =====================
-- | Tabla Diagnostico |
-- =====================
INSERT INTO Diagnostico (
    idDiagnostico, descripcionDiagnostico, fecha, idCitaMedica
) VALUES
(1, 'Diagnóstico de hipertensión arterial leve.', '2024-06-01', 1),
(2, 'Diagnóstico de dermatitis por contacto.', '2024-06-03', 2);

-- =====================
-- | Tabla Tratamiento |
-- =====================
INSERT INTO Tratamiento (
    idTratamiento, descripcionTratamiento, idCitaMedica
) VALUES
(1, 'Tratamiento con dieta baja en sodio y ejercicio regular.', 1),
(2, 'Aplicación de crema tópica y evitar alérgenos.', 2);

-- ======================================
-- | Tabla intermedia localEspecialidad |
-- ======================================

INSERT INTO LocalEspecialidad (idLocal, idEspecialidad) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 1);


//

-- =====================================================================
-- === SCRIPT PARA CREAR Y ASIGNAR HISTORIALES CLÍNICOS FALTANTES    ===
-- =====================================================================

-- PASO 1: Crear historiales para todos los pacientes que aún no tienen uno.
-- Usamos INSERT IGNORE para que no falle si un historial ya existe con el mismo ID (aunque no debería pasar si la PK es AUTO_INCREMENT).
-- Esta consulta toma a todos los pacientes únicos de la tabla Paciente y les crea un historial.
INSERT INTO HistorialClinico (fechaCreacion, obsGenerales, codigoPaciente, activo)
SELECT
    CURDATE(), -- Usa la fecha actual como fecha de creación
    'Historial creado automáticamente por script de mantenimiento.', -- Observación por defecto
    p.codigoPaciente, -- El código del paciente
    TRUE -- Activo
FROM 
    Paciente p
WHERE 
    p.codigoPaciente NOT IN (SELECT hc.codigoPaciente FROM HistorialClinico hc WHERE hc.codigoPaciente IS NOT NULL);

-- PASO 2: Actualizar TODAS las citas que tengan idHistorial en NULL.
-- Esta consulta busca el idHistorial correcto para cada cita y lo actualiza.
UPDATE 
    CitaMedica c
JOIN 
    HistorialClinico hc ON c.codigoPaciente = hc.codigoPaciente
SET 
    c.idHistorial = hc.idHistorial
WHERE 
    c.idHistorial IS NULL;

-- PASO 3: (Opcional) Verificar el resultado.
-- Esta consulta te mostrará que ahora todas las citas tienen un idHistorial asignado.
SELECT idCitaMedica, codigoPaciente, idHistorial FROM CitaMedica;
