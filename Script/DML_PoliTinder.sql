-- DELETE FROM CargoPersona WHERE NombreCargo = "Admin";
INSERT OR IGNORE INTO CargoPersona(NombreCargo, FechaModificacion)VALUES ("Admin", "2024-02-16");
INSERT OR IGNORE INTO CargoPersona(NombreCargo, FechaModificacion)VALUES ( "User", "2024-02-18");

INSERT OR IGNORE INTO SexoPersona(TipoSexo, FechaModificacion) VALUES("Hombre",CURRENT_TIMESTAMP);
INSERT OR IGNORE INTO SexoPersona(TipoSexo, FechaModificacion) VALUES("Mujer",CURRENT_TIMESTAMP);

INSERT OR IGNORE INTO SexoPersona(TipoSexo,FechaCreacion)
    SELECT "Hombre", CURRENT_TIMESTAMP
    WHERE NOT EXISTS(SELECT 1 FROM SexoPersona WHERE TipoSexo = "Nombre");

INSERT OR IGNORE INTO SexoPersona(TipoSexo,FechaCreacion)
    SELECT "Mujer", CURRENT_TIMESTAMP
    WHERE NOT EXISTS(SELECT 1 FROM SexoPersona WHERE TipoSexo = "Mujer");

INSERT INTO Persona (IdPersonaCargo, IdPersonaSexo, Cedula, Nombres, Apellidos)
SELECT 1,1, '1719524783', 'Jhair'
FROM PersonaSexo
ORDER BY RANDOM()
LIMIT 1;

INSERT INTO Persona (IdPersonaCargo, IdPersonaSexo, Cedula, Nombres, Apellidos)
SELECT 1,2, '1438720961', 'Eli'
FROM PersonaSexo
ORDER BY RANDOM()
LIMIT 1;

