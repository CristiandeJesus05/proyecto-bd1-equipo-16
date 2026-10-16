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
    COUNT(CASE WHEN f.id_pelicula = 147 THEN 1 END) AS El_intocable,
    COUNT(CASE WHEN f.id_pelicula = 350 THEN 1 END) AS Una_noche_para_enamorarme,
    COUNT(CASE WHEN f.id_pelicula = 777 THEN 1 END) AS El_gato_panzon,
    COUNT(CASE WHEN f.id_pelicula = 201 THEN 1 END) AS La_mansion_olvidada,
    COUNT(CASE WHEN f.id_pelicula = 202 THEN 1 END) AS Corazones_en_Corrientes,
    COUNT(CASE WHEN f.id_pelicula = 203 THEN 1 END) AS Mision_Tormenta,
    COUNT(CASE WHEN f.id_pelicula = 204 THEN 1 END) AS El_ultimo_tren,
    COUNT(CASE WHEN f.id_pelicula = 205 THEN 1 END) AS Pancho_el_valiente,
    COUNT(CASE WHEN f.id_pelicula = 206 THEN 1 END) AS Planeta_Zeta,
    COUNT(CASE WHEN f.id_pelicula = 207 THEN 1 END) AS El_tesoro_del_Ibera,
    COUNT(CASE WHEN f.id_pelicula = 208 THEN 1 END) AS Sombras_en_el_rio,
    COUNT(CASE WHEN f.id_pelicula = 209 THEN 1 END) AS Dos_amigos_y_un_destino,
    COUNT(CASE WHEN f.id_pelicula = 210 THEN 1 END) AS Rio_Parana_vida_y_cultura
FROM Ticket t
JOIN Funcion f ON f.id_funcion = t.id_funcion;

--recaudacion de  pago
SELECT
    SUM(CASE WHEN id_pago = 1 THEN total_compra END) AS Efectivo,
    SUM(CASE WHEN id_pago = 2 THEN total_compra END) AS Tarjeta_credito,
    SUM(CASE WHEN id_pago = 3 THEN total_compra END) AS Tarjeta_debito,
    SUM(CASE WHEN id_pago = 4 THEN total_compra END) AS Otros,
    SUM(CASE WHEN id_pago = 5 THEN total_compra END) AS Mercado_Pago,
    SUM(CASE WHEN id_pago = 6 THEN total_compra END) AS Transferencia,
    SUM(CASE WHEN id_pago = 7 THEN total_compra END) AS Tarjeta_prepaga
FROM Compra;

