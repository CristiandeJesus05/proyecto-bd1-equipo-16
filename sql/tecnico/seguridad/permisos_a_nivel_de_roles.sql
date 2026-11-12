
-- 1. Forzar a SQL Server a salir de cualquier suplantación de identidad anterior
REVERT;
GO

-------------------------------------------------------------------
-- PARTE 2: Permisos a nivel de roles
-------------------------------------------------------------------
CREATE LOGIN usuario_con_rol WITH PASSWORD = 'Rol123*';
CREATE LOGIN usuario_sin_rol WITH PASSWORD = 'Rol456*';
GO

CREATE USER usuario_con_rol FOR LOGIN usuario_con_rol;
CREATE USER usuario_sin_rol FOR LOGIN usuario_sin_rol;
GO

CREATE ROLE rol_consulta_peliculas;
GRANT SELECT ON dbo.Pelicula TO rol_consulta_peliculas;
ALTER ROLE rol_consulta_peliculas ADD MEMBER usuario_con_rol;
GO

-- Prueba D: SELECT por usuario_con_rol (Éxito)
EXECUTE AS USER = 'usuario_con_rol';
SELECT * FROM dbo.Pelicula;
REVERT;

-- Prueba E: SELECT por usuario_sin_rol (Falla / Denegado)
EXECUTE AS USER = 'usuario_sin_rol';
SELECT * FROM dbo.Pelicula;
REVERT;