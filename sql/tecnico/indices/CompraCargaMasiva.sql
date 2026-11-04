---- Carga Masiva de Datos ------
SET NOCOUNT ON;
GO

WITH Numeros AS
(
    SELECT TOP (1000000)
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a
    CROSS JOIN sys.objects b
    CROSS JOIN sys.objects c
)
INSERT INTO Compra (id_compra, fecha_compra, hora_compra, total_compra, id_pago, id_cliente)
SELECT
    -- id_compra: Genera IDs únicos desde 2000 en adelante
    n + 2000,
    -- fecha_compra: Fechas aleatorias en los últimos 5 años
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 1825, '2020-01-01'),
    -- hora_compra: Horas aleatorias
    TIMEFROMPARTS(ABS(CHECKSUM(NEWID())) % 24, ABS(CHECKSUM(NEWID())) % 60, ABS(CHECKSUM(NEWID())) % 60, 0, 0),
    -- total_compra: Monto aleatorio entre 0 y 10000
    RAND(CHECKSUM(NEWID())) * 10000,
    -- id_pago: Asigna IDs válidos existentes (1 al 4)
    (ABS(CHECKSUM(NEWID())) % 4) + 1,
    -- id_cliente: Asigna IDs válidos existentes (0 al 6)
    ABS(CHECKSUM(NEWID())) % 7
FROM Numeros;
GO

-- Verificar la carga
SELECT COUNT(*) AS CantidadRegistros FROM Compra;
GO
