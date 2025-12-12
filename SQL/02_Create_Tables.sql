-- =================================
-- | SCRIPT 02: CREACIÓN DE TABLAS |
-- =================================

-- =====================
-- | Tabla tipo_sangre |
-- =====================
CREATE TABLE TipoDeSangre (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(3) NOT NULL UNIQUE,
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;
-- Se llena de inicio ya que son los únicos tipos de sangre que existen
INSERT INTO TipoDeSangre (tipo) VALUES 
('A+'), ('A-'), ('B+'), ('B-'), 
('AB+'), ('AB-'), ('O+'), ('O-');

-- ======================
-- | Tabla departamento |
-- ======================
CREATE TABLE Departamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;
-- Se llena de inicio ya que son datos necesarios para la bd y no son datos que se inserten luego
INSERT INTO Departamento (nombre) VALUES 
('Lima'),
('Callao'),
('Cusco'),
('Arequipa'),
('La Libertad'),
('Piura');


-- ================
-- | Tabla ciudad |
-- ================
CREATE TABLE Ciudad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    departamento_id INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
) ENGINE=InnoDB;
-- Se llena de inicio ya que son datos necesarios para la bd y no son datos que se inserten luego
INSERT INTO Ciudad (nombre, departamento_id) VALUES 
-- Lima
('Lima Metropolitana', 1),
('Chosica', 1),
('San Juan de Lurigancho', 1),
-- Callao
('Callao', 2),
('La Perla', 2),
('Bellavista', 2),
-- Cusco
('Cusco', 3),
('Sicuani', 3),
('Quillabamba', 3),
-- Arequipa
('Arequipa', 4),
('Camaná', 4),
('Mollendo', 4),
-- La Libertad
('Trujillo', 5),
('Chepén', 5),
('Pacasmayo', 5),
-- Piura
('Piura', 6),
('Sullana', 6),
('Talara', 6);


-- ======================
-- | Tabla Especialidad |
-- ======================
CREATE TABLE Especialidad (
    idEspecialidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- =================
-- | Tabla Usuario |
-- =================
CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(100) NOT NULL,
    rol ENUM('PACIENTE', 'MEDICO', 'ADMINISTRADOR'),
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- =================
-- | Tabla Persona |
-- =================
CREATE TABLE Persona (
    docIdentidad VARCHAR(20) PRIMARY KEY,
    nombres VARCHAR(100),
    primerApellido VARCHAR(50),
    segundoApellido VARCHAR(50),
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    email VARCHAR(100),
    fechaNacimiento DATE,
    genero CHAR(1),
    foto MEDIUMBLOB,
    idUsuario INT UNIQUE,
    ciudad_id INT,
    departamento_id INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (idUSuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY (ciudad_id) REFERENCES Ciudad(id),
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
) ENGINE=InnoDB;


-- ================
-- | Tabla Medico |
-- ================
CREATE TABLE Medico (
    codigoMedico VARCHAR(20) PRIMARY KEY,
    numeroColegiatura VARCHAR(20),
    idEspecialidad INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (idEspecialidad) REFERENCES Especialidad(idEspecialidad),
    FOREIGN KEY (codigoMedico) REFERENCES Persona(docIdentidad)
) ENGINE=InnoDB;

-- ==================
-- | Tabla Paciente |
-- ==================
CREATE TABLE Paciente (
    codigoPaciente VARCHAR(20) PRIMARY KEY,
    peso DOUBLE,
    altura DOUBLE,
    tipoDeSangreID INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (codigoPaciente) REFERENCES Persona(docIdentidad),
    FOREIGN KEY (tipoDeSangreID) REFERENCES TipoDeSangre(id)
) ENGINE=InnoDB;

-- =======================
-- | Tabla Administrador |
-- =======================
CREATE TABLE Administrador (
    codigoAdministrador VARCHAR(20) PRIMARY KEY,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (codigoAdministrador) REFERENCES Persona(docIdentidad)
) ENGINE=InnoDB;

-- ========================
-- | Tabla Disponibilidad |
-- ========================
CREATE TABLE Disponibilidad (
    idDisponibilidad INT AUTO_INCREMENT PRIMARY KEY,
    dia ENUM('LUNES','MARTES','MIERCOLES','JUEVES','VIERNES','SABADO','DOMINGO') NOT NULL,
    horaInicio TIME NOT NULL,
    horaFin TIME NOT NULL,
    codigoMedico VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (codigoMedico) REFERENCES Medico(codigoMedico)
) ENGINE=InnoDB;

-- =================
-- | Tabla Empresa |
-- =================
CREATE TABLE Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    razonSocial VARCHAR(100) NOT NULL,
    ruc VARCHAR(20) NOT NULL,
    telefonoDeContacto VARCHAR(20),
    logo MEDIUMBLOB,
    linkInstagram VARCHAR(255),
    linkFacebook VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- ===============
-- | Tabla Local |
-- ===============
CREATE TABLE Local (
    idLocal INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(255),
    ubigeo VARCHAR(10),
    ciudad_id INT,
    departamento_id INT,
    idEmpresa INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (idEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (ciudad_id) REFERENCES Ciudad(id),
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
) ENGINE=InnoDB;

-- ======================================
-- | Tabla intermedia localEspecialidad |
-- ======================================
CREATE TABLE LocalEspecialidad (
	idLocal INT,
    idEspecialidad INT,
    activo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (idLocal, idEspecialidad),
    FOREIGN KEY (idLocal) REFERENCES Local(idLocal),
    FOREIGN KEY (idEspecialidad) REFERENCES Especialidad(idEspecialidad)
) ENGINE=InnoDB;

-- =====================
-- | Tabla Consultorio |
-- =====================
CREATE TABLE Consultorio (
    idConsultorio INT AUTO_INCREMENT PRIMARY KEY,
    numConsultorio INT,
    piso INT,
    idLocal INT,
    codigoMedico VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (codigoMedico) REFERENCES Medico(codigoMedico),
    FOREIGN KEY (idLocal) REFERENCES Local(idLocal)
) ENGINE=InnoDB;

-- ==========================
-- | Tabla HistorialClinico |
-- ==========================
CREATE TABLE HistorialClinico (
    idHistorial INT AUTO_INCREMENT PRIMARY KEY,
    fechaCreacion DATE,
    obsGenerales VARCHAR(200),
    codigoPaciente VARCHAR(20),
    idCitaMedica INT,
    activo BOOLEAN DEFAULT TRUE,
    -- FOREIGN KEY (idCitaMedica) REFERENCES CitaMedica(idCitaMedica),
    FOREIGN KEY (codigoPaciente) REFERENCES Paciente(codigoPaciente)
) ENGINE=InnoDB;

-- ====================
-- | Tabla CitaMedica |
-- ====================
CREATE TABLE CitaMedica (
    idCitaMedica INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    precio DOUBLE,
    estado ENUM('PROGRAMADA', 'CANCELADA', 'REALIZADA') NOT NULL,
    modalidad ENUM('PRESENCIAL', 'VIRTUAL') NOT NULL,
    codigoPaciente VARCHAR(20),
    codigoMedico VARCHAR(20),
    idConsultorio INT,
    idHistorial INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (codigoPaciente) REFERENCES Paciente(codigoPaciente),
    FOREIGN KEY (idHistorial) REFERENCES HistorialClinico(idHistorial),
    FOREIGN KEY (codigoMedico) REFERENCES Medico(codigoMedico),
    FOREIGN KEY (idConsultorio) REFERENCES Consultorio(idConsultorio)
) ENGINE=InnoDB;

-- =====================
-- | Tabla Diagnostico |
-- =====================
CREATE TABLE Diagnostico (
    idDiagnostico INT PRIMARY KEY,
    descripcionDiagnostico VARCHAR(255),
    fecha DATE,
    activo BOOLEAN DEFAULT TRUE,
    idCitaMedica INT,
    FOREIGN KEY (idDiagnostico) REFERENCES CitaMedica(idCitaMedica)
) ENGINE=InnoDB;

-- =====================
-- | Tabla Tratamiento |
-- =====================
CREATE TABLE Tratamiento (
    idTratamiento INT PRIMARY KEY,
    descripcionTratamiento VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE,
    idCitaMedica INT,
    FOREIGN KEY (idTratamiento) REFERENCES CitaMedica(idCitaMedica)
) ENGINE=InnoDB;


