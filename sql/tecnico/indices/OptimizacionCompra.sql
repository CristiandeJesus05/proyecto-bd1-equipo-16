
----------------------------------------------------------------------------
------------------------------ SIN ÍNDICE ----------------------------------
----------------------------------------------------------------------------

-- Activar las estadísticas de rendimiento
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

-- Consulta sobre la tabla Compra filtrando por fecha
SELECT 
    id_compra,
    fecha_compra,
    total_compra
FROM Compra
WHERE fecha_compra BETWEEN '2022-01-01' AND '2022-12-31';
GO

----------------------------------------------------------------------------
--------------------- ÍNDICE SIMPLE SOBRE FECHA ----------------------------
----------------------------------------------------------------------------

--- Elimina el indice previo si existe -----
DROP INDEX IF EXISTS IX_Compra_Fecha ON Compra;
GO

--- creacion del indice sobre fecha ------
CREATE NONCLUSTERED INDEX IX_Compra_Fecha
ON Compra (fecha_compra);
GO

--- repetir consulta ----
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

SELECT id_compra, fecha_compra, total_compra
FROM Compra WITH(INDEX(IX_Compra_Fecha))
WHERE fecha_compra BETWEEN '2022-01-01' AND '2022-12-31';
GO


----------------------------------------------------------------------------
------------------------ ÍNDICE QUE CUBRA CONSULTA  ------------------------
----------------------------------------------------------------------------

----- Elimina el indice previo -----------
DROP INDEX IF EXISTS IX_Compra_Fecha ON Compra;
DROP INDEX IF EXISTS IX_Compra_Fecha_Cobertura ON Compra;
GO

-- Crear el índice con cobertura (INCLUDE)
CREATE NONCLUSTERED INDEX IX_Compra_Fecha_Cobertura
ON Compra (fecha_compra)
INCLUDE (total_compra);
GO


--- repetir consulta ----
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

SELECT 
    id_compra, 
    fecha_compra, 
    total_compra
FROM Compra
WHERE fecha_compra BETWEEN '2022-01-01' AND '2022-12-31';
GO