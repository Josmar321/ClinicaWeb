-- =========================================
-- | SCRIPT 04: Procedimientos Almacenados |
-- =========================================

-- ===========================
-- | PROCEDIMIENTOS: PERSONA |
-- ===========================

DELIMITER $$

CREATE PROCEDURE insertar_persona (
    IN p_docIdentidad VARCHAR(20),
    IN p_nombres VARCHAR(100),
    IN p_primerApellido VARCHAR(50),
    IN p_segundoApellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(255),
    IN p_email VARCHAR(100),
    IN p_fechaNacimiento DATE,
    IN p_genero CHAR(1),
    IN p_foto MEDIUMBLOB,
    IN p_idUsuario INT,
    IN p_idDepartamento INT,
    IN p_idCiudad INT
)
BEGIN
    INSERT INTO Persona (
        docIdentidad, nombres, primerApellido, segundoApellido, telefono,
        direccion, email, fechaNacimiento, genero, foto, idUsuario, ciudad_id, departamento_id
    ) VALUES (
        p_docIdentidad, p_nombres, p_primerApellido, p_segundoApellido, p_telefono,
        p_direccion, p_email, p_fechaNacimiento, p_genero, p_foto, p_idUsuario,p_idDepartamento,
     	p_idCiudad
    );
END $$

DELIMITER $$

CREATE PROCEDURE modificar_persona (
    IN p_docIdentidad VARCHAR(20),
    IN p_nombres VARCHAR(100),
    IN p_primerApellido VARCHAR(50),
    IN p_segundoApellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(255),
    IN p_email VARCHAR(100),
    IN p_fechaNacimiento DATE,
    IN p_genero CHAR(1),
    IN p_foto MEDIUMBLOB,
    IN p_idUsuario VARCHAR(50)
)
BEGIN
    UPDATE Persona
    SET 
        nombres = p_nombres,
        primerApellido = p_primerApellido,
        segundoApellido = p_segundoApellido,
        telefono = p_telefono,
        direccion = p_direccion,
        email = p_email,
        fechaNacimiento = p_fechaNacimiento,
        genero = p_genero,
        foto = p_foto,
        idUsuario = idUsuario
    WHERE docIdentidad = p_docIdentidad;
END $$

DELIMITER $$

CREATE PROCEDURE eliminar_persona (
    IN p_docIdentidad VARCHAR(20)
)
BEGIN
    UPDATE Persona
    SET activo = FALSE
    WHERE docIdentidad = p_docIdentidad;
END $$
	
DELIMITER $$	
CREATE PROCEDURE listar_personas()
BEGIN
    SELECT 
        docIdentidad,
        nombres,
        primerApellido,
        segundoApellido,
        telefono,
        direccion,
        email,
        fechaNacimiento,
        genero,
        foto,
        idUsuario
    FROM Persona
    WHERE activo = TRUE;
END $$

DELIMITER $$

CREATE PROCEDURE obtener_persona_por_docIdentidad (
    IN p_docIdentidad VARCHAR(20)
)
BEGIN
    SELECT 
        docIdentidad,
        nombres,
        primerApellido,
        segundoApellido,
        telefono,
        direccion,
        email,
        fechaNacimiento,
        genero,
        foto,
        idUsuario
    FROM Persona
    WHERE docIdentidad = p_docIdentidad;
END $$

DELIMITER $$


-- ===========
-- | USUARIO | -----------------------------------------------------------------------------------------------------------------
-- ===========

CREATE PROCEDURE insertar_usuario(
    OUT p_id_usuario INT,
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(100),
    IN p_rol ENUM('ADMINISTRADOR', 'MEDICO', 'PACIENTE')
)
BEGIN
    INSERT INTO Usuario (username, password, rol, activo)
    VALUES (p_username, MD5(p_password), p_rol, TRUE);
    
    SET p_id_usuario = LAST_INSERT_ID();
END$$

CREATE PROCEDURE verificar_usuario (
    IN p_username VARCHAR(100),
    IN p_password VARCHAR(100),
    OUT p_existe BOOLEAN,
    OUT p_rol VARCHAR(50)
)
BEGIN
DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM Usuario
    WHERE username = p_username
      AND password = MD5(p_password)
      AND activo = TRUE;

    IF v_count > 0 THEN
        SET p_existe = TRUE;
        SELECT rol INTO p_rol
        FROM Usuario
        WHERE username = p_username
          AND password = MD5(p_password)
          AND activo = TRUE
        LIMIT 1;
    ELSE
        SET p_existe = FALSE;
        SET p_rol = NULL;
    END IF;
END$$


CREATE PROCEDURE modificar_usuario (
    IN p_id_usuario INT,
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(100),
    IN p_rol ENUM('ADMINISTRADOR', 'MEDICO', 'PACIENTE'),
    IN p_activo BOOLEAN
)
BEGIN
    UPDATE Usuario
    SET username = p_username,
        password = IF(p_password IS NOT NULL AND p_password <> '', MD5(p_password), password),
        rol = p_rol,
        activo = p_activo
    WHERE idUsuario = p_id_usuario;
END$$

CREATE PROCEDURE eliminar_usuario (
    IN p_id_usuario INT
)
BEGIN
    UPDATE Usuario 
    SET activo = FALSE 
    WHERE idUsuario = p_id_usuario;
END$$

CREATE PROCEDURE eliminar_usuario_username (
    IN p_username VARCHAR(50)
)
BEGIN
    UPDATE Usuario 
    SET activo = FALSE 
    WHERE username = p_username;
END$$

CREATE PROCEDURE obtener_usuario_por_username (
    IN p_username VARCHAR(50)
)
BEGIN
    SELECT *
    FROM Usuario
    WHERE username = p_username AND activo = TRUE;
END$$

CREATE PROCEDURE obtener_usuario_por_id (
    IN p_id_usuario INT
)
BEGIN
    SELECT *
    FROM Usuario
    WHERE idUsuario = p_id_usuario AND activo = TRUE;
END$$

CREATE PROCEDURE listar_usuarios()
BEGIN
    SELECT * FROM Usuario;
END$$

-- ==========
-- | MÉDICO |-----------------------------------------------------------------------------------------------------------------
-- ==========

CREATE PROCEDURE insertar_medico (
    IN p_codigoMedico VARCHAR(20),
    IN p_idEspecialidad INT,
    IN p_numeroColegiatura VARCHAR(20)
)
BEGIN
    INSERT INTO Medico (codigoMedico, idEspecialidad, numeroColegiatura, activo)
    VALUES (p_codigoMedico, p_idEspecialidad, p_numeroColegiatura, TRUE);
END $$

CREATE PROCEDURE modificar_medico (
    IN p_docIdentidad VARCHAR(20),
    IN p_nombres VARCHAR(100),
    IN p_primerApellido VARCHAR(50),
    IN p_segundoApellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(255),
    IN p_email VARCHAR(100),
    IN p_fechaNacimiento DATE,
    IN p_genero CHAR(1),
    IN p_foto MEDIUMBLOB,
    IN p_ciudad INT,
    IN p_departamento INT,
    IN p_numeroColegiatura VARCHAR(20),
    IN p_idEspecialidad INT
)
BEGIN
    UPDATE Persona
    SET 
        nombres = p_nombres,
        primerApellido = p_primerApellido,
        segundoApellido = p_segundoApellido,
        telefono = p_telefono,
        direccion = p_direccion,
        email = p_email,
        fechaNacimiento = p_fechaNacimiento,
        genero = p_genero,
        foto = p_foto,
		ciudad_id = p_ciudad,
        departamento_id = p_departamento
    WHERE docIdentidad = p_docIdentidad;

    UPDATE Medico
    SET 
        idEspecialidad = p_idEspecialidad,
        numeroColegiatura = p_numeroColegiatura
    WHERE codigoMedico = p_docIdentidad;
END $$

DELIMITER $$
CREATE PROCEDURE listar_medicos()
BEGIN
    SELECT 
        p.docIdentidad, p.nombres, p.primerApellido, p.segundoApellido,
        p.telefono, p.direccion, p.email, p.fechaNacimiento, p.genero, p.foto,
        m.codigoMedico, m.numeroColegiatura, m.activo, 
        m.idEspecialidad, p.ciudad_id, p.departamento_id,
        c.nombre as ciudad_nombre, d.nombre as departamento_nombre,
        e.nombre AS nombreEspecialidad
    FROM Persona p
    INNER JOIN Medico m ON p.docIdentidad = m.codigoMedico
    INNER JOIN Especialidad e ON m.idEspecialidad = e.idEspecialidad
    INNER JOIN Ciudad c ON p.ciudad_id = c.id
    INNER JOIN Departamento d ON p.departamento_id = d.id;
END$$

DELIMITER $$
CREATE PROCEDURE obtener_medico_por_id (
    IN p_codigoMedico VARCHAR(20)
)
BEGIN
    SELECT 
        p.docIdentidad, p.nombres, p.primerApellido, p.segundoApellido,
        p.telefono, p.direccion, p.email, p.fechaNacimiento, p.genero, p.foto,
        m.codigoMedico, m.numeroColegiatura, m.activo,
        m.idEspecialidad, p.ciudad_id, p.departamento_id,
        c.nombre as ciudad_nombre, d.nombre as departamento_nombre,
        e.nombre AS nombreEspecialidad
    FROM Persona p
    INNER JOIN Medico m ON p.docIdentidad = m.codigoMedico
    INNER JOIN Especialidad e ON m.idEspecialidad = e.idEspecialidad
    INNER JOIN Ciudad c ON p.ciudad_id = c.id
    INNER JOIN Departamento d ON p.departamento_id = d.id
    WHERE m.codigoMedico = p_codigoMedico;
END $$

DELIMITER $$

CREATE PROCEDURE eliminar_medico (
    IN p_codigoMedico VARCHAR(20)
)
BEGIN
    -- Desactivar en la tabla Medico
    UPDATE Medico
    SET activo = FALSE
    WHERE codigoMedico = p_codigoMedico;

    -- Desactivar en la tabla Persona
    UPDATE Persona
    SET activo = FALSE
    WHERE docIdentidad = p_codigoMedico;
END $$


CREATE PROCEDURE obtener_medicos_para_cita_medica (
    IN _idLocal INT,
    IN _idEspecialidad INT,
    IN _diaSemana ENUM('LUNES','MARTES','MIERCOLES','JUEVES','VIERNES','SABADO','DOMINGO')
)
BEGIN
    SELECT DISTINCT 
        m.codigoMedico,
        p.nombres,
        p.primerApellido,
        p.segundoApellido,
        m.numeroColegiatura,
        e.idEspecialidad,
        e.nombre AS nombreEspecialidad,
        m.activo
    FROM Medico m
    INNER JOIN Persona p ON m.codigoMedico = p.docIdentidad
    INNER JOIN Especialidad e ON m.idEspecialidad = e.idEspecialidad
    INNER JOIN Consultorio c ON m.codigoMedico = c.codigoMedico
    INNER JOIN Local l ON c.idLocal = l.idLocal
    INNER JOIN Disponibilidad d ON m.codigoMedico = d.codigoMedico
    INNER JOIN LocalEspecialidad le ON le.idLocal = l.idLocal AND le.idEspecialidad = e.idEspecialidad
    WHERE m.activo = TRUE
      AND e.activo = TRUE
      AND c.activo = TRUE
      AND l.activo = TRUE
      AND d.activo = TRUE
      AND le.activo = TRUE
      AND l.idLocal = _idLocal
      AND e.idEspecialidad = _idEspecialidad
      AND d.dia = _diaSemana;
END$$



-- ============
-- | PACIENTE | -----------------------------------------------------------------------------------------------------------------
-- ============
DELIMITER $$

CREATE PROCEDURE insertar_paciente (
    IN p_tipoSangre INT,
    IN p_peso DOUBLE,
    IN p_altura DOUBLE,
    IN p_codigoPaciente VARCHAR(20)
)
BEGIN
    INSERT INTO Paciente (tipoDeSangreID, peso, altura, codigoPaciente, activo)
    VALUES (p_tipoSangre, p_peso, p_altura, p_codigoPaciente, TRUE);
END $$

CREATE PROCEDURE modificar_paciente (
    IN p_docIdentidad VARCHAR(20),
    IN p_nombres VARCHAR(100),
    IN p_primerApellido VARCHAR(50),
    IN p_segundoApellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(255),
    IN p_email VARCHAR(100),
    IN p_fechaNacimiento DATE,
    IN p_genero CHAR(1),
    IN p_foto MEDIUMBLOB,
    IN p_ciudad INT,
    IN p_departamento INT,
    IN p_tipoSangre INT,
    IN p_peso DOUBLE,
    IN p_altura DOUBLE
)
BEGIN
    UPDATE Persona
    SET 
        nombres = p_nombres,
        primerApellido = p_primerApellido,
        segundoApellido = p_segundoApellido,
        telefono = p_telefono,
        direccion = p_direccion,
        email = p_email,
        fechaNacimiento = p_fechaNacimiento,
        genero = p_genero,
        foto = p_foto,
        ciudad_id = p_ciudad,
        departamento_id = p_departamento
    WHERE docIdentidad = p_docIdentidad;

    UPDATE Paciente
    SET 
        tipoDeSangreID = p_tipoSangre,
        peso = p_peso,
        altura = p_altura
    WHERE codigoPaciente = p_docIdentidad;
END $$

CREATE PROCEDURE eliminar_paciente (
    IN p_codigoPaciente VARCHAR(20)
)
BEGIN
    UPDATE Paciente
    SET activo = FALSE
    WHERE codigoPaciente = p_codigoPaciente;
    
    -- Desactivar en la tabla Persona
    UPDATE Persona
    SET activo = FALSE
    WHERE docIdentidad = p_codigoPaciente;
END $$

DELIMITER $$

CREATE PROCEDURE listar_pacientes()
BEGIN
    SELECT
        p.docIdentidad, p.nombres, p.primerApellido, p.segundoApellido,
        p.telefono, p.direccion, p.email, p.fechaNacimiento, p.genero,
        p.foto, pa.codigoPaciente, pa.tipoDeSangreID, pa.peso,
        pa.altura, pa.activo,
        c.id AS ciudad_id, c.nombre AS ciudad_nombre,
        d.id AS departamento_id, d.nombre AS departamento_nombre,
        ts.id AS tipoDeSangre_id, ts.tipo AS tipoSangre_nombre
    FROM Persona p
    INNER JOIN Paciente pa ON p.docIdentidad = pa.codigoPaciente
    INNER JOIN Ciudad c ON p.ciudad_id = c.id
    INNER JOIN Departamento d ON p.departamento_id = d.id
    INNER JOIN TipoDeSangre ts ON pa.tipoDeSangreID = ts.id;
END $$

DELIMITER $$

CREATE PROCEDURE obtener_paciente_por_id (
    IN p_codigoPaciente VARCHAR(20)
)
BEGIN
    SELECT
        p.docIdentidad, p.nombres, p.primerApellido, p.segundoApellido,
        p.telefono, p.direccion, p.email, p.fechaNacimiento, p.genero,
        p.foto, pa.codigoPaciente, pa.tipoDeSangreID, pa.peso,
        pa.altura, pa.activo,
        c.id AS ciudad_id, c.nombre AS ciudad_nombre,
        d.id AS departamento_id, d.nombre AS departamento_nombre,
        ts.id AS tipoDeSangre_id, ts.tipo AS tipoSangre_nombre
    FROM Persona p
    INNER JOIN Paciente pa ON p.docIdentidad = pa.codigoPaciente
    INNER JOIN Ciudad c ON p.ciudad_id = c.id
    INNER JOIN Departamento d ON p.departamento_id = d.id
    INNER JOIN TipoDeSangre ts ON pa.tipoDeSangreID = ts.id
    WHERE pa.codigoPaciente = p_codigoPaciente;
END $$

-- =================
-- | ADMINISTRADOR |
-- =================

CREATE PROCEDURE insertar_administrador (
    IN p_codigoAdministrador VARCHAR(20)
)
BEGIN
    INSERT INTO Administrador (codigoAdministrador, activo)
    VALUES (p_codigoAdministrador, TRUE);
END $$

CREATE PROCEDURE modificar_administrador (
    IN p_docIdentidad VARCHAR(20),
    IN p_nombres VARCHAR(100),
    IN p_primerApellido VARCHAR(50),
    IN p_segundoApellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_direccion VARCHAR(255),
    IN p_email VARCHAR(100),
    IN p_fechaNacimiento DATE,
    IN p_genero CHAR(1),
    IN p_foto MEDIUMBLOB,
    IN p_ciudad INT,
    IN p_departamento INT
)
BEGIN
    UPDATE Persona
    SET 
        nombres = p_nombres,
        primerApellido = p_primerApellido,
        segundoApellido = p_segundoApellido,
        telefono = p_telefono,
        direccion = p_direccion,
        email = p_email,
        fechaNacimiento = p_fechaNacimiento,
        genero = p_genero,
        foto = p_foto,
        ciudad_id = p_ciudad,
        departamento_id = p_departamento
    WHERE docIdentidad = p_docIdentidad;
END $$

CREATE PROCEDURE listar_administradores()
BEGIN
    SELECT 
        p.docIdentidad, p.nombres, p.primerApellido, p.segundoApellido,
        p.telefono, p.direccion, p.email, p.fechaNacimiento, p.genero, p.foto,
        a.activo, p.ciudad_id, p.departamento_id,
        c.nombre as ciudad_nombre, d.nombre as departamento_nombre
    FROM Persona p
    INNER JOIN Administrador a ON p.docIdentidad = a.codigoAdministrador
    INNER JOIN Ciudad c ON p.ciudad_id = c.id
    INNER JOIN Departamento d ON p.departamento_id = d.id;
END $$

CREATE PROCEDURE obtener_administrador_por_id (
    IN p_codigoAdministrador VARCHAR(20)
)
BEGIN
    SELECT 
        p.docIdentidad, p.nombres, p.primerApellido, p.segundoApellido,
        p.telefono, p.direccion, p.email, p.fechaNacimiento, p.genero, p.foto,
        a.activo, p.ciudad_id, p.departamento_id,
        c.nombre as ciudad_nombre, d.nombre as departamento_nombre
    FROM Persona p
    INNER JOIN Administrador a ON p.docIdentidad = a.codigoAdministrador
    INNER JOIN Ciudad c ON p.ciudad_id = c.id
    INNER JOIN Departamento d ON p.departamento_id = d.id
    WHERE a.codigoAdministrador = p_codigoAdministrador;
END $$

CREATE PROCEDURE eliminar_administrador (
    IN p_codigoAdministrador VARCHAR(20)
)
BEGIN
    UPDATE Administrador 
    SET activo = FALSE 
    WHERE codigoAdministrador = p_codigoAdministrador;
    
    -- Desactivar en la tabla Persona
    UPDATE Persona
    SET activo = FALSE
    WHERE docIdentidad = p_codigoAdministrador;
END $$

-- ===============
-- | CITA MÉDICA | -----------------------------------------------------------------------------------------------------------------
-- ===============

CREATE PROCEDURE insertar_cita_medica (
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_precio DOUBLE,
    IN p_estado ENUM('PROGRAMADA', 'CANCELADA', 'REALIZADA'),
    IN p_modalidad ENUM('PRESENCIAL', 'VIRTUAL'),
    IN p_codigoPaciente VARCHAR(20),
    IN p_codigoMedico VARCHAR(20),
    IN p_idConsultorio INT,
    IN p_idHistorial INT
)
BEGIN
    INSERT INTO CitaMedica (fecha, hora, precio, estado, modalidad, codigoPaciente, codigoMedico, idConsultorio, idHistorial, activo)
    VALUES (p_fecha, p_hora, p_precio, p_estado, p_modalidad, p_codigoPaciente, p_codigoMedico, p_idConsultorio, p_idHistorial, TRUE);
END$$

-- Modificar General
CREATE PROCEDURE modificar_cita_medica_administrador (
    IN p_idCitaMedica INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_precio DOUBLE,
    IN p_estado ENUM('PROGRAMADA', 'CANCELADA', 'REALIZADA'),
    IN p_modalidad ENUM('PRESENCIAL', 'VIRTUAL'),
    IN p_codigoPaciente VARCHAR(20),
    IN p_codigoMedico VARCHAR(20),
    IN p_idConsultorio INT,
    IN p_idHistorial INT,
    IN p_activo BOOLEAN
)
BEGIN
    UPDATE CitaMedica
    SET 
        fecha = p_fecha,
        hora = p_hora,
        precio = p_precio,
        estado = p_estado,
        modalidad = p_modalidad,
        codigoPaciente = p_codigoPaciente,
        codigoMedico = p_codigoMedico,
        idConsultorio = p_idConsultorio,
        idHistorial = p_idHistorial,
        activo = p_activo
    WHERE idCitaMedica = p_idCitaMedica;
END$$

CREATE PROCEDURE modificar_cita_medica_medico (
    IN p_idCitaMedica INT,
    IN p_hora TIME,
    IN p_estado ENUM('PROGRAMADA', 'CANCELADA', 'REALIZADA'),
    IN p_modalidad ENUM('PRESENCIAL', 'VIRTUAL'),
    IN p_activo BOOLEAN
)
BEGIN
    UPDATE CitaMedica
    SET 
        hora = p_hora,
        estado = p_estado,
        modalidad = p_modalidad,
        activo = p_activo
    WHERE idCitaMedica = p_idCitaMedica
    AND codigoMedico = (SELECT codigoMedico FROM CitaMedica WHERE idCitaMedica = p_idCitaMedica);
END$$


CREATE PROCEDURE modificar_cita_medica_paciente (
    IN p_idCitaMedica INT,
    IN p_hora TIME,
    IN p_modalidad ENUM('PRESENCIAL', 'VIRTUAL'),
    IN p_activo BOOLEAN
)
BEGIN
    DECLARE v_codigoPaciente VARCHAR(20);

    -- Guardar el código del paciente en una variable temporal
    SELECT codigoPaciente 
    INTO v_codigoPaciente 
    FROM CitaMedica 
    WHERE idCitaMedica = p_idCitaMedica;

    -- Realizar el update
    UPDATE CitaMedica
    SET 
        hora = p_hora,
        modalidad = p_modalidad,
        activo = p_activo
    WHERE idCitaMedica = p_idCitaMedica
      AND codigoPaciente = v_codigoPaciente;
END$$


CREATE PROCEDURE eliminar_cita_medica (
    IN p_idCitaMedica INT
)
BEGIN
    UPDATE CitaMedica 
    SET activo = FALSE 
    WHERE idCitaMedica = p_idCitaMedica AND activo = TRUE;
END$$

CREATE PROCEDURE cancelar_cita (
    IN p_idCitaMedica INT
)
BEGIN
    UPDATE CitaMedica
    SET estado = 'CANCELADA'
    WHERE idCitaMedica = p_idCitaMedica AND estado = 'PROGRAMADA';
END$$

CREATE PROCEDURE listar_citas_medicas()
BEGIN
    SELECT * FROM CitaMedica;
END$$

CREATE PROCEDURE obtener_cita_medica_por_id (
    IN p_idCitaMedica INT
)
BEGIN
    SELECT 
        cm.idCitaMedica,
        cm.fecha,
        cm.hora,
        cm.precio,
        cm.estado,
        cm.modalidad,
        cm.codigoPaciente,
        cm.codigoMedico,
        cm.idConsultorio,
        cm.idHistorial,
        cm.activo
    FROM 
        CitaMedica cm
    WHERE 
        cm.idCitaMedica = p_idCitaMedica;
END$$


-- ===============
-- | DIAGNÓSTICO | -----------------------------------------------------------------------------------------------------------------
-- ===============

CREATE PROCEDURE insertar_diagnostico (
    IN p_idCitaMedica INT,
    IN p_descripcion VARCHAR(255),
    IN p_fecha DATE
)
BEGIN
    INSERT INTO Diagnostico (idDiagnostico, descripcionDiagnostico, fecha)
    VALUES (p_idCitaMedica, p_descripcion, p_fecha);
END$$

CREATE PROCEDURE modificar_diagnostico (
    IN p_idDiagnostico INT,
    IN p_descripcion VARCHAR(255),
    IN p_fecha DATE
)
BEGIN
    UPDATE Diagnostico
    SET descripcionDiagnostico = p_descripcion,
        fecha = p_fecha
    WHERE idDiagnostico = p_idDiagnostico;
END$$

CREATE PROCEDURE eliminar_diagnostico (
    IN p_idDiagnostico INT
)
BEGIN
    UPDATE Diagnostico 
    SET activo = FALSE 
    WHERE idDiagnostico = p_idDiagnostico;
END$$

-- Listamos por id o mejor por citamedica
CREATE PROCEDURE obtener_diagnostico_por_id (
    IN p_idDiagnostico INT
)
BEGIN
    SELECT * FROM Diagnostico WHERE idDiagnostico = p_idDiagnostico;
END$$

CREATE PROCEDURE listar_diagnosticos()
BEGIN
    SELECT * FROM Diagnostico;
END$$

-- ===============
-- | TRATAMIENTO | --------------------------------------------------------------------------------------------------------
-- ===============

CREATE PROCEDURE insertar_tratamiento (
    IN p_idCitaMedica INT,
    IN p_descripcion VARCHAR(255)
)
BEGIN
    INSERT INTO Tratamiento (idTratamiento, descripcionTratamiento)
    VALUES (p_idCitaMedica, p_descripcion);
END$$

CREATE PROCEDURE modificar_tratamiento (
    IN p_idTratamiento INT,
    IN p_descripcion VARCHAR(255)
)
BEGIN
    UPDATE Tratamiento
    SET descripcionTratamiento = p_descripcion
    WHERE idTratamiento = p_idTratamiento;
END$$

CREATE PROCEDURE eliminar_tratamiento (
    IN p_idTratamiento INT
)
BEGIN
    UPDATE Tratamiento 
    SET activo = FALSE 
    WHERE idTratamiento = p_idTratamiento;
END$$

CREATE PROCEDURE obtener_tratamiento_por_id (
    IN p_idTratamiento INT
)
BEGIN
    SELECT * FROM Tratamiento WHERE idTratamiento = p_idTratamiento;
END$$

CREATE PROCEDURE listar_tratamientos()
BEGIN
    SELECT * FROM Tratamiento;
END$$

-- =========
-- | LOCAL | ------------------------------------------------------------------------------------------------------------
-- =========

CREATE PROCEDURE insertar_local (
    OUT _idLocal INT,
    IN _direccion VARCHAR(255),
    IN _ubigeo VARCHAR(10),
    IN _ciudad INT,
    IN _departamento INT,
    IN _idEmpresa INT
)
BEGIN
    INSERT INTO Local (direccion, ubigeo, ciudad_id, departamento_id, idEmpresa, activo)
    VALUES (_direccion, _ubigeo, _ciudad, _departamento, _idEmpresa, 1);
    SET _idLocal = @@last_insert_id;
END$$

CREATE PROCEDURE modificar_local (
    IN _idLocal INT,
    IN _direccion VARCHAR(255),
    IN _ubigeo VARCHAR(10),
    IN _ciudad_id INT,
    IN _departamento_id INT,
    IN _activo BOOLEAN
)
BEGIN
    UPDATE Local
    SET direccion = _direccion,
        ubigeo = _ubigeo,
        ciudad_id = _ciudad_id,
        departamento_id = _departamento_id,
        activo = _activo
    WHERE idLocal = _idLocal;
END$$

CREATE PROCEDURE eliminar_local (
    IN _idLocal INT
)
BEGIN
    UPDATE Local 
    SET activo = FALSE 
    WHERE idLocal = _idLocal;
END$$

CREATE PROCEDURE obtener_local_por_id (
    IN _idLocal INT
)
BEGIN
    SELECT * FROM Local WHERE idLocal = _idLocal;
END$$

CREATE PROCEDURE listar_locales()
BEGIN
    SELECT * FROM Local;
END$$

-- ==========
-- | CIUDAD | ------------------------------------------------------------------------------------------------------------
-- ==========

CREATE PROCEDURE listar_ciudades()
BEGIN
    SELECT 
        c.id AS idCiudad,
        c.nombre AS nombreCiudad,
        c.departamento_id,
        d.nombre AS nombreDepartamento,
        c.activo
    FROM Ciudad c
    INNER JOIN Departamento d ON c.departamento_id = d.id
    WHERE c.activo = TRUE;
END$$

CREATE PROCEDURE obtener_ciudad_por_id(
	IN _idCiudad INT
)
BEGIN
    SELECT 
        c.id AS idCiudad,
        c.nombre AS nombreCiudad,
        c.departamento_id,
        d.nombre AS nombreDepartamento,
        c.activo
    FROM Ciudad c
    INNER JOIN Departamento d ON c.departamento_id = d.id
    WHERE c.id = _idCiudad;
END$$


-- ===========
-- | EMPRESA | --------------------------------------------------------------------------------------------------------
-- ===========

CREATE PROCEDURE insertar_empresa (
    OUT _idEmpresa INT,
    IN _razonSocial VARCHAR(100),
    IN _ruc VARCHAR(20),
    IN _telefonoDeContacto VARCHAR(20),
    IN _logo MEDIUMBLOB,
    IN _linkInstagram VARCHAR(255),
    IN _linkFacebook VARCHAR(255)
)
BEGIN
    INSERT INTO Empresa (razonSocial, ruc, telefonoDeContacto, logo, linkInstagram, linkFacebook)
    VALUES (_razonSocial, _ruc, _telefonoDeContacto, _logo, _linkInstagram, _linkFacebook);
    SET _idEmpresa = @@last_insert_id;
END$$

CREATE PROCEDURE modificar_empresa (
    IN _idEmpresa INT,
    -- IN _nombre VARCHAR(100),
    -- IN _ruc VARCHAR(20),
    IN _telefonoDeContacto VARCHAR(20),
    IN _logo MEDIUMBLOB,
    IN _linkInstagram VARCHAR(255),
    IN _linkFacebook VARCHAR(255)
)
BEGIN
    UPDATE Empresa
    SET -- razonSocial = _razonSocial,
        -- ruc = _ruc,
        telefonoDeContacto = _telefonoDeContacto,
        logo = _logo,
        linkInstagram = _linkInstagram,
        linkFacebook = _linkFacebook
    WHERE idEmpresa = _idEmpresa;
END$$

CREATE PROCEDURE eliminar_empresa (
    IN _idEmpresa INT
)
BEGIN
    UPDATE Empresa 
    SET activo = FALSE 
    WHERE idEmpresa = _idEmpresa;
END$$

CREATE PROCEDURE listar_empresa()
BEGIN
    SELECT * FROM Empresa;
END$$

-- =====================
-- | HISTORIAL CLÍNICO | -----------------------------------------------------------------------------------------------------------------
-- =====================

CREATE PROCEDURE insertar_historial_clinico (
    OUT _idHistorial INT,
    IN _fechaCreacion DATE,
    IN _obsGenerales VARCHAR(200),
    IN _codigoPaciente VARCHAR(20),
    IN _idCitaMedica INT
)
BEGIN
    INSERT INTO HistorialClinico (fechaCreacion, obsGenerales, codigoPaciente, idCitaMedica)
    VALUES (_fechaCreacion, _obsGenerales, _codigoPaciente, _idCitaMedica);
    SET _idHistorial = @@last_insert_id;
END$$

CREATE PROCEDURE modificar_historial_clinico (
    IN _idHistorial INT,
    IN _obsGenerales VARCHAR(200)
)
BEGIN
    UPDATE HistorialClinico
    SET obsGenerales = _obsGenerales
    WHERE idHistorial = _idHistorial;
END$$

CREATE PROCEDURE eliminar_historial_clinico (
    IN _idHistorial INT
)
BEGIN
    UPDATE HistorialClinico 
    SET activo = FALSE 
    WHERE idHistorial = _idHistorial;
END$$

CREATE PROCEDURE listar_historial_paciente_con_citas (
    IN _codigoPaciente VARCHAR(20)
)
BEGIN
    -- Obtener el historial clínico del paciente
    SELECT * FROM HistorialClinico 
    WHERE codigoPaciente = _codigoPaciente;

    -- Obtener las citas médicas del paciente
    SELECT * FROM CitaMedica
    WHERE codigoPaciente = _codigoPaciente;
END$$


-- ==================
-- | DISPONIBILIDAD | -----------------------------------------------------------------------------------------------------------------
-- ==================

CREATE PROCEDURE insertar_disponibilidad (
    OUT _idDisponibilidad INT,
    IN _dia VARCHAR(10),  -- Cambiado a VARCHAR
    IN _horaInicio TIME,
    IN _horaFin TIME,
    IN _codigoMedico VARCHAR(20),
    IN _activo TINYINT(1)
)
BEGIN
    -- Validar si el día es válido (opcional)
    IF _dia IN ('LUNES', 'MARTES', 'MIERCOLES', 'JUEVES', 'VIERNES', 'SABADO', 'DOMINGO') THEN
        -- Insertar la disponibilidad
        INSERT INTO Disponibilidad (dia, horaInicio, horaFin, codigoMedico,activo)
        VALUES (_dia, _horaInicio, _horaFin, _codigoMedico,_activo);
        
        -- Obtener el id de la disponibilidad insertada
        SET _idDisponibilidad = @@last_insert_id;
    ELSE
        -- Si el día no es válido, devolver un error o un valor específico
        SET _idDisponibilidad = -1;  -- Usamos -1 como ejemplo de error
    END IF;
END$$


CREATE PROCEDURE modificar_disponibilidad(
	IN _idDisponibilidad int,
    IN _activo TINYINT(2)
)
BEGIN
    UPDATE Disponibilidad
    SET activo = _activo
    WHERE idDisponibilidad = _idDisponibilidad;
END$$

CREATE PROCEDURE eliminar_disponibilidad (
    IN _idDisponibilidad INT
)
BEGIN
    UPDATE Disponibilidad 
    SET activo = FALSE 
    WHERE idDisponibilidad = _idDisponibilidad;
END$$

CREATE PROCEDURE obtener_disponibilidad_por_id (
    IN _idDisponibilidad INT
)
BEGIN
    SELECT * FROM Disponibilidad WHERE idDisponibilidad = _idDisponibilidad;
END$$

CREATE PROCEDURE listar_todas_disponibilidades()
BEGIN
    SELECT * FROM Disponibilidad;
END$$

-- ===============
-- | CONSULTORIO | -----------------------------------------------------------------------------------------------------------------
-- ===============

CREATE PROCEDURE insertar_consultorio (
    OUT _idConsultorio INT,
    IN _numConsultorio INT,
    IN _piso INT,
    IN _idLocal INT,
    IN _codigoMedico VARCHAR(20),
    IN _activo BOOLEAN
)
BEGIN
    INSERT INTO Consultorio (numConsultorio, piso, idLocal, codigoMedico, activo)
    VALUES (_numConsultorio, _piso, _idLocal, _codigoMedico, _activo);
    
    SET _idConsultorio = LAST_INSERT_ID();
END$$

CREATE PROCEDURE modificar_consultorio (
    IN _idConsultorio INT,
    IN _numConsultorio INT,
    IN _piso INT,
    IN _codigoMedico VARCHAR(20),
    IN _activo BOOLEAN
)
BEGIN
    UPDATE Consultorio
    SET numConsultorio = _numConsultorio,
        piso = _piso,
        codigoMedico = _codigoMedico,
        activo = _activo
    WHERE idConsultorio = _idConsultorio;
END$$

CREATE PROCEDURE eliminar_consultorio (
    IN _idConsultorio INT
)
BEGIN
    UPDATE Consultorio 
    SET activo = FALSE 
    WHERE idConsultorio = _idConsultorio;
END$$

CREATE PROCEDURE obtener_consultorio_por_id (
    IN _idConsultorio INT
)
BEGIN
    SELECT * FROM Consultorio WHERE idConsultorio = _idConsultorio;
END$$

CREATE PROCEDURE listar_consultorios()
BEGIN
    SELECT * FROM Consultorio;
END$$


CREATE PROCEDURE listar_consultorios_por_local(
    IN _idLocal INT
)
BEGIN
    SELECT idConsultorio, numConsultorio, piso, activo, codigoMedico
    FROM Consultorio
    WHERE idLocal = _idLocal;
END $$


CREATE PROCEDURE listar_consultorios_por_local_y_medico (
    IN p_id_local INT,
    IN p_codigo_medico VARCHAR(20)
)
BEGIN
    SELECT *
    FROM Consultorio
    WHERE idLocal = p_id_local
      AND codigoMedico = p_codigo_medico
      AND activo = 1;
END$$

-- ===============
-- | ESPECIALIDAD | -----------------------------------------------------------------------------------------------------------------
-- ===============
CREATE PROCEDURE insertar_especialidad (
	OUT _id_especialidad INT,
    IN _nombre VARCHAR(100),
    IN _activo BOOLEAN
)
BEGIN
    INSERT INTO Especialidad (nombre, activo)
    VALUES (_nombre, _activo);
    SET _id_especialidad = @@last_insert_id;
END$$

CREATE PROCEDURE modificar_especialidad (
    IN _id_especialidad INT,
    IN _nombre VARCHAR(100),
    IN _activo BOOLEAN
)
BEGIN
    UPDATE Especialidad
    SET nombre = _nombre,
        activo = _activo
    WHERE idEspecialidad = _id_especialidad;
END$$

CREATE PROCEDURE eliminar_especialidad (
    IN _id_especialidad INT
)
BEGIN
    UPDATE Especialidad
    SET activo = FALSE
    WHERE idEspecialidad = _id_especialidad;
END$$

CREATE PROCEDURE listar_especialidades()
BEGIN
    SELECT * FROM Especialidad;
END$$

CREATE PROCEDURE obtener_especialidad_por_id (
    IN _idEspecialidad INT
)
BEGIN
    SELECT idEspecialidad, nombre, activo
    FROM Especialidad
    WHERE idEspecialidad = _idEspecialidad;
END$$

-- ===============
-- | DEPARTAMENTO | -----------------------------------------------------------------------------------------------------------------
-- ===============

CREATE PROCEDURE insertar_departamento (
	OUT _id_departamento INT,
    IN _nombre VARCHAR(100),
    IN _activo BOOLEAN
)
BEGIN
    INSERT INTO Especialidad (nombre, activo)
    VALUES (_nombre, _activo);
    SET _id_departamento = @@last_insert_id;
END$$

CREATE PROCEDURE modificar_departamento (
    IN _id_departamento INT,
    IN _nombre VARCHAR(100),
    IN _activo BOOLEAN
)
BEGIN
    UPDATE Departamento
    SET nombre = _nombre,
        activo = _activo
    WHERE id = _id_departamento;
END$$

CREATE PROCEDURE eliminar_departamento (
    IN _id_departamento INT
)
BEGIN
    UPDATE Departamento
    SET activo = FALSE
    WHERE id = _id_departamento;
END$$

CREATE PROCEDURE listar_departamentos()
BEGIN
    SELECT * FROM Departamento;
END$$


-- ===========================================
-- | LOCAL - ESPECIALIDAD (tabla intermedia) | -----------------------------------------------------------------------------------------------------------------
-- ===========================================

CREATE PROCEDURE insertar_local_especialidad (
    IN _idLocal INT,
    IN _idEspecialidad INT
)
BEGIN
    -- Si ya existe la relación inactiva, reactivarla
    IF EXISTS (
        SELECT 1 FROM LocalEspecialidad 
        WHERE idLocal = _idLocal AND idEspecialidad = _idEspecialidad
    ) THEN
        UPDATE LocalEspecialidad 
        SET activo = TRUE 
        WHERE idLocal = _idLocal AND idEspecialidad = _idEspecialidad;
    ELSE
        INSERT INTO LocalEspecialidad (idLocal, idEspecialidad, activo)
        VALUES (_idLocal, _idEspecialidad, TRUE);
    END IF;
END$$

CREATE PROCEDURE eliminar_local_especialidad (
    IN _idLocal INT,
    IN _idEspecialidad INT
)
BEGIN
    UPDATE LocalEspecialidad 
    SET activo = FALSE 
    WHERE idLocal = _idLocal AND idEspecialidad = _idEspecialidad;
END$$

CREATE PROCEDURE listar_especialidades_por_local (
    IN _idLocal INT
)
BEGIN
    SELECT e.idEspecialidad
    FROM LocalEspecialidad le
    INNER JOIN Especialidad e ON le.idEspecialidad = e.idEspecialidad
    WHERE le.idLocal = _idLocal
      AND le.activo = TRUE;
END$$


-- ========================================================================================================================
-- 													EXTRA
-- ========================================================================================================================

-- ==========================
-- | FUNCIONALIDAD DE LOGIN | -----------------------------------------------------------------------------------------------------------------
-- ==========================

CREATE PROCEDURE login_usuario (
    IN _username VARCHAR(50),
    IN _password VARCHAR(100)
)
BEGIN
    SELECT * FROM Usuario
    WHERE username = _username AND password = _password;
END$$

-- ========================
-- | ROLES DEL USUARIO EN LOGIN | -----------------------------------------------------------------------------------------------------------------
-- ========================

CREATE PROCEDURE obtener_roles_usuario (
    IN _username VARCHAR(50)
)
BEGIN
    SELECT rol FROM UsuarioRol WHERE username = _username;
END$$

-- =======================
-- | REPORTES POR FECHAS | -----------------------------------------------------------------------------------------------------------------
-- =======================

-- Citas médicas dentro de un rango de fechas
CREATE PROCEDURE reporte_citas_por_fecha (
    IN _fechaInicio DATE,
    IN _fechaFin DATE
)
BEGIN
    SELECT
        cm.idCitaMedica,
        cm.fecha,
        cm.hora,
        cm.precio,
        cm.estado,
        cm.modalidad,

        -- PACIENTE
        pac.codigoPaciente,
        perPac.nombres AS nombresPaciente,
        perPac.primerApellido AS primerApellidoPaciente,
        perPac.segundoApellido AS segundoApellidoPaciente,

        -- MÉDICO
        med.codigoMedico,
        perMed.nombres AS nombresMedico,
        perMed.primerApellido AS primerApellidoMedico,
        perMed.segundoApellido AS segundoApellidoMedico,

        -- CONSULTORIO
        con.idConsultorio,
        con.numConsultorio,
        con.piso,

        -- LOCAL
        loc.idLocal,
        loc.direccion AS direccionLocal,

        -- CIUDAD Y DEPARTAMENTO
        ciu.nombre AS ciudadLocal,
        dep.nombre AS departamentoLocal,

        -- HISTORIAL
        IFNULL(h.idHistorial, 0) AS idHistorial

    FROM CitaMedica cm
    INNER JOIN Paciente pac ON cm.codigoPaciente = pac.codigoPaciente
    INNER JOIN Persona perPac ON pac.codigoPaciente = perPac.docIdentidad

    INNER JOIN Medico med ON cm.codigoMedico = med.codigoMedico
    INNER JOIN Persona perMed ON med.codigoMedico = perMed.docIdentidad

    INNER JOIN Consultorio con ON cm.idConsultorio = con.idConsultorio
    INNER JOIN Local loc ON con.idLocal = loc.idLocal
    INNER JOIN Ciudad ciu ON loc.ciudad_id = ciu.id
    INNER JOIN Departamento dep ON loc.departamento_id = dep.id

    LEFT JOIN HistorialClinico h ON cm.idHistorial = h.idHistorial

    WHERE cm.fecha BETWEEN _fechaInicio AND _fechaFin
      AND cm.activo = 1;
END$$

-- Diagnósticos por fecha
CREATE PROCEDURE reporte_diagnosticos_por_fecha (
    IN _fechaInicio DATE,
    IN _fechaFin DATE
)
BEGIN
    SELECT * FROM Diagnostico
    WHERE fecha BETWEEN _fechaInicio AND _fechaFin;
END$$

-- =========================================
-- | OBTENER CITAS POR LOCAL Y CONSULTORIO | -----------------------------------------------------------------------------------------------------------------
-- =========================================

CREATE PROCEDURE obtener_citas_por_local_y_consultorio (
    IN _idLocal INT,
    IN _idConsultorio INT
)
BEGIN
    SELECT C.*
    FROM CitaMedica C
    JOIN Consultorio CO ON C.idConsultorio = CO.idConsultorio
    WHERE CO.idLocal = _idLocal
      AND CO.idConsultorio = _idConsultorio
    ORDER BY C.fecha ASC, C.hora ASC;
END$$

-- =======================================
-- | OBTENER DIAGNOSTICO POR CITA MEDICA | -----------------------------------------------------------------------------------------------------------------
-- =======================================

CREATE PROCEDURE obtener_diagnostico_por_cita (
    IN _idCitaMedica INT
)
BEGIN
    SELECT * FROM Diagnostico
    WHERE idDiagnostico = _idCitaMedica;
END$$

-- =======================================
-- | OBTENER TRATAMIENTO POR CITA MEDICA | -----------------------------------------------------------------------------------------------------------------
-- =======================================

CREATE PROCEDURE obtener_tratamiento_por_cita (
    IN _idCitaMedica INT
)
BEGIN
    SELECT * FROM Tratamiento
    WHERE idTratamiento = _idCitaMedica;
END$$

-- =======================================
-- | LISTAR TODAS LAS CITAS DE UN MEDICO | -----------------------------------------------------------------------------------------------------------------
-- =======================================

CREATE PROCEDURE listar_citas_por_medico (
    IN _codigoMedico VARCHAR(20)
)
BEGIN
    SELECT * FROM CitaMedica
    WHERE codigoMedico = _codigoMedico
    ORDER BY fecha ASC, hora ASC;
END$$

-- =========================================
-- | LISTAR TODAS LAS CITAS DE UN PACIENTE | -----------------------------------------------------------------------------------------------------------------
-- =========================================

CREATE PROCEDURE listar_citas_por_paciente (
    IN _codigoPaciente VARCHAR(20)
)
BEGIN
    SELECT * FROM CitaMedica
    WHERE codigoPaciente = _codigoPaciente
    ORDER BY fecha ASC, hora ASC;
END$$

-- ===============================
-- | PROXIMA CITA DE UN PACIENTE | -----------------------------------------------------------------------------------------------------------------
-- ===============================

CREATE PROCEDURE obtener_proxima_cita_por_paciente (
    IN _codigoPaciente VARCHAR(20)
)
BEGIN
    SELECT * FROM CitaMedica
    WHERE codigoPaciente = _codigoPaciente
      AND fecha >= CURDATE()
      AND estado = 'PROGRAMADA'
    ORDER BY fecha ASC, hora ASC
    LIMIT 1;
END$$

-- ========================
-- | PROXIMA DE UN MEDICO | -----------------------------------------------------------------------------------------------------------------
-- ========================

CREATE PROCEDURE obtener_proxima_cita_por_medico (
    IN _codigoMedico VARCHAR(20)
)
BEGIN
    SELECT * FROM CitaMedica
    WHERE codigoMedico = _codigoMedico
      AND fecha >= CURDATE()
      AND estado = 'PROGRAMADA'
    ORDER BY fecha ASC, hora ASC
    LIMIT 1;
END$$

-- =================================================
-- | LISTAR TODAS LAS CITAS FUTURAS DE UN PACIENTE | -----------------------------------------------------------------------------------------------------------------
-- =================================================

CREATE PROCEDURE listar_citas_futuras_por_paciente (
    IN _codigoPaciente VARCHAR(20)
)
BEGIN
    SELECT * FROM CitaMedica
    WHERE codigoPaciente = _codigoPaciente
      AND fecha >= CURDATE()
      AND estado = 'PROGRAMADA'
    ORDER BY fecha ASC, hora ASC;
END$$

-- ===============================================
-- | LISTAR TODAS LAS CITAS FUTURAS DE UN MEDICO | -----------------------------------------------------------------------------------------------------------------
-- ===============================================

CREATE PROCEDURE listar_citas_futuras_por_medico (
    IN _codigoMedico VARCHAR(20)
)
BEGIN
    SELECT * FROM CitaMedica
    WHERE codigoMedico = _codigoMedico
      AND fecha >= CURDATE()
      AND estado = 'PROGRAMADA'
    ORDER BY fecha ASC, hora ASC;
END$$
	
-- ===============================================
-- | LISTAR TIPO DE SANGRE | -----------------------------------------------------------------------------------------------------------------
-- ===============================================
DELIMITER $$
	
CREATE PROCEDURE listar_tipos_sangre()
BEGIN
    SELECT id, tipo, activo
    FROM TipoDeSangre
    WHERE activo = TRUE;
END$$
DELIMITER $$

CREATE PROCEDURE ObtenerNombrePersona (
    IN p_idUsuario INT,
    OUT p_nombre VARCHAR(50),
    OUT p_apellido1 VARCHAR(50)
)
BEGIN
    SELECT nombres, primerApellido  INTO p_nombre, p_apellido1 
    FROM Persona
    WHERE idUsuario = p_idUsuario;
END $$

DELIMITER $$

CREATE PROCEDURE ObtenerDocIdentidadPersona (
    IN p_idUsuario INT,
    OUT p_docIdentidad VARCHAR(50)
)
BEGIN
    SELECT docIdentidad INTO p_docIdentidad 
    FROM Persona
    WHERE idUsuario = p_idUsuario;
END $$

DELIMITER $$

CREATE PROCEDURE obtenerFotoPersona(
    IN p_idUsuario INT,
    OUT p_foto MEDIUMBLOB
)
BEGIN
    SELECT foto INTO p_foto
    FROM Persona
    WHERE idUsuario = p_idUsuario;
END $$

CREATE PROCEDURE obtenerDatosMedicoPorUsuario(
    IN p_idUsuario INT
)
BEGIN
    SELECT 
        m.codigoMedico,
        m.numeroColegiatura,
        m.idEspecialidad,
        m.activo AS medicoActivo,
        p.nombres,
        p.primerApellido,
        p.segundoApellido,
        p.email,
        p.telefono,
        p.foto,
        p.direccion,
        p.fechaNacimiento,
        p.genero,
        p.activo AS personaActiva
    FROM Persona p
    INNER JOIN Medico m ON p.docIdentidad = m.codigoMedico
    WHERE p.idUsuario = p_idUsuario;
END $$

CREATE PROCEDURE obtenerDatosPacientePorUsuario(
    IN p_idUsuario INT
)
BEGIN
    SELECT 
        pa.codigoPaciente,
        pa.peso,
        pa.altura,
        pa.tipoDeSangreID,
        pa.activo AS pacienteActivo,
        
        pe.nombres,
        pe.primerApellido,
        pe.segundoApellido,
        pe.email,
        pe.telefono,
        pe.foto,
        pe.direccion,
        pe.fechaNacimiento,
        pe.genero,
        pe.activo AS personaActiva,
        
        pe.idUsuario,
        pe.ciudad_id,
        pe.departamento_id

    FROM Persona pe
    INNER JOIN Paciente pa ON pe.docIdentidad = pa.codigoPaciente
    WHERE pe.idUsuario = p_idUsuario;
END $$


create procedure obtener_disponibilidad_por_medico(
in _codigoMedico VARCHAR(20)
)
begin
	SELECT * FROM Disponibilidad
    where codigoMedico = _codigoMedico;
END $$

DELIMITER $$

-- =============================================
-- === PROCEDIMIENTOS PARA DIAGNÓSTICO       ===
-- =============================================

DROP PROCEDURE IF EXISTS `insertar_diagnostico`$$
CREATE PROCEDURE `insertar_diagnostico`(
    IN p_idCitaMedica INT,
    IN p_descripcion VARCHAR(255),
    IN p_fecha DATE
)
BEGIN
    -- Se usa el ID de la cita como la PK del diagnóstico
    INSERT INTO Diagnostico (idDiagnostico, descripcionDiagnostico, fecha, activo, idCitaMedica)
    VALUES (p_idCitaMedica, p_descripcion, p_fecha, TRUE, p_idCitaMedica);
END$$


DROP PROCEDURE IF EXISTS `modificar_diagnostico`$$
CREATE PROCEDURE `modificar_diagnostico`(
    IN p_id_diagnostico INT,
    IN p_descripcion VARCHAR(255),
    IN p_fecha DATE
)
BEGIN
    UPDATE Diagnostico
    SET 
        descripcionDiagnostico = p_descripcion,
        fecha = p_fecha
    WHERE idDiagnostico = p_id_diagnostico;
END$$


-- =============================================
-- === PROCEDIMIENTOS PARA TRATAMIENTO       ===
-- =============================================

DROP PROCEDURE IF EXISTS `insertar_tratamiento`$$
CREATE PROCEDURE `insertar_tratamiento`(
    IN p_idCitaMedica INT,
    IN p_descripcion VARCHAR(255)
)
BEGIN
    -- Se usa el ID de la cita como la PK del tratamiento
    INSERT INTO Tratamiento (idTratamiento, descripcionTratamiento, activo, idCitaMedica)
    VALUES (p_idCitaMedica, p_descripcion, TRUE, p_idCitaMedica);
END$$


DROP PROCEDURE IF EXISTS `modificar_tratamiento`$$
CREATE PROCEDURE `modificar_tratamiento`(
    IN p_id_tratamiento INT,
    IN p_descripcion VARCHAR(255)
)
BEGIN
    UPDATE Tratamiento
    SET 
        descripcionTratamiento = p_descripcion
    WHERE idTratamiento = p_id_tratamiento;
END$$

DELIMITER ;
