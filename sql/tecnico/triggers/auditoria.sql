 

-- PRUEBAS de los triggers de auditoria y del bloqueo de DELETE
-- Correr DESPUES de auditoria_cine.sql, con los dos lotes de datos
-- cargados. Ejecutar cada prueba por separado (seleccionarla y F5)
-- Las pruebas que modifican datos terminan en ROLLBACK: no dejan cambios
-- (ni en las tablas ni en las de auditoria)

-- PRUEBA 1: auditoria de un UPDATE sobre Cliente
-- Esperado: 1 fila | operacion = UPDATE | usuario = tu usuario (ej: dbo)
-- id_cliente = 2 | telefono = 3794123456 (el valor ANTERIOR al cambio)

BEGIN TRANSACTION;
 
    UPDATE Cliente SET telefono = '3794000000' WHERE id_cliente = 2;
 
    SELECT operacion, fecha_operacion, hora_operacion, usuario, id_cliente, telefono
    FROM Aud_Cliente;
 
ROLLBACK TRANSACTION;

-- PRUEBA 2: auditoria de un DELETE sobre Cliente
-- El cliente 3 no tiene compras, por eso se puede borrar.
-- Esperado: 1 fila | operacion = DELETE | id_cliente = 3
-- nombre = Maria | apellido = González | email = maria.gonzalez@gmail.com

BEGIN TRANSACTION;
 
    DELETE FROM Cliente WHERE id_cliente = 3;
 
    SELECT operacion, usuario, id_cliente, nombre, apellido, email
    FROM Aud_Cliente;
 
ROLLBACK TRANSACTION;
 
-- PRUEBA 3: auditoria de un UPDATE sobre Funcion
-- Esperado: 1 fila | operacion = UPDATE | id_funcion = 1
-- precio_actual = 1000.00 (el valor anterior)

BEGIN TRANSACTION;
 
    UPDATE Funcion SET precio_actual = 1100 WHERE id_funcion = 1;
 
    SELECT operacion, usuario, id_funcion, precio_actual
    FROM Aud_Funcion;
 
ROLLBACK TRANSACTION;
 
-- PRUEBA 4: auditoria de un UPDATE sobre Compra
-- Esperado: 1 fila | operacion = UPDATE | id_compra = 1001
-- total_compra = 2000.00 (el valor anterior)

BEGIN TRANSACTION;
 
    UPDATE Compra SET total_compra = 2500 WHERE id_compra = 1001;
 
    SELECT operacion, usuario, id_compra, total_compra
    FROM Aud_Compra;
 
ROLLBACK TRANSACTION;
 
-- PRUEBA 5: el trigger bloquea el DELETE sobre Pelicula
-- Esperado: error = "No se permite eliminar peliculas: se conserva el
-- historial de funciones." y pelicula_777 = 1 (la fila sigue existiendo)

BEGIN TRY
    DELETE FROM Pelicula WHERE id_pelicula = 777;
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS error;
END CATCH;
 
SELECT COUNT(*) AS pelicula_777 FROM Pelicula WHERE id_pelicula = 777;
 
-- PRUEBA 6: ver con que usuario se registra la auditoria
-- Es el mismo valor que queda en la columna "usuario"

SELECT USER_NAME() AS usuario_bd, SUSER_SNAME() AS login_servidor;
 
