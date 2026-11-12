--- Consulta recaudacion de las peliculas ---
SELECT
    p.id_pelicula,
    p.titulo AS pelicula,
    dbo.fn_RecaudacionPelicula(p.id_pelicula) AS recaudacion_total
FROM Pelicula p
ORDER BY recaudacion_total DESC;

--- Consulta de recaudacion de una pelicula en especifico ---
SELECT dbo.fn_RecaudacionPelicula(1) AS recaudacion_total;

--- Consulta recaudacion de las peliculas + datos adicionales ---
SELECT
    p.titulo,
    p.genero,
    p.duracion,
    dbo.fn_RecaudacionPelicula(p.id_pelicula) AS recaudacion
FROM Pelicula p;
