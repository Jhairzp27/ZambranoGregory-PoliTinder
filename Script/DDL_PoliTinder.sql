-- 1. Definición de Tablas
DROP TABLE CargoPersona;
DROP TABLE SexoPersona;

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


