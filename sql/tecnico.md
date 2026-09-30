## Entidad: Cliente  
**Propósito/Descripción:** Almacenar información de los usuarios que realizan compras en la plataforma.  
**Como interactúa con el sistema:** Representa la entidad principal para identificar quien es el que hace las transacciones de compra.  
**Explicacion de su descripcion de la tabla:**  
* *id_cliente int NOT NULL:* lo definimos como llave primaria (CONSTRAINT pk_cliente) para garantizar un identificador único y no nulo, además, se define CONSTRAINT uq_id_cliente UNIQUE (id_cliente) para reforzar esa unicidad.  
* *dni int NOT NULL:* lo definimos para garantizar un identificador nacional del cliente, como dos única restricción, el DNI es "NOT NULL"   debido a que es obligatorio que el cliente posea el DNI y debe ser unico (CONSTRAINT uq_dni UNIQUE (dni))  
* *nombre varchar(60) NOT NULL, apellido varchar(60) NOT NULL:* Se reservan 60 caracteres en ambos campos para dar soporte a su nombre y apellido, además ambos tienen como restricción "NOT NULL" para asegurarnos que el cliente este completo.  
* *email varchar(100) NOT NULL:* Se reserva 100 caracteres con consideracion de email largos, tiene como restriccion "NOT NULL" ya que debe ser obligatorio y debe de ser unico para cada cliente (CONSTRAINT uq_email UNIQUE (email)).  
* *telefono varchar(20) NOT NULL:* Se reserva 20 caracteres para poder guardar un numero de teléfono para comunicación con el cliente y debe de ser obligatorio(NOT NULL).  


## Entidad: Sala  
**Propósito/Descripción:** Almacenar información del numero y lugar de la sala considerando cuantas bucatas disponibles hay.  
**Como interactúa con el sistema:** Representa una entidad fisica donde se llevara a cabo las funciones donde el cliente debe de participar y proporciona los asientos que son comprados por el mismo.  
**Explicacion de su descripcion de la tabla:**  
* *id_sala int NOT NULL:* Lo definimos como clave primaria (Constraint pk_sala) para garantizar un identificador unico y no nulo.  
* *nombre_sala varchar(20):* Se reserva 20 caracteres que tomara el nombre la sala(es opcional)
* *capacidad int NOT NULL:* Lo definimos para poder saber la capacidad que contiene una sala para poder controlar las ventas de tickets, este campo debe ser obligatorio (NOT NULL) 
