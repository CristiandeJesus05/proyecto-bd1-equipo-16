-- Comprobacion antes de los cambios
SELECT stock_disponible FROM Funcion WHERE id_funcion = 12;   -- debería dar 1
SELECT COUNT(*) AS compras FROM Compra;                        -- debería dar 15
SELECT COUNT(*) AS tickets FROM Ticket;                        -- debería dar 42

-- Forzar Error 
EXEC dbo.sp_RegistrarCompra
     @IdCompra = 1017, @FechaCompra = '2026-10-17', @HoraCompra = '10:00:00',
     @IdPago = 1, @IdCliente = 5, @IdFuncion = 12,
     @ListaButacas = '[100]';

-- Comprobacion luego del cambio
SELECT stock_disponible FROM Funcion WHERE id_funcion = 12;   -- sigue en 1
SELECT COUNT(*) AS compras FROM Compra;                        -- sigue en 15
SELECT COUNT(*) AS tickets FROM Ticket;                        -- sigue en 42
SELECT * FROM Compra WHERE id_compra = 1017;                   -- 0 filas
SELECT * FROM Ticket WHERE id_compra = 1017;                   -- 0 filas


