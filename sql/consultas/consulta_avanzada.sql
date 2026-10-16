
------ cantidad total de ventas por genero (ej "Romantica") ---------
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
    p.genero = 'Romantica';