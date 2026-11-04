# Lote de Datos de Cine del Paraná

## Aplicación del lote de datos en el sistema de gestión de cine

El lote de datos del proyecto Cine del Paraná tiene como finalidad incorporar información de prueba a las diferentes tablas que conforman la base de datos. Estos registros permiten representar el funcionamiento de un cine, incluyendo sus clientes, salas, películas, métodos de pago, butacas, funciones, compras y tickets.

La carga se realiza mediante la instrucción `INSERT INTO`, que permite agregar nuevos registros a las tablas previamente creadas. Se establece un orden específico de inserción para respetar las relaciones entre las tablas y evitar inconvenientes con las claves foráneas.

## Orden de carga de los datos

La incorporación de los registros se organiza en cuatro etapas:

1. **Primera etapa:** Cliente, Sala, Pelicula y Metodo_Pago.
2. **Segunda etapa:** Butaca.
3. **Tercera etapa:** Funcion y Compra.
4. **Cuarta etapa:** Ticket.

Este orden permite cargar primero las entidades principales, posteriormente sus elementos relacionados y, finalmente, los registros que vinculan las compras con las funciones y las butacas.

## Desarrollo y carga de las tablas

### 1. Tabla Cliente

**Objetivo:** Registrar la información personal y de contacto de las personas que utilizan los servicios del cine.

En esta tabla se incorporan siete clientes, identificados mediante un código único (`id_cliente`). Para cada uno se almacenan los siguientes datos:

- DNI.
- Nombre.
- Apellido.
- Correo electrónico.
- Número de teléfono.

La información permite identificar a cada persona que realiza una compra y establecer una relación con la tabla `Compra`, mediante el campo `id_cliente`.

Se utiliza la instrucción `INSERT INTO Cliente` para incorporar los registros y posteriormente `SELECT * FROM Cliente` para consultar los datos almacenados.

### 2. Tabla Sala

**Objetivo:** Registrar los espacios físicos disponibles para proyectar películas dentro del establecimiento.

Se incorporan tres salas, identificadas con los códigos 1, 2 y 3, cuyos nombres son A, B y C, respectivamente. Cada una cuenta con una capacidad de cinco espectadores.

Los campos utilizados son:

- `id_sala`: identifica de manera única cada sala.
- `nombre_sala`: representa el nombre asignado.
- `capacidad`: indica la cantidad máxima de espectadores que puede recibir.

Esta tabla se relaciona con `Butaca`, ya que cada asiento pertenece a una sala determinada, y con `Funcion`, porque cada proyección se realiza en un espacio físico específico.

Al finalizar la carga, se utiliza `SELECT * FROM Sala` para verificar los registros incorporados.

### 3. Tabla Pelicula

**Objetivo:** Almacenar la información correspondiente a las películas disponibles para su proyección.

Se incorporan tres películas diferentes, cada una identificada mediante un código (`id_pelicula`):

- **El intocable:** género Terror, con una duración de 90 minutos.
- **Una noche para enamorarme:** género Romántica, con una duración de 75 minutos.
- **El gato panzón:** género Comedia, con una duración de 120 minutos.

Además del título, se registra el género, una breve descripción y la duración de cada producción.

Esta tabla permite mantener organizada la información de las películas y se relaciona con `Funcion`, dado que una película puede proyectarse en diferentes horarios y salas.

Se utiliza `SELECT * FROM Pelicula` para visualizar los registros cargados.

### 4. Tabla Metodo_Pago

**Objetivo:** Registrar las distintas alternativas de pago disponibles para los clientes al momento de realizar una compra.

Se incorporan cuatro métodos de pago:

- Efectivo.
- Tarjeta de crédito.
- Tarjeta de débito.
- Otros.

Cada alternativa cuenta con un identificador único (`id_pago`) y una descripción que permite reconocer el medio utilizado.

La tabla se relaciona con `Compra` mediante el campo `id_pago`, permitiendo identificar qué método se utilizó en cada operación.

Una vez finalizada la carga, se ejecuta `SELECT * FROM Metodo_Pago` para comprobar los registros incorporados.

### 5. Tabla Butaca

**Objetivo:** Registrar los asientos disponibles en cada una de las salas del cine.

Se incorporan quince butacas, distribuidas equitativamente entre las tres salas. Cada una cuenta con cinco asientos, numerados del 1 al 5 y ubicados en la fila 1.

Los campos utilizados son:

- `id_butaca`: identifica de manera única cada butaca.
- `numero`: indica el número del asiento.
- `fila`: identifica la ubicación del asiento dentro de la sala.
- `id_sala`: establece a qué sala pertenece.

La relación con `Sala` permite conocer la ubicación física de cada butaca. A su vez, esta información se utiliza posteriormente en `Ticket`, para identificar el asiento asignado a cada entrada.

En este caso, se utiliza la consulta `SELECT * FROM Butaca WHERE id_butaca = 107`, que permite verificar específicamente la información de la butaca identificada con el código 107, en lugar de mostrar todos los registros.

### 6. Tabla Funcion

**Objetivo:** Registrar las proyecciones programadas, estableciendo qué película se presenta, en qué sala y en qué fecha y horario.

Se incorporan seis funciones correspondientes al día 10 de octubre de 2026, distribuidas entre las tres salas y las tres películas registradas anteriormente.

Cada función almacena los siguientes datos:

- `id_funcion`: identifica la función.
- `fecha`: indica el día de la proyección.
- `hora`: establece el horario de inicio.
- `precio_actual`: representa el precio de cada entrada, establecido en $1000.
- `stock_disponible`: indica la disponibilidad inicial de entradas, establecida en cinco unidades por función.
- `id_pelicula`: identifica la película que se proyectará.
- `id_sala`: determina el espacio donde se realizará la proyección.

Esta tabla cumple un papel fundamental, ya que vincula las películas con las salas y sus respectivos horarios. Además, se relaciona con `Ticket`, permitiendo identificar a qué función corresponde cada entrada vendida.

Finalmente, se utiliza `SELECT * FROM Funcion` para consultar las seis funciones incorporadas.

### 7. Tabla Compra

**Objetivo:** Registrar las operaciones de compra realizadas por los clientes del cine.

Se incorporan cinco compras, identificadas mediante códigos que van desde el 1001 hasta el 1005.

Para cada operación se almacena:

- `id_compra`: identifica de manera única la compra.
- `fecha_compra`: registra el día en que se realizó.
- `hora_compra`: indica el horario de la operación.
- `total_compra`: representa el importe total abonado.
- `id_cliente`: identifica al cliente que efectuó la compra.
- `id_pago`: determina el método de pago utilizado.

Los registros representan diferentes operaciones, con distintos clientes, fechas, horarios e importes. Los montos registrados son de $2000, $3000, $5000, $1000 y $3000, respectivamente.

La tabla se relaciona con `Cliente`, para identificar quién realizó la operación; con `Metodo_Pago`, para reconocer el medio de pago utilizado; y con `Ticket`, ya que cada compra puede contener una o varias entradas.

### 8. Tabla Ticket

**Objetivo:** Registrar las entradas adquiridas en cada compra, identificando la función y la butaca correspondiente.

Esta tabla constituye el vínculo entre las compras realizadas y las funciones disponibles. Se incorporan catorce tickets, distribuidos entre las cinco compras registradas.

Los campos utilizados son:

- `nro_item`: identifica el número de ítem del ticket.
- `id_compra`: indica a qué compra pertenece la entrada.
- `precio_unitario`: registra el precio individual de cada ticket, establecido en $1000.
- `id_butaca`: identifica el asiento asignado.
- `id_funcion`: determina a qué función corresponde la entrada.

La información permite conocer cuántas entradas se adquirieron en cada operación, qué importe corresponde a cada una y qué asiento fue asignado.

Además, mediante las relaciones con `Compra`, `Butaca` y `Funcion`, es posible consultar el detalle de las ventas y controlar la asignación de asientos para cada proyección.

La distribución de los tickets cargados es la siguiente:

- Compra 1001: dos tickets.
- Compra 1002: tres tickets.
- Compra 1003: cinco tickets.
- Compra 1004: un ticket.
- Compra 1005: tres tickets.

En total, se registran catorce entradas, con un precio unitario de $1000.

## Resultados esperados de la carga

Una vez ejecutadas todas las instrucciones, la base de datos cuenta con información de prueba distribuida de la siguiente manera:

| Tabla | Cantidad de registros |
|---|---:|
| Cliente | 7 |
| Sala | 3 |
| Pelicula | 3 |
| Metodo_Pago | 4 |
| Butaca | 15 |
| Funcion | 6 |
| Compra | 5 |
| Ticket | 14 |
| **Total** | **57** |

Estos registros permiten representar diferentes situaciones del funcionamiento del cine, desde la identificación de los clientes y la programación de las películas hasta la realización de compras y la asignación de entradas.


## Conclusión

El lote de datos permite incorporar información representativa para comprobar el funcionamiento de la base de datos Cine del Paraná. La carga se organiza respetando las relaciones existentes entre las tablas, comenzando por los datos principales y finalizando con los tickets asociados a cada compra.

De esta manera, se dispone de registros que permiten realizar consultas, analizar las ventas, identificar los métodos de pago utilizados, controlar la asignación de butacas y obtener información sobre las funciones programadas. Estos datos constituyen una base de prueba para verificar las relaciones y el funcionamiento de las distintas operaciones implementadas en el sistema.
