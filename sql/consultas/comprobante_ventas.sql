USE Cine_Del_Parana;

--clientes que mas gastaron
SELECT TOP 3
    c.id_cliente,
    c.nombre,
    c.apellido,
    (SELECT COUNT(*)
     FROM Compra co
     WHERE co.id_cliente = c.id_cliente) AS cantidad_compras,
    (SELECT SUM(co.total_compra)
     FROM Compra co
     WHERE co.id_cliente = c.id_cliente) AS total_gastado
FROM Cliente c
ORDER BY total_gastado DESC;

--peliculas mas vistas
SELECT TOP 3
    p.titulo,
    (SELECT COUNT(*)
     FROM Ticket t
     JOIN Funcion f ON f.id_funcion = t.id_funcion
     WHERE f.id_pelicula = p.id_pelicula) AS entradas_vendidas
FROM Pelicula p
ORDER BY entradas_vendidas DESC;

--recaudacion de  pago
SELECT
    mp.descripcion_pago,
    (SELECT COUNT(*)
     FROM Compra co
     WHERE co.id_pago = mp.id_pago) AS compras,
    (SELECT SUM(co.total_compra)
     FROM Compra co
     WHERE co.id_pago = mp.id_pago) AS recaudado
FROM Metodo_Pago mp
ORDER BY recaudado DESC;

