-- Prueba 1: auditoría de UPDATE sobre Cliente
BEGIN TRANSACTION;

    UPDATE Cliente SET telefono = '3794000000' WHERE id_cliente = 2;

    SELECT operacion, fecha_operacion, hora_operacion, usuario, id_cliente, telefono
    FROM Aud_Cliente;

ROLLBACK TRANSACTION;


-- Prueba 2: auditoría de DELETE sobre Cliente
BEGIN TRANSACTION;

    DELETE FROM Cliente WHERE id_cliente = 3;

    SELECT operacion, usuario, id_cliente, nombre, apellido, email
    FROM Aud_Cliente;

ROLLBACK TRANSACTION;


-- Prueba 3: auditoría de UPDATE sobre Funcion
BEGIN TRANSACTION;

    UPDATE Funcion SET precio_actual = 1100 WHERE id_funcion = 1;

    SELECT operacion, usuario, id_funcion, precio_actual
    FROM Aud_Funcion;

ROLLBACK TRANSACTION;


-- Prueba 4: auditoría de UPDATE sobre Compra
BEGIN TRANSACTION;

    UPDATE Compra SET total_compra = 2500 WHERE id_compra = 1001;

    SELECT operacion, usuario, id_compra, total_compra
    FROM Aud_Compra;

ROLLBACK TRANSACTION;


-- Prueba 5: el trigger bloquea el DELETE sobre Pelicula
BEGIN TRY
    DELETE FROM Pelicula WHERE id_pelicula = 777;
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS error;
END CATCH;
