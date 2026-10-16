USE Cine_Del_Parana;

--clientes que mas gastaron
SELECT TOP 3
    c.nombre,
    c.apellido,
    co.total_compra AS total_gastado
FROM Compra co
JOIN Cliente c ON c.id_cliente = co.id_cliente
ORDER BY co.total_compra DESC;

--peliculas mas vistas
SELECT
    COUNT(CASE WHEN f.id_pelicula = 1 THEN 1 END) AS Inception,
    COUNT(CASE WHEN f.id_pelicula = 2 THEN 1 END) AS Avatar,
    COUNT(CASE WHEN f.id_pelicula = 3 THEN 1 END) AS Titanic,
    COUNT(CASE WHEN f.id_pelicula = 4 THEN 1 END) AS Dark_Knight,
    COUNT(CASE WHEN f.id_pelicula = 5 THEN 1 END) AS Interstellar,
    COUNT(CASE WHEN f.id_pelicula = 6 THEN 1 END) AS Gladiator,
    COUNT(CASE WHEN f.id_pelicula = 7 THEN 1 END) AS Matrix,
    COUNT(CASE WHEN f.id_pelicula = 8 THEN 1 END) AS Coco
FROM Ticket t
JOIN Funcion f ON f.id_funcion = t.id_funcion;

--recaudacion de  pago
SELECT
    SUM(CASE WHEN id_pago = 1 THEN total_compra END) AS Efectivo,
    SUM(CASE WHEN id_pago = 2 THEN total_compra END) AS Tarjeta_credito,
    SUM(CASE WHEN id_pago = 3 THEN total_compra END) AS Tarjeta_debito,
    SUM(CASE WHEN id_pago = 4 THEN total_compra END) AS Transferencia,
    SUM(CASE WHEN id_pago = 5 THEN total_compra END) AS Mercado_Pago
FROM Compra;

