--- Total de Ventas de Tickets en un rango de fechas determinados ---

DECLARE @Fecha_Inicio DATE = '2026-10-04';
DECLARE @Fecha_Fin DATE = '2026-10-09';

SELECT
    p.id_pelicula,
    p.titulo,
    COUNT(*) AS tickets_vendidos,
    COUNT(DISTINCT c.id_compra) AS cantidad_compras,
    SUM(t.precio_unitario) AS total_recaudado
FROM Pelicula p
INNER JOIN Funcion f
    ON p.id_pelicula = f.id_pelicula
INNER JOIN Ticket t
    ON f.id_funcion = t.id_funcion
INNER JOIN Compra c
    ON t.id_compra = c.id_compra
WHERE c.fecha_compra >= @Fecha_Inicio
  AND c.fecha_compra < DATEADD(DAY, 1, @Fecha_Fin)
GROUP BY
    p.id_pelicula,
    p.titulo
ORDER BY total_recaudado DESC;
