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


## Entidad: Pelicula

**Propósito/Descripción:** Almacenar información detallada sobre las películas que se encuentran disponibles en el catálogo del cine.
**Como interactúa con el sistema:** Representa la obra cinematográfica base que se va a proyectar, relacionándose directamente con la tabla `Funcion` a través del campo `id_pelicula`.
**Explicacion de su descripcion de la tabla:**

* *id_pelicula int NOT NULL*: lo definimos como llave primaria (CONSTRAINT pk_pelicula) para garantizar un identificador único y no nulo para cada película registrada. Además, se define CONSTRAINT uq_id_pelicula UNIQUE (id_pelicula) para reforzar esa unicidad.
* *titulo varchar(70) NOT NULL*: Se reservan 70 caracteres para dar soporte a nombres de películas moderadamente largos, y tiene como restricción "NOT NULL" para asegurarnos de que el título siempre esté presente.
* *genero varchar(30) NOT NULL*: Se reservan 30 caracteres para especificar la categoría de la película (ej. Acción, Terror, Comedia), siendo obligatorio su ingreso ("NOT NULL").
* *descripcion varchar(200) NOT NULL*: Se asignan 200 caracteres para almacenar una breve sinopsis o resumen de la trama, con restricción "NOT NULL" para que ninguna película quede sin descripción.
* *duracion int NOT NULL*: Se define como un número entero para representar el tiempo total en minutos de la película, siendo obligatorio ("NOT NULL").

---

## Entidad: Metodo_Pago

**Propósito/Descripción:** Almacenar los distintos medios o formas de pago que el sistema acepta para concretar las ventas.
**Como interactúa con el sistema:** Representa la vía por la cual el cliente abona, relacionándose directamente con la tabla `Compra` a través del campo `id_pago`.
**Explicacion de su descripcion de la tabla:**

* *id_pago int NOT NULL*: lo definimos como llave primaria (CONSTRAINT pk_metodo_pago) para garantizar un identificador único y no nulo para cada método de pago. Además, se define CONSTRAINT uq_id_pago UNIQUE (id_pago) para reforzar su unicidad.
* *descripcion_pago varchar(50)*: Se reservan 50 caracteres para describir de manera clara la forma de pago (por ejemplo, "Tarjeta de Crédito", "Efectivo", "Mercado Pago"). No se le agregó explícitamente la restricción "NOT NULL" en su creación, por lo que permite valores nulos, aunque su objetivo principal es detallar el nombre del método.

* *id_pago int NOT NULL: lo definimos como llave primaria (CONSTRAINT pk_metodo_pago) para garantizar un identificador único y no nulo para cada método de pago. Además, se define CONSTRAINT uq_id_pago UNIQUE (id_pago) para reforzar su unicidad.
descripcion_pago varchar(50): Se reservan 50 caracteres para describir de manera clara la forma de pago (por ejemplo, "Tarjeta de Crédito", "Efectivo", "Mercado Pago"). No se le agregó explícitamente la restricción "NOT NULL" en su creación, por lo que permite valores nulos, aunque su objetivo principal es detallar el nombre del método.
