
-- Asegurar contexto de administrador al inicio
REVERT;
GO
-- Verificar el modo de autenticación del servidor
SELECT 
    CASE SERVERPROPERTY('IsIntegratedSecurityOnly')
        WHEN 0 THEN 'Modo Mixto (Windows y SQL Server Authentication)'
        WHEN 1 THEN 'Solo Autenticación de Windows'
    END AS Modo_Autenticacion;

-- 1. Crear inicios de sesión (Logins) en el servidor
CREATE LOGIN usuario_admin WITH PASSWORD = 'Admin123*';
CREATE LOGIN usuario_lector WITH PASSWORD = 'Lector123*';
GO

CREATE USER usuario_admin FOR LOGIN usuario_admin;
CREATE USER usuario_lector FOR LOGIN usuario_lector;
GO

-- Usuario Admin: Se le otorga el rol db_owner (administrador completo de la DB)
ALTER ROLE db_owner ADD MEMBER usuario_admin;
GO

-- Usuario Lector: Solo permiso de lectura (SELECT) sobre una tabla (ej. Compra)
GRANT SELECT ON dbo.Compra TO usuario_lector;
GO

-- Crear el procedimiento para la tabla Compra de Cine_del_Parana
CREATE OR ALTER PROCEDURE dbo.sp_RegistrarCompraSimple
    @id_compra INT,
    @total_compra DECIMAL(10,2),
    @id_pago INT,
    @id_cliente INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Compra (id_compra, fecha_compra, hora_compra, total_compra, id_pago, id_cliente)
    VALUES (@id_compra, CAST(GETDATE() AS DATE), CAST(GETDATE() AS TIME), @total_compra, @id_pago, @id_cliente);
END;
GO

-- Otorgar permiso de EXECUTE sobre el Stored Procedure al usuario lector
GRANT EXECUTE ON dbo.sp_RegistrarCompraSimple TO usuario_lector;
GO








