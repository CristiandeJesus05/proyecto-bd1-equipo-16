--- TABLA Cliente ---
CREATE TABLE Cliente(
id_cliente int NOT NULL,
dni int NOT NULL,
nombre varchar(60) NOT NULL,
apellido varchar(60) NOT NULL,
email varchar(100) NOT NULL,
telefono varchar(20) NOT NULL,
--- Clave primaria de cliente ---
CONSTRAINT pk_cliente primary key (id_cliente),
--- Restricciones tabla cliente ---
CONSTRAINT uq_id_cliente UNIQUE (id_cliente),
CONSTRAINT uq_dni UNIQUE (dni),
CONSTRAINT uq_email UNIQUE (email)
);

--- TABLA Sala ---
CREATE TABLE Sala(
id_sala int NOT NULL,
nombre_sala varchar(20),
capacidad int NOT NULL,
--- Clave primaria Sala ---
CONSTRAINT pk_sala primary key(id_sala),
--- Restricciones tabla Sala ---
CONSTRAINT uq_id_sala UNIQUE (id_sala)
);

--- TABLA Pelicula ---
CREATE TABLE Pelicula(
id_pelicula int NOT NULL,
titulo varchar(70) NOT NULL,
genero varchar(30) NOT NULL,
--- Breve descripcion de la pelicula ---
descripcion varchar(200) NOT NULL,
--- Duracion en minutos ---
duracion int NOT NULL,
--- Clave primaria pelicula ---
CONSTRAINT pk_pelicula primary key (id_pelicula),
--- Restricciones tabla pelicula ---
CONSTRAINT uq_id_pelicula UNIQUE (id_pelicula)
);

--- Tabla Metodo Pago ---
CREATE TABLE Metodo_Pago(
id_pago int NOT NULL,
descripcion_pago varchar(50),
--- Clave primaria metodo pago ---
CONSTRAINT pk_metodo_pago primary key(id_pago),
--- Restricciones tabla metodo pago ---
CONSTRAINT uq_id_pago UNIQUE (id_pago)
);

--- TABLA Butaca ---
CREATE TABLE Butaca(
id_butaca int NOT NULL,
numero int NOT NULL,
fila varchar(5) NOT NULL,
id_sala int NOT NULL,
--- Clave primaria Butaca ---
CONSTRAINT pk_butaca primary key(id_butaca),
--- Restricciones tabla Butaca ---
CONSTRAINT uq_numero UNIQUE(numero),
CONSTRAINT uq_fila UNIQUE(fila),
--- Claves Foraneas ---
CONSTRAINT fk_butaca_sala foreign key(id_sala) REFERENCES Sala(id_sala)
);

--- Tabla Funcion ---
CREATE TABLE Funcion(
id_funcion int NOT NULL,
fecha date NOT NULL,
hora time NOT NULL,
precio_actual decimal(10,2) NOT NULL,
stock_disponible int NOT NULL,
id_pelicula int NOT NULL,
id_sala int NOT NULL,
--- Clave primaria Funcion ---
CONSTRAINT pk_funcion primary key(id_funcion),
--- Restricciones tabla Funcion ---
CONSTRAINT ck_precio_acutal CHECK (precio_actual >= 0),
CONSTRAINT ck_stock_disponible CHECK (stock_disponible >= 0),
--- Claves Foraneas ---
CONSTRAINT fk_funcion_pelicula foreign key(id_pelicula) REFERENCES Pelicula(id_pelicula),
CONSTRAINT fk_funcion_sala foreign key(id_sala) REFERENCES Sala(id_sala)
);

--- Tabla Compra ---
CREATE TABLE Compra(
id_compra int NOT NULL,
fecha_compra date NOT NULL,
hora_compra time NOT NULL,
total_compra decimal(10,2) NOT NULL,
id_pago int NOT NULL,
id_cliente int NOT NULL,
--- Clave primaria Compra ---
CONSTRAINT pk_compra primary key(id_compra),
--- Restricciones tabla Compra ---
CONSTRAINT ck_total_compra CHECK(total_compra >= 0),
--- Claves foraneas ---
CONSTRAINT fk_compra_pago foreign key (id_pago) REFERENCES Metodo_Pago(id_pago),
CONSTRAINT fk_compra_cliente foreign key (id_cliente) REFERENCES Cliente(id_cliente)
);

--- Tabla Ticket ---
CREATE TABLE Ticket(
nro_item int NOT NULL,
id_compra int NOT NULL,
precio_unitario decimal(10,2) NOT NULL,
id_butaca int NOT NULL,
id_funcion int NOT NULL,
--- Clave primaria Ticket ---
CONSTRAINT pk_ticket primary key(nro_item, id_compra),
--- Restricciones tabla Ticket ---
CONSTRAINT ck_precio_unitario CHECK(precio_unitario >= 0),
--- Evita vender la misma butaca dos veces para una misma funcion ---
CONSTRAINT uq_ticket_funcion_butaca UNIQUE(id_funcion, id_butaca),
--- Claves foraneas ---
CONSTRAINT fk_ticket_compra foreign key(id_compra) REFERENCES Compra(id_compra),
CONSTRAINT fk_ticket_butaca foreign key(id_butaca) REFERENCES Butaca(id_butaca),
CONSTRAINT fk_ticket_funcion foreign key(id_funcion) REFERENCES Funcion(id_funcion)
);

--CAMBIOS ---
--BUTACA--
ALTER TABLE butaca drop uq_numero
ALTER TABLE butaca drop uq_fila
ALTER TABLE butaca drop fk_butaca_sala
ALTER TABLE butaca add CONSTRAINT uq_fila UNIQUE(id_sala, numero, fila)
--Al poner unico los 3 nos aseguramos de que los 3 si o si sean distinto

--FUNCION--
ALTER TABLE Funcion add constraint uq_funcion_especifica UNIQUE (fecha,hora,id_sala)
--Al poner unico los 3, nos aseguramos que una funcion no empiece en la misma sala y hora
---ERROR DETECTADO : una funcion puede reproducir la pelicula si este ya está reproduciendo una pelicula un minuto despues
---Recordatorio: solucionar a futuro con funciones
