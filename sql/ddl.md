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
