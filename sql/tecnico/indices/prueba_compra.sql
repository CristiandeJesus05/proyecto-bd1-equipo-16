 -- Ejecutar una compra de prueba.
-- Se utilizan dos butacas de la sala correspondiente
-- a la funcion 3.

EXEC dbo.sp_RegistrarCompra
    @IdCompra = 1006,
    @FechaCompra = '2026-10-10',
    @HoraCompra = '15:00:00',
    @IdPago = 1,
    @IdCliente = 0,
    @IdFuncion = 3,
    @ListaButacas = N'[110,111]';

    -- Consultar la compra registrada.
SELECT *
FROM Compra
WHERE id_compra = 1006;


-- Consultar los tickets generados.
SELECT *
FROM Ticket
WHERE id_compra = 1006;


-- Consultar el stock actualizado de la funcion.
SELECT
    id_funcion,
    stock_disponible
FROM Funcion
WHERE id_funcion = 3;