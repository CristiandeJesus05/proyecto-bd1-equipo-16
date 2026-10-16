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

## Entidad: Butaca
**Propósito/Descripción:** Almacenar las butacas disponibles dentro de cada sala del cine<br>

**Como interactúa con el sistema:** Representa cada asiento fisico de una sala y permite asociarlo con los tickets vendidos para una determinada funcion.

**Explicacion de su descripcion de la tabla:**
* *id_butaca int NOT NULL:* Se utilizia como identificador unico de cada butaca. Se define como clave primaria mediante CONSTRAINT pk_butaca, garantizando que cada registro pueda identificarse de manera unica y que el valor no sea nulo.
* *numero in NOT NULL:* Representa el numero de la butaca dentro de la sala. Se utiliza el tipo int porque se trata de un valor numerico entero y se establece NOT NULL debido que todas las butacas debe poseer cada una un numero.
* *fila varchar(5) NOT NULL:* Almacena la identificacion de la fila a la que pertenece cada butaca, por ejemplo: "A", "B", "C". Utilizamos varchar(5) porque la fila puede representarse mediante letras o una combinacion de caracteres y Se establece NOT NULL porque cada una de las butacas debe pertenecer a una fila
* *id_sala: int NOT NULL:* Representa la sala en la que se encuentra ubicada la Butaca. Utilizamos int debido a que corresponde al identificador unico y numerico de la sala y se establece NOT NULL porque una butaca no puede existir sin estar asociada a una sala.
#### Restricciones:
* CONSTRAINT uq_numero UNIQUE(numero): Garantiza que no existan dos registros con el mismo numero de butaca
* CONSTRAINT uq_fila UNIQUE(fila): Garantiza que no existan dos registros con la misma fila.

#### Claves Foraneas:
* CONSTRAINT fk_butaca_sala foreign key(id_sala) REFERENCES Sala(id_sala): Establece la relacion entre Butaca y Sala, garantizando que la sala asociada a una butaca exista previanmente en la tabla Sala.

## Entidad: Funcion
**Propósito/Descripción:** Almacenar la informacion de las funciones disponibles en el cine, indicando cuando se proyecta una pelicula, en que sala y cual es su precio.

**Como interactúa con el sistema:** Representa cada funcion programada y permite relacionar una pelicula con una sala y un horario determinado. Ademas, premite controlar el precio y la cantidad de tickets disponibles.

**Explicacion de su descripcion de la tabla:** 
* *id_funcion int NOT NULL:* Lo Utilizamos como identificador unico de cada funcion. Se define como clave primaria mediante CONSTRAINT pk_funcion, garantizando que cada funcion pueda identificarse de manera unica y que el valor no sea nulo.
* *fecha date NOT NULL:* Almacena la fecha en la que se realizarala funcion. Utilizamos el tipo date para almacenar el dia, mes y año. Lo establecemos como NOT NULL porque toda funcion debe tener una fecha asignada.
* *hora time NOT NULL:* Almacena el horario en el que comienza la funcion y utilizamos time para almacenar informacion relacionada con la hora. Lo establecemos como NOT NULL porque toda funcion debe tener un horario definido.
* *precio_actual decimal(10,2) NOT NULL:* Representa el precio actual del ticket para la función. Utilizamos decimal(10,2) porque permite almacenar valores monetarios con dos posiciones decimales. Establecemos NOT NULL porque toda función debe tener un precio definido.
* *stock_disponible int NOT NULL:* Representa la cantidad de tickets disponibles para la función. Utilizamos int porque se trata de una cantidad entera y se establece NOT NULL porque el sistema debe conocer la cantidad de tickets disponibles.
* *id_pelicula int NOT NULL:* Identifica la película que sera proyectada en la función. La utlizamos como clave foranea para relacionar la función con una pelicula ya existente.
* *id_sala int NOT NULL:* Identifica la sala donde se realizara la función. La utilizamos como clave foránea para relacionar la función con una sala existente.

#### Restricciones:
* CONSTRAINT ck_precio_actual CHECK(precio_actual >= 0): Garantiza que el precio de una función no pueda ser negativo.
* CONSTRAINT ck_stock_disponible CHECK(stock_disponible >= 0): Garantiza que la cantidad de tickets disponibles no pueda ser negativa.

#### Claves Foraneas:
* CONSTRAINT fk_funcion_pelicula foreign key(id_pelicula) REFERENCES Pelicula(id_pelicula): Relaciona cada función con una pelicula existente en la tabla Pelicula.
* CONSTRAINT fk_funcion_sala foreign key(id_sala) REFERENCES Sala(id_sala): Relaciona cada función con una sala existente en la tabla Sala.

## Entidad: Compra
**Propósito/Descripción:** Almacenar la información de cada compra realizada por un cliente, incluyendo la fecha, el total y el método de pago utilizado.

**Como interactúa con el sistema:** Representa la operación mediante la cual un cliente adquiere uno o varios tickets para diferentes funciones. Permite registrar quien realizo la compra y mediante que método de pago.

**Explicacion de su descripcion de la tabla:** 
* *id_compra int NOT NULL:* Se utiliza como identificador único de cada compra. Se define como clave primaria mediante CONSTRAINT pk_compra, garantizando que cada compra tenga un identificador único y no nulo.
* *fecha_compra date NOT NULL:* Almacena la fecha en la que se realizó la compra. Se utiliza date para registrar el día, mes y año. Se establece NOT NULL porque toda compra debe tener una fecha registrada.
* *hora_compra time NOT NULL:* Almacena el horario en el que se realizó la compra. Se utiliza time para registrar la hora y se establece NOT NULL porque toda compra debe registrar cuándo fue realizada.
* *total_compra decimal(10,2) NOT NULL:* Representa el importe total de la compra. Utilizamos decimal(10,2) para trabajar con valores monetarios y permitir dos posiciones decimales. Se establece NOT NULL porque toda compra debe tener un importe total.
* *id_pago int NOT NULL:* Identifica el método de pago utilizado para realizar la compra. Se utiliza como clave foranea para relacionar la compra con un metodo de pago existente.
* *id_cliente int NOT NULL:* Identifica al cliente que realizó la compra. Se utiliza como clave foranea para relacionar cada compra con un cliente registrado en el sistema.

#### Restricciones:
* CONSTRAINT ck_total_compra CHECK(total_compra >= 0): Garantiza que el total de una compra no pueda tener un valor negativo.

#### Claves Foraneas:
*CONSTRAINT fk_compra_pago foreign key(id_pago) REFERENCES Metodo_Pago(id_pago): Establece la relación entre la compra y el método de pago utilizado, garantizando que el método de pago exista en la tabla Metodo_Pago.
*CONSTRAINT fk_compra_cliente foreign key(id_cliente) REFERENCES Cliente(id_cliente): Establece la relación entre la compra y el cliente que la realizó, garantizando que el cliente exista en la tabla Cliente.

## Entidad: Ticket

**Propósito/Descripción:** Almacenar el detalle de cada ticket adquirido dentro de una compra, indicando su precio, butaca y función correspondiente.

**Como interactúa con el sistema:** Representa cada entrada adquirida por el cliente. Permite conocer que butaca fue seleccionada, para que función y cual era el precio del ticket en el momento de realizar la compra.

**Explicacion de su descripcion de la tabla:** 
* *nro_item int NOT NULL:* Representa el número de ítem del ticket dentro de una compra. Se utiliza int porque corresponde a un numero entero y se establece NOT NULL porque todo ticket debe poseer un número de ítem.
* *id_compra int NOT NULL:* Identifica la compra a la que pertenece el ticket. Se utiliza como parte de la clave primaria compuesta y tambien como clave foranea hacia la tabla Compra.
* *precio_unitario decimal(10,2) NOT NULL:* Almacena el precio que tenía el ticket en el momento en que se realizo la compra. Utilizamos decimal(10,2) porque representa un valor monetario y permite conservar dos posiciones decimales. Se establece NOT NULL porque cada ticket debe registrar su precio.
* *id_butaca int NOT NULL:* Identifica la butaca seleccionada para el ticket. La utilizamos como clave foranea para relacionar el ticket con una butaca existente.
* *id_funcion int NOT NULL:* Identifica la función del cine para la cual se adquirio el ticket. La utilizamos como clave foranea para relacionar el ticket con una funcion existente.

#### Clave pimaria:
* CONSTRAINT pk_ticket primary key(nro_item, id_compra): Establecemos una clave primaria compuesta formada por nro_item e id_compra. Esto permite identificar de manera única cada ticket dentro de una determinada compra. Por ejemplo, una compra puede tener los ítems 1, 2 y 3, y otra compra también puede tener los ítems 1, 2 y 3 sin generar conflictos, porque el identificador completo lo formamos combinando ambos valores.

#### Restricciones:
* CONSTRAINT ck_precio_unitario CHECK(precio_unitario >= 0): Garantiza que el precio de un ticket no pueda ser negativo.

#### Claves Foraneas:
* CONSTRAINT fk_ticket_compra foreign key(id_compra) REFERENCES Compra(id_compra): Relaciona cada ticket con la compra a la que pertenece.
* CONSTRAINT fk_ticket_butaca foreign key(id_butaca) REFERENCES Butaca(id_butaca): Relaciona el ticket con la butaca seleccionada.
* CONSTRAINT fk_ticket_funcion foreign key(id_funcion) REFERENCES Funcion(id_funcion): Relaciona el ticket con la función para la cual fue adquirido.
#### "Atributo precio_unitario":
Este nos permite conservar el precio histórico del ticket en el momento de la compra. De esta manera, si posteriormente cambia el precio de una función, el precio registrado en los tickets de compras anteriores no se modifica. Esto permite mantener un historial correcto de las operaciones realizadas.
