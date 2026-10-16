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