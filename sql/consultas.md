USE Cine_Del_Parana;
--clientes que mas gastaron
SELECT TOP 3
    c.id_cliente,
    c.nombre,
    c.apellido,
    COUNT(DISTINCT co.id_compra) AS cantidad_compras,
    COUNT(t.nro_item)            AS tickets_comprados,
    SUM(t.precio_unitario)       AS total_gastado
FROM Cliente c
JOIN Compra co ON co.id_cliente = c.id_cliente
JOIN Ticket t  ON t.id_compra   = co.id_compra
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY total_gastado DESC;

--peliculas mas vistas
SELECT TOP 3
    p.titulo,
    COUNT(t.nro_item) AS entradas_vendidas
FROM Pelicula p
JOIN Funcion f ON f.id_pelicula = p.id_pelicula
JOIN Ticket t  ON t.id_funcion  = f.id_funcion
GROUP BY p.titulo
ORDER BY entradas_vendidas DESC;

--recaudacion por metodo de pago
SELECT
    mp.descripcion_pago,
    COUNT(co.id_compra)  AS compras,
    SUM(co.total_compra) AS recaudado
FROM Metodo_Pago mp
JOIN Compra co ON co.id_pago = mp.id_pago
GROUP BY mp.descripcion_pago
ORDER BY recaudado DESC;
