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
CONSTRAINT uq_email UNIQUE (email),  
);  
  
--- TABLA Sala ---  
CREATE TABLE Sala(  
id_sala int NOT NULL,  
nombre_sala varchar(20),  
capacidad int NOT NULL,  
--- Clave primaria Sala ---  
CONSTRAINT pk_sala primary key(id_sala),  
--- Restrestricciones tabla Sala ---  
CONSTRAINT uq_id_sala UNIQUE (id_sala),  
);

--- TABLA Butaca ---<br>
id_butaca int NOT NULL,<br>
numero int NOT NULL,<br>
fila varchar(5) NOT NULL,<br>
id_sala int NOT NULL,<br>
--- Clave primaria Butaca ---<br>
CONSTRAINT pk_butaca primary key(id_butaca),<br>
--- Restricciones tabla Butaca ---<br>
CONSTRAINT uq_id_butaca UNIQUE(id_butaca),<br>
CONSTRAINT uq_numero UNIQUE(numero),<br>
CONSTRAINT uq_fila UNIQUE(fila),<br>
--- Claves Foraneas ---<br>
CONSTRAINT fk_butaca_sala foreign key(id_sala) REFERENCES Sala(id_sala),<br>
);<br>

--- Tabla Funcion ---<br>
CREATE TABLE Funcion(<br>
id_funcion int NOT NULL,<br>
fecha date NOT NULL,<br>
hora time NOT NULL,<br>
precio_actual decimal(10,2) NOT NULL,<br>
stock_disponible int NOT NULL,<br>
id_pelicula int NOT NULL,<br>
id_sala int NOT NULL,<br>
--- Clave primaria Funcion ---<br>
CONSTRAINT pk_funcion primary key(id_funcion),<br>
--- Restricciones tabla Funcion ---<br>
CONSTRAINT uq_id_funcion UNIQUE (id_funcion),<br>
CONSTRAINT uq_fecha UNIQUE(fecha),<br>
CONSTRAINT uq_hora UNIQUE(hora),<br>
CONSTRAINT ck_precio_acutal CHECK (precio_actual >= 0),<br>
CONSTRAINT ck_stock_disponible CHECK (stock_disponible >= 0),<br>
--- Claves Foraneas ---<br>
CONSTRAINT fk_funcion_pelicula foreign key(id_pelicula) REFERENCES Pelicula(id_pelicula),<br>
CONSTRAINT fk_funcion_sala foreign key(id_sala) REFERENCES Sala(id_sala),<br>
);<br>

--- Tabla Compra ---<br>
CREATE TABLE Compra(<br>
id_compra int NOT NULL,<br>
fecha_compra date NOT NULL,<br>
hora_compra datetime NOT NULL,<br>
total_compra decimal(10,2) NOT NULL,<br>
id_pago int NOT NULL,<br>
id_cliente int NOT NULL,<br>
--- Clave primaria Compra-<br>
CONSTRAINT pk_compra primary key(id_compra),<br>
--- Restricciones tabla Compra ---<br>
CONSTRAINT uq_id_compra UNIQUE(id_compra),<br>
CONSTRAINT ck_total_compra CHECK(total_compra >= 0),<br>
--- Claves foraneas ---<br>
CONSTRAINT fk_compra_pago foreign key (id_pago) REFERENCES Metodo_Pago(id_pago),<br>
CONSTRAINT fk_compra_cliente foreign key (id_cliente) REFERENCES Cliente(id_cliente),<br>
);<br>

--- Tabla Ticket ---<br>
CREATE TABLE Ticket(<br>
nro_item int NOT NULL,<br>
id_compra int NOT NULL,<br>
precio_unitario decimal(10,2) NOT NULL,<br>
id_butaca int NOT NULL,<br>
id_funcion int NOT NULL,<br>
--- Clave primaria Ticket ---<br>
CONSTRAINT pk_ticket primary key(nro_item, id_compra),<br>
--- Restricciones tabla Ticket ---<br>
CONSTRAINT uq_nro_item UNIQUE(nro_item),<br>
CONSTRAINT ck_precio_unitario CHECK(precio_unitario >= 0),<br>
--- Claves foraneas ---<br>
CONSTRAINT fk_ticket_compra foreign key(id_compra) REFERENCES Compra(id_compra),<br>
CONSTRAINT fk_ticket_butaca foreign key(id_butaca) REFERENCES Butaca(id_butaca),<br>
CONSTRAINT fk_ticket_funcion foreign key(id_funcion) REFERENCES Funcion(id_funcion),<br>
);<br>
