-- 1. Definición de Tablas
DROP TABLE IF EXISTS CargoPersona;
DROP TABLE IF EXISTS SexoPersona;
DROP TABLE IF EXISTS Persona;
DROP TABLE IF EXISTS Cita;
DROP TABLE IF EXISTS TipoRegalo;
DROP TABLE IF EXISTS RegaloEnvio;
DROP TABLE IF EXISTS Regalo;
DROP TABLE IF EXISTS RegaloNombre;

-- DROP TABLE IF EXISTS TipoRelacion;
-- DROP TABLE IF EXISTS Relacion;
CREATE TABLE IF NOT EXISTS CargoPersona (
    IdCargo INTEGER PRIMARY KEY AUTOINCREMENT,
    NombreCargo TEXT,
    FechaModificacion TEXT
);

-- 2. Crear Trigger para Control de Administradores
CREATE TRIGGER IF NOT EXISTS controlAdministradores
    BEFORE INSERT ON CargoPersona
    FOR EACH ROW
    WHEN (
        NEW.NombreCargo = "Admin" AND
        (SELECT COUNT(*) FROM CargoPersona WHERE NombreCargo = "Admin") >= 2
    )
    BEGIN
        SELECT RAISE(ABORT, "Excede el límite de dos administradores");
    END;

CREATE TABLE IF NOT EXISTS SexoPersona(
    IdSexo INTEGER PRIMARY KEY AUTOINCREMENT,
    TipoSexo TEXT NOT NULL UNIQUE,
    FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaModificacion DATE
);

CREATE TABLE IF NOT EXISTS Persona(
    IdPersona INTEGER PRIMARY KEY AUTOINCREMENT,
    IdPersonaSexo INTEGER REFERENCES SexoPersona(IdSexo),
    IdPersonaCargo INTEGER REFERENCES CargoPersona(IdCargo),
    Nombre TEXT NOT NULL,
    Cedula INTEGER NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaModificacion DATE
);

CREATE TABLE IF NOT EXISTS TipoRegalo(
    IdTipoRegalo INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL UNIQUE,
    FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaModificacion DATETIME
);

-- CREATE TABLE IF NOT EXISTS TipoRelacion(
--     IdTpoRelacion INTEGER PRIMARY KEY AUTOINCREMENT,
--     Nombre TEXT NOT NULL,
--     FechaCreacion DATE NOT NULL,
--     FechaModificacion DATE
-- );

-- CREATE TABLE IF NOT EXISTS Relacion(
--     IdCita INTEGER PRIMARY KEY AUTOINCREMENT,
--     IdPersona1 INTEGER NOT NULL REFERENCES Persona(IdPersona),
--     IdPersona2 INTEGER NOT NULL REFERENCES Persona(IdPersona),
--     Fecha DATE NOT NULL,
--     FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     FechaModificacion DATE
-- );

CREATE TABLE IF NOT EXISTS Cita(
    IdCita INTEGER PRIMARY KEY AUTOINCREMENT,
    IdPersonaSolicitante INTEGER NOT NULL REFERENCES Persona(IdPersona),
    IdPersonaSolicitante2 INTEGER NOT NULL REFERENCES Persona(IdPersona),
    Fecha DATE NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaModificacion DATE
);

CREATE TABLE IF NOT EXISTS RegaloEnvio(
    IdRegaloEnvio INTEGER PRIMARY KEY AUTOINCREMENT,
    IdRegalo INTEGER NOT NULL REFERENCES Regalo(IdRegalo),
    IdPersonaEnvia INTEGER NOT NULL REFERENCES Persona(IdPersona),
    IdPersonaRecibe INTEGER NOT NULL REFERENCES Persona(IdPersona),
    FechaEnvio DATE NOT NULL,
    FechaCreacion DATE NOT NULL,
    FechaModificacion DATE,
    Direccion TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Regalo(
    IdRegalo INTEGER PRIMARY KEY AUTOINCREMENT,
    IdRegaloTipo INTEGER NOT NULL REFERENCES TipoRegalo(IdTipoRegalo),
    Nombre TEXT NOT NULL,
    Stock INTEGER NOT NULL,
    Precio INTEGER NOT NULL,
    IdRegaloNombre INTEGER NOT NULL REFERENCES RegaloNombre(IdRegaloNombre),
    FechaCreacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaModificacion DATETIME
);

CREATE TABLE IF NOT EXISTS RegaloNombre(
    IdRegaloNombre INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL
);
