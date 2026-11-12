
-- 1. Forzar a SQL Server a salir de cualquier suplantación de identidad anterior
REVERT;
GO
-------------------------------------------------------------------
-- PARTE 1: Permisos a nivel de usuarios
-------------------------------------------------------------------

-- PRUEBA A: INSERT directo con usuario_admin (Resultado esperado: ÉXITO)
EXECUTE AS USER = 'usuario_admin';
DECLARE @nuevo_id_admin INT = (SELECT ISNULL(MAX(id_compra), 0) + 1 FROM dbo.Compra);

INSERT INTO dbo.Compra (id_compra, fecha_compra, hora_compra, total_compra, id_pago, id_cliente)
VALUES (@nuevo_id_admin, CAST(GETDATE() AS DATE), CAST(GETDATE() AS TIME), 5000.00, 1, 1);
REVERT;

-- PRUEBA B: INSERT directo con usuario_lector (Resultado esperado: ERROR / DENEGADO)
EXECUTE AS USER = 'usuario_lector';
DECLARE @nuevo_id_lector INT = (SELECT ISNULL(MAX(id_compra), 0) + 1 FROM dbo.Compra);

INSERT INTO dbo.Compra (id_compra, fecha_compra, hora_compra, total_compra, id_pago, id_cliente)
VALUES (@nuevo_id_lector, CAST(GETDATE() AS DATE), CAST(GETDATE() AS TIME), 5000.00, 1, 1);
-- SQL Server arroja error de permisos de inserción sobre la tabla Compra.
REVERT;

-- PRUEBA C: INSERT mediante Stored Procedure con usuario_lector (Resultado esperado: ÉXITO)
EXECUTE AS USER = 'usuario_lector';
DECLARE @nuevo_id_sp INT = (SELECT ISNULL(MAX(id_compra), 0) + 1 FROM dbo.Compra);

EXEC dbo.sp_RegistrarCompraSimple 
    @id_compra = @nuevo_id_sp, 
    @total_compra = 5000.00, 
    @id_pago = 1, 
    @id_cliente = 1;
REVERT;