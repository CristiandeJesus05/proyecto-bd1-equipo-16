```
---- Tabla Cliente  ------
INSERT INTO Cliente (id_cliente, dni, nombre, apellido, email, telefono)

VALUES 
	---- Cliente 1 ----
	(123, 47991388, 'Juan', 'Perez', 'juanPerez@gmail.com', '8593928567'),
	---- Cliente 2 ----
	(456, 56999432, 'Maria', 'Gomez', 'gomezMaria@gmail.com', '5492846948'),
	---- Cliente 3 ----
	(748, 58499344, 'Diego', 'Sanchez', 'diegoSanchez@gmail.com', '5493847264'),
	---- Cliente 4 ----
	(788, 48777222, 'Sofia', 'Fernandez', 'sofiFernan@gmail.com', '9684736453'),
	---- Cliente 5 ----
	(546, 48593345, 'Ana', 'Martinez', 'anaMartinez@gmail.com', '7483748596'),
	---- Cliente 6 ----
	(435, 56478434, 'Jose', 'Rodriguez', 'rodriguez123@gmail.com', '8473648274'),
	---- Cliente 7 ----
	(567, 34534535, 'Rocio', 'Gimenez', 'gimenezRocioo@gmail.com', '8574635348'),
	---- Cliente 8 ----
	(433, 45633234, 'Pedro', 'Rojas', 'pedroRojas@gmail.com', '8573648684'),
	---- Cliente 9 ----
	(345, 34534545, 'Marta', 'Lopez', 'martaLopez@gmail.com', '8375839375'),
	---- Cliente 10 ----
	(234, 74888444, 'Tomas', 'Gonzalez', 'tomasGonzalez@gmail.com', '8475847348');



---- Tabla Sala  ------
INSERT INTO Sala (id_sala, nombre_sala, capacidad) 
VALUES 
	---- Sala 1 ----
	(123, 'Sala A', 200),
	---- Sala 2 ----
	(435, 'Sala B', 200),
	---- Sala 3 ----
	(345, 'Sala C', 200),
	---- Sala 4 ----
	(788, 'Sala D', 250),
	---- Sala 5 ----
	(555, 'Sala E', 100),
	---- Sala 6 ----
	(444, 'Sala F', 200),
	---- Sala 7 ----
	(111, 'Sala G', 300),
	---- Sala 8 ----
	(222, 'Sala H', 225),
	---- Sala 9 ----
	(445, 'Sala I', 200),
	---- Sala 10 ----
	(786, 'Sala J', 300);



---- Tabla Butaca -----
INSERT INTO Butaca (id_butaca, numero, fila, id_sala)

VALUES
	--- Butaca 1 ---
	(334, 1, 1, 445),
	--- Butaca 2 ---
	(453, 2, 2, 444),
	--- Butaca 3 ---
	(456, 3, 4, 445),
	--- Butaca 4 ---
	(435, 4, 5, 445),
	--- Butaca 5 ---
	(123, 5, 3, 111),
	--- Butaca 6 ---
	(333, 6, 6, 445),
	--- Butaca 7 ---
	(543, 7, 8, 788),
	--- Butaca 8 ---
	(654, 8, 9, 555);



---- Table Pelicula ----
INSERT INTO Pelicula (id_pelicula, titulo, genero, descripcion, duracion) 
VALUES 
	---- Pelicula 1 ---- 
	(1, 'Inception', 'Ciencia Ficcion', 'Dominio del sueno', 148),
	---- Pelicula 2 ---- 
	(2, 'Avatar', 'Ciencia Ficcion', 'Mundo de Pandora', 162),
	---- Pelicula 3 ---- 
	(3, 'Titanic', 'Drama', 'Historia de romance en el barco', 195),
	---- Pelicula 4 ---- 
	(4, 'The Dark Knight', 'Accion', 'El Guason causa caos', 152),
	---- Pelicula 5 ---- 
	(5, 'Interstellar', 'Ciencia Ficcion', 'Viaje a traves del espacio', 169),
	---- Pelicula 6 ---- 
	(6, 'Gladiator', 'Accion', 'Lucha en el coliseo romano', 155),
	---- Pelicula 7 ---- 
	(7, 'Matrix', 'Ciencia Ficcion', 'Realidad simulada y resistencia', 136),
	---- Pelicula 8 ---- 
	(8, 'Coco', 'Animacion', 'Viaje al mundo de los muertos', 105);



--- Tabla Funcion ---

INSERT INTO Funcion (id_funcion, fecha, hora, precio_actual, stock_disponible, id_pelicula, id_sala)
VALUES 
	--- Funcion 1 ---
	(111, '2026-10-05', '21:15:00', 100,  32, 1, 123),
	--- Funcion 2 ---
	(222, '2025-10-05', '20:35:00', 100, 100, 2, 555),
	--- Funcion 3 ---
	(333, '2026-09-05', '21:34:00', 100, 3, 3, 444),
	--- Funcion 4 ---
	(444, '2024-10-05', '12:35:00', 100, 2, 4, 222),
	--- Funcion 5 ---
	(555, '2026-10-07', '22:35:00', 100, 44, 5, 435),
	--- Funcion 6 ---
	(666, '2026-10-04', '11:34:00', 100, 32, 6, 123),
	--- Funcion 7 ---
	(777, '2026-10-04', '21:44:00', 100, 32, 7, 444),
	--- Funcion 8 ---
	(888, '2026-10-15', '22:15:00', 100, 43, 8, 555);



---- Tabla Metodo_pago ------
INSERT INTO Metodo_pago (id_pago, descripcion_pago)

VALUES 
	---- Metodo de pago 1 ----
	(1, 'Efectivo'),
	---- Metodo de pago 2 ----
	(2, 'Tarjeta de credito'),
	---- Metodo de pago 3 ----
	(3, 'Tarjeta de debito'),
	---- Metodo de pago 4 ----
	(4, 'Transferencia'),
	---- Metodo de pago 5 ----
	(5, 'Mercado Pago');



---- Tabla Compra ------

INSERT INTO Compra 
	(id_compra, fecha_compra, hora_compra, total_compra, id_pago, id_cliente)

VALUES 
	---- Compra 1 ----
	(1001, '2026-09-25', '18:30:00', 2000, 1, 123),
	---- Compra 2 ----
	(1002, '2026-09-25', '19:15:00', 3000, 2, 456),
	---- Compra 3 ----
	(1003, '2026-09-26', '20:10:00', 1000, 3, 748),
	---- Compra 4 ----
	(1004, '2026-09-26', '21:00:00', 2000, 4, 788),
	---- Compra 5 ----
	(1005, '2026-09-27', '17:45:00', 1000, 5, 546),
	---- Compra 6 ----
	(1006, '2026-09-27', '19:30:00', 3000, 1, 435),
	---- Compra 7 ----
	(1007, '2026-09-28', '20:20:00', 2000, 2, 567),
	---- Compra 8 ----
	(1008, '2026-09-28', '21:15:00', 1000, 3, 433),
	---- Compra 9 ----
	(1009, '2026-09-29', '18:50:00', 2000, 4, 345),
	---- Compra 10 ----
	(1010, '2026-09-29', '20:40:00', 3000, 5, 234);



---- Tabla Ticket ------

INSERT INTO Ticket 
	(nro_item, id_compra, precio_unitario, id_butaca, id_funcion)

VALUES 
	---- Ticket 1 - Compra 1001 ----
	(1, 1001, 1000, 654, 222),
	---- Ticket 2 - Compra 1001 ----
	(2, 1001, 1000, 453, 333),

	---- Ticket 1 - Compra 1002 ----
	(1, 1002, 1000, 654, 222),
	---- Ticket 2 - Compra 1002 ----
	(2, 1002, 1000, 453, 333),
	---- Ticket 3 - Compra 1002 ----
	(3, 1002, 1000, 334, 111),

	---- Ticket 1 - Compra 1003 ----
	(1, 1003, 1000, 453, 777),

	---- Ticket 1 - Compra 1004 ----
	(1, 1004, 1000, 654, 888),
	---- Ticket 2 - Compra 1004 ----
	(2, 1004, 1000, 453, 777),

	---- Ticket 1 - Compra 1005 ----
	(1, 1005, 1000, 654, 222),

	---- Ticket 1 - Compra 1006 ----
	(1, 1006, 1000, 453, 333),
	---- Ticket 2 - Compra 1006 ----
	(2, 1006, 1000, 654, 888),
	---- Ticket 3 - Compra 1006 ----
	(3, 1006, 1000, 453, 777),

	---- Ticket 1 - Compra 1007 ----
	(1, 1007, 1000, 654, 222),

	---- Ticket 1 - Compra 1008 ----
	(1, 1008, 1000, 453, 333),

	---- Ticket 1 - Compra 1009 ----
	(1, 1009, 1000, 654, 888),
	---- Ticket 2 - Compra 1009 ----
	(2, 1009, 1000, 453, 777),

	---- Ticket 1 - Compra 1010 ----
	(1, 1010, 1000, 654, 222),
	---- Ticket 2 - Compra 1010 ----
	(2, 1010, 1000, 453, 333),
	---- Ticket 3 - Compra 1010 ----
	(3, 1010, 1000, 654, 888);
