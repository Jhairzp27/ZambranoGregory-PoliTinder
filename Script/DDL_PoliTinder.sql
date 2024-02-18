
CREATE TABLE IF NOT EXISTS CargoPersona(
    IdCargo INTEGER PRIMARY KEY,
    NombreCargo TEXT,
    FechaModificacion TEXT,
    NombrePersona Text
    CONSTRAINT controlAdministradores CHECK(
        (NombreCargo = "Admin" AND
        (SELECT COUNT(*) FROM CargoPersona WHERE NombreCargo = "Administrador") <=2) 
        OR
        (NombreCargo <> "Admin")
    )
);

