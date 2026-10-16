-- LOTE DE DATOS DE CINE DEL PARANA --  
--Orden de carga de los datos es la siguiente  
--1.Cliente-Sala-Pelicula-Metodo_Pago  
--2.butaca  
--3.funcion-compra  
--4.ticket  
  
--Cliente  
INSERT INTO Cliente (id_cliente,dni,nombre,apellido,email,telefono) VALUES  
			(0000,40602589,'Rocio Itati','Alfonzo','rocioita@gmail.com',3795040679),  
			(0001,45670546,'Rafael Thiago','Domingez','rafa08@gmail.com',3795347856),  
			(0002,35489123,'Juan','Pérez', 'juan.perez@gmail.com',3794123456),  
			(0003,40123789,'María','González','maria.gonzalez@gmail.com',3794987654),  
			(0004,28999444,'Carlos','Rodríguez','carlos.rodriguez@gmail.com',3794555888),  
			(0005,33111222,'Ana','Martínez','ana.martinez@gmail.com',3794333222),  
			(0006,42555666,'Lucas','Fernández','lucas.fernandez@gmail.com',3794777999);  
  
SELECT * FROM Cliente  
  
--Sala  
INSERT INTO Sala(id_sala,nombre_sala,capacidad) VALUES  
			--sala 1  
			(0001,'A',5),  
			--sala 2  
			(0002,'B',5),  
			--sala 3  
			(0003,'C',5);    
Select * from sala;  
--Pelicula  
INSERT INTO Pelicula (id_pelicula,titulo,genero,descripcion,duracion) VALUES  
			--pelicula 1  
			(147,'El intocable','Terror','Es mucho terror, de mucho suspenso, ¿quien sera el asesino?',90),  
			--pelicula 2  
			(350,'Una noche para enamorarme','Romantica','Una copa bastara para romper la tencion de ambos,¿o no?',75),  
			--pelicula 3  
			(777,'El gato panzon','comedia','Un gato que le gusta mucho la lasaña',120);  
select * from Pelicula;  
--Metodo_Pago  
INSERT INTO Metodo_Pago (id_pago,descripcion_pago) VALUES  
			(1,'Efectivo'),  
			(2,'Tarjeta de Credito'),  
			(3,'Tarjeta de Debito'),  
			(4,'Otros');  
select * from Metodo_Pago;  
--Butaca  
INSERT INTO Butaca(id_butaca,numero,fila,id_sala) VALUES  
			--sala 1  
			(100,1,'1',0001),  
			(101,2,'1',0001),  
			(102,3,'1',0001),  
			(103,4,'1',0001),  
			(104,5,'1',0001),  
			--sala 2  
			(105,1,'1',0002),  
			(106,2,'1',0002),  
			(107,3,'1',0002),  
			(108,4,'1',0002),  
			(109,5,'1',0002),  
			--sala 3  
			(110,1,'1',0003),  
			(111,2,'1',0003),  
			(112,3,'1',0003),  
			(113,4,'1',0003),  
			(114,5,'1',0003);  
  
SELECT * FROM Butaca WHERE id_butaca = 107;  
  
--funcion  
INSERT INTO Funcion(id_funcion,fecha,hora,precio_actual,stock_disponible,id_pelicula,id_sala) VALUES  
					--función 1  
				   (1,'2026-10-10','16:30:00',1000,5,147,0001),  
				   (2,'2026-10-10','16:30:00',1000,5,777,0002),  
				   (3,'2026-10-10','16:30:00',1000,5,350,0003),  
				   --función 2  
				   (4,'2026-10-10','18:15:00',1000,5,350,0001),  
				   (5,'2026-10-10','18:45:00',1000,5,147,0002),  
				   (6,'2026-10-10','18:00:00',1000,5,777,0003);  
SELECT * FROM Funcion;  
--Compra  
INSERT INTO Compra (id_compra,fecha_compra,hora_compra,total_compra,id_cliente,id_pago) VALUES  
					--compra 1  
				   (1001,'2026-10-8','08:32:35',2000,0000,1),  
				   --compra 2  
				   (1002,'2026-10-10','13:55:25',3000,0001,3),  
				   --compra 3  
				   (1003,'2026-9-15','18:32:56',5000,0004,1),  
				   --compra 4  
				   (1004,'2026-10-5','14:56:02',1000,0002,2),  
				   --compra 5  
				   (1005,'2026-10-9','12:45:11',3000,0006,4);  
  
--ticket  
INSERT INTO Ticket(nro_item,id_compra,precio_unitario,id_butaca,id_funcion) VALUES   
				  --ticket 1  
			      (1,1001,1000,105,2),  
				  (2,1001,1000,106,2),  
				  --ticket 2  
				  (3,1002,1000,100,1),  
				  (4,1002,1000,101,1),  
				  (5,1002,1000,102,1),  
				  --ticket 3  
				  (6,1003,1000,105,5),  
				  (7,1003,1000,106,5),  
				  (8,1003,1000,107,5),  
				  (9,1003,1000,108,5),  
				  (10,1003,1000,109,5),  
				  --ticket 4  
				  (11,1004,1000,100,4),  
				  --ticket 5  
				  (12,1005,1000,110,6),  
				  (13,1005,1000,111,6),  
				  (14,1005,1000,112,6);  
