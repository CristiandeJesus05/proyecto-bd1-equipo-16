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
--Lote de datos actualizado
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
  SELECT * FROM Compra;
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


--Cliente
INSERT INTO Cliente (id_cliente,dni,nombre,apellido,email,telefono) VALUES
			(0007,38250411,'Valentina','Acosta','valentina.acosta@gmail.com','3794201010'),
			(0008,36780922,'Matías','Benítez','matias.benitez@gmail.com','3794202020'),
			(0009,41330877,'Camila','Romero','camila.romero@gmail.com','3794203030'),
			(0010,29874501,'Federico','Sosa','federico.sosa@gmail.com','3794204040'),
			(0011,44120365,'Lucía','Ledesma','lucia.ledesma@gmail.com','3794205050'),
			(0012,37654210,'Nicolás','Villalba','nicolas.villalba@gmail.com','3794206060'),
			(0013,39988123,'Paula','Gutiérrez','paula.gutierrez@gmail.com','3794207070'),
			(0014,31456780,'Martín','Ojeda','martin.ojeda@gmail.com','3794208080'),
			(0015,43210987,'Agustina','Cabrera','agustina.cabrera@gmail.com','3794209090'),
			(0016,34567812,'Sebastián','Medina','sebastian.medina@gmail.com','3794210101');

SELECT * FROM Cliente;

--Sala 
INSERT INTO Sala(id_sala,nombre_sala,capacidad) VALUES
			--sala 4
			(0004,'D',5),
			--sala 5
			(0005,'E',5);

SELECT * FROM Sala;



--Pelicula 
INSERT INTO Pelicula (id_pelicula,titulo,genero,descripcion,duracion) VALUES
			--pelicula 4
			(201,'La mansion olvidada','Terror','Cinco amigos pasan una noche en una mansion abandonada y descubren que no estan solos.',100),
			--pelicula 5
			(202,'Corazones en Corrientes','Romantica','Dos desconocidos se encuentran durante el carnaval y deben decidir si arriesgarse al amor.',95),
			--pelicula 6
			(203,'Mision Tormenta','Accion','Un equipo de rescate debe salvar a un pueblo antes de que llegue la peor tormenta del siglo.',115),
			--pelicula 7
			(204,'El ultimo tren','Drama','Un viejo maquinista realiza su ultimo viaje y recuerda toda una vida sobre los rieles.',110),
			--pelicula 8
			(205,'Pancho el valiente','Animacion','Un carpincho muy pequeño se anima a cruzar el rio para salvar a su familia.',85),
			--pelicula 9
			(206,'Planeta Zeta','Ciencia Ficcion','Una tripulacion llega a un planeta donde el tiempo corre al reves.',130),
			--pelicula 10
			(207,'El tesoro del Ibera','Aventura','Tres primos siguen un mapa antiguo por los esteros en busca de un tesoro escondido.',105),
			--pelicula 11
			(208,'Sombras en el rio','Suspenso','Un detective investiga la desaparicion de un pescador en las costas del Parana.',98),
			--pelicula 12
			(209,'Dos amigos y un destino','comedia','Dos amigos intentan llegar a una boda y todo lo que puede salir mal sale mal.',92),
			--pelicula 13
			(210,'Rio Parana: vida y cultura','Documental','Un recorrido por la historia, las costumbres y la gente que vive junto al rio.',70);
SELECT * FROM Pelicula;

--Metodo_Pago
INSERT INTO Metodo_Pago (id_pago,descripcion_pago) VALUES
			(5,'Mercado Pago'),
			(6,'Transferencia'),
			(7,'Tarjeta Prepaga');

SELECT * FROM Metodo_Pago;

--Butaca 
INSERT INTO Butaca(id_butaca,numero,fila,id_sala) VALUES
			--sala 4
			(115,1,'1',0004),
			(116,2,'1',0004),
			(117,3,'1',0004),
			(118,4,'1',0004),
			(119,5,'1',0004),
			--sala 5
			(120,1,'1',0005),
			(121,2,'1',0005),
			(122,3,'1',0005),
			(123,4,'1',0005),
			(124,5,'1',0005);

SELECT * FROM Butaca;

--funcion 
INSERT INTO Funcion(id_funcion,fecha,hora,precio_actual,stock_disponible,id_pelicula,id_sala) VALUES
			(7,'2026-10-17','16:00:00',1000,3,201,0001),
			(8,'2026-10-17','16:00:00',1000,2,202,0002),
			(9,'2026-10-17','18:30:00',1200,3,203,0003),
			(10,'2026-10-17','20:30:00',1200,1,204,0004),
			(11,'2026-10-17','20:30:00',1200,4,205,0005),
			(12,'2026-10-18','17:00:00',1000,1,206,0001),
			(13,'2026-10-18','17:00:00',1200,3,207,0004),
			(14,'2026-10-18','19:30:00',1200,0,208,0002),
			(15,'2026-10-18','21:00:00',1500,3,209,0005),
			(16,'2026-10-19','18:00:00',1000,2,210,0003);

SELECT * FROM Funcion;


--Compra 
INSERT INTO Compra (id_compra,fecha_compra,hora_compra,total_compra,id_cliente,id_pago) VALUES
			--compra 6
			(1006,'2026-10-11','10:20:00',2000,0007,1),
			--compra 7
			(1007,'2026-10-11','15:05:10',3000,0008,2),
			--compra 8
			(1008,'2026-10-12','11:40:30',2400,0009,3),
			--compra 9
			(1009,'2026-10-12','19:10:45',4800,0010,5),
			--compra 10
			(1010,'2026-10-13','09:15:00',2200,0011,6),
			--compra 11
			(1011,'2026-10-13','17:50:20',3000,0012,2),
			--compra 12
			(1012,'2026-10-14','12:30:00',2400,0013,1),
			--compra 13
			(1013,'2026-10-14','20:05:15',6000,0014,4),
			--compra 14
			(1014,'2026-10-15','16:45:50',4000,0015,7),
			--compra 15
			(1015,'2026-10-16','09:00:00',2000,0016,3);

SELECT * FROM Compra;

--Ticket
INSERT INTO Ticket(nro_item,id_compra,precio_unitario,id_butaca,id_funcion) VALUES
			--compra 1006
			(15,1006,1000,100,7),
			(16,1006,1000,101,7),
			--compra 1007
			(17,1007,1000,105,8),
			(18,1007,1000,106,8),
			(19,1007,1000,107,8),
			--compra 1008
			(20,1008,1200,110,9),
			(21,1008,1200,111,9),
			--compra 1009
			(22,1009,1200,115,10),
			(23,1009,1200,116,10),
			(24,1009,1200,117,10),
			(25,1009,1200,118,10),
			--compra 1010 (dos funciones distintas)
			(26,1010,1200,120,11),
			(27,1010,1000,100,12),
			--compra 1011
			(28,1011,1000,101,12),
			(29,1011,1000,102,12),
			(30,1011,1000,103,12),
			--compra 1012
			(31,1012,1200,115,13),
			(32,1012,1200,116,13),
			--compra 1013 (funcion agotada)
			(33,1013,1200,105,14),
			(34,1013,1200,106,14),
			(35,1013,1200,107,14),
			(36,1013,1200,108,14),
			(37,1013,1200,109,14),
			--compra 1014 (dos funciones distintas)
			(38,1014,1500,121,15),
			(39,1014,1500,122,15),
			(40,1014,1000,110,16),
			--compra 1015
			(41,1015,1000,111,16),
			(42,1015,1000,112,16);

SELECT * FROM Ticket;
