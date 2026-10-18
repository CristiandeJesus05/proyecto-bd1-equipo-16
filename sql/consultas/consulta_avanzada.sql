---- Generos Populares: que hayan vendido mas de 5 tickets -----------
SELECT 
    p.genero,
    COUNT(t.nro_item) AS total_entradas_vendidas,
    SUM(t.precio_unitario) AS total_recaudado
FROM 
    Pelicula p
INNER JOIN 
    Funcion f ON p.id_pelicula = f.id_pelicula
INNER JOIN 
    Ticket t ON f.id_funcion = t.id_funcion
GROUP BY 
    p.genero
HAVING 
    COUNT(t.nro_item) >= 5
ORDER BY 
    total_entradas_vendidas DESC;

--- Pelicula menos vendida---
SELECT
    p.id_pelicula,
    p.titulo,
    p.genero,
    COUNT(t.id_compra) AS entradas_vendidas,
    COUNT(DISTINCT f.id_funcion) AS funciones_con_ventas,
    COALESCE(SUM(t.precio_unitario), 0) AS ingresos_totales
FROM Pelicula AS p
INNER JOIN Funcion AS f
    ON p.id_pelicula = f.id_pelicula
INNER JOIN Sala AS s
    ON f.id_sala = s.id_sala
LEFT JOIN Ticket AS t
    ON f.id_funcion = t.id_funcion
GROUP BY
    p.id_pelicula,
    p.titulo,
    p.genero
HAVING COUNT(t.id_compra) <= ALL (
    SELECT COUNT(t2.id_compra)
    FROM Funcion AS f2
    INNER JOIN Ticket AS t2
        ON f2.id_funcion = t2.id_funcion
    WHERE f2.id_pelicula IN (
        SELECT f3.id_pelicula
        FROM Funcion AS f3
    )
    GROUP BY f2.id_pelicula
)
ORDER BY entradas_vendidas ASC;
