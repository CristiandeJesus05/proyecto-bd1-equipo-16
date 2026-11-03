# Índices y Optimización

### Aplicación al sistema de venta de tickets de cine

Para nuestro sistema desarrollado implementamos diferentes mecanismos de optimización en SQL Server, con el objetivo de mejorar el acceso a la información y controlar las operaciones que se realizan sobre las tablas.

Los componentes que incorporamos son:

* **Índices no agrupados (Nonclustered Indexes):** permiten agilizar determinadas búsquedas y consultas sobre las tablas Compra, Funcion y Ticket.
* **Optimización del procedimiento almacenado sp_RegistrarCompra:** incorporamos mecanismos de control de transacciones, manejo de errores y concurrencia para garantizar que las compras se registren correctamente.
* **Aprovechamiento de índices existentes:** utilizamos los índices generados automáticamente por las claves primarias y restricciones UNIQUE, evitando crear estructuras redundantes.

"Estos componentes se relacionan principalmente con las tablas de: Compra, Cliente, Metodo_Pago, Funcion, Pelicula, Ticket y Butaca."

### Ventajas y fundamentos de aplicación

* La implementación de índices nos permitirá mejorar el acceso a los registros, especialmente en aquellas columnas que participan frecuentemente en búsquedas y relaciones entre tablas. De esta manera, SQL Server podrá localizar determinados datos sin necesidad de recorrer todos los registros de una tabla en cada consulta.

* La optimización del procedimiento almacenado nos permitirá controlar las operaciones que intervienen en una compra, evitando que se registren datos incompletos y manteniendo la consistencia entre la compra, sus tickets y el stock disponible.

* También aprovechamos los índices generados por las claves primarias y restricciones de unicidad, evitando la creación de índices innecesarios sobre columnas que ya cuentan con una estructura de búsqueda.

### Resultados esperados

* Una vez creados los índices, determinadas consultas y relaciones entre tablas podrán ejecutarse de manera más eficiente.
* Mediante la optimización del procedimiento almacenado, las operaciones de registro de compras se realizarán dentro de una transacción, permitiendo confirmar los cambios únicamente cuando todas las operaciones se completen correctamente.
* Ante un error, los cambios realizados durante la transacción podrán revertirse, evitando que la compra quede registrada parcialmente.
* El control de concurrencia ayudará a evitar conflictos cuando se realicen compras simultáneas para una misma función.

"La implementación la comprobaremos mediante consultas de verificación de índices, pruebas del procedimiento almacenado y consultas que permitan observar los cambios realizados en las compras, tickets y stock disponible."

---

## Índices no agrupados (Nonclustered Indexes)

### ¿Qué son los índices?

Los índices son estructuras que permiten localizar registros de una tabla de manera más eficiente. Funcionan como una referencia organizada de los valores almacenados en determinadas columnas, facilitando la búsqueda de información.

En SQL Server existen diferentes tipos de índices. Para nuestro proyecto incorporamos índices no agrupados, que mantienen una estructura independiente de los datos de la tabla y permiten acceder a los registros correspondientes mediante las columnas seleccionadas.

### Creación de los índices

Para crear estos índices utilizamos la instrucción:

*CREATE INDEX*

Esta instrucción permite generar un índice sobre una o varias columnas de una tabla.

La estructura general es:

*CREATE INDEX nombre_indice ON tabla(columna);*

A continuación explicamos los índices incorporados en nuestro sistema.

### Índices en la tabla Compra

#### Índice idx_compra_cliente

*CREATE INDEX idx_compra_cliente ON Compra(id_cliente);*

Este índice se creó sobre la columna `id_cliente` de la tabla Compra.

Su finalidad es facilitar las búsquedas y relaciones entre los clientes y las compras que realizaron.

Cuando necesitamos consultar las compras de un cliente determinado, este índice puede ayudar a localizar los registros correspondientes de manera más eficiente.

#### Índice idx_compra_pago

*CREATE INDEX idx_compra_pago ON Compra(id_pago);*

Este índice se creó sobre la columna `id_pago` de la tabla Compra.

Permite facilitar las consultas relacionadas con los métodos de pago utilizados en las compras.

De esta manera, cuando necesitamos recuperar las compras realizadas mediante un método de pago determinado, SQL Server puede aprovechar esta estructura para localizar los registros correspondientes.

### Índices en la tabla Funcion

#### Índice idx_funcion_pelicula

*CREATE INDEX idx_funcion_pelicula ON Funcion(id_pelicula);*

Este índice se creó sobre la columna `id_pelicula` de la tabla Funcion.

Su finalidad es facilitar la búsqueda de las funciones correspondientes a una película determinada.

También resulta útil para las consultas de negocio que relacionan las tablas Pelicula y Funcion, como el informe de películas menos vendidas.

#### Índice idx_funcion_sala_fecha

*CREATE INDEX idx_funcion_sala_fecha ON Funcion(id_sala, fecha);*

Este índice se creó sobre dos columnas de la tabla Funcion: `id_sala` y `fecha`.

A diferencia de los índices anteriores, este es un índice compuesto, porque utiliza más de una columna para organizar la búsqueda.

Su finalidad es facilitar la localización de funciones programadas en una sala durante una fecha determinada.

El orden de las columnas es importante: primero permite buscar por `id_sala` y luego utilizar `fecha` para precisar los resultados.

### Índice en la tabla Ticket

#### Índice idx_ticket_compra

*CREATE INDEX idx_ticket_compra ON Ticket(id_compra);*

Este índice se creó sobre la columna `id_compra` de la tabla Ticket.

Su finalidad es facilitar la búsqueda de los tickets asociados a una compra determinada.

Resulta útil cuando necesitamos consultar las entradas que fueron adquiridas en una misma operación.

---

## Aprovechamiento de índices existentes

Además de los índices que creamos manualmente, aprovechamos los que SQL Server genera automáticamente mediante las claves primarias y restricciones de unicidad.

### Claves primarias

Las claves primarias identifican de manera única cada registro de una tabla y generan un índice para facilitar su búsqueda.

En nuestro sistema se encuentran implementadas en las tablas:

* Cliente.
* Compra.
* Metodo_Pago.
* Butaca.
* Funcion.
* Ticket.

Por este motivo, no necesitamos crear índices adicionales sobre esas mismas claves primarias.

### Restricciones UNIQUE

Las restricciones UNIQUE permiten evitar valores duplicados en las columnas o combinaciones de columnas establecidas.

En particular, aprovechamos dos restricciones importantes:

* **Butaca:** la restricción UNIQUE sobre `(id_sala, fila, numero)` permite identificar una butaca dentro de una sala, evitando que existan dos butacas con la misma ubicación en ese espacio.
* **Ticket:** la restricción UNIQUE sobre `(id_funcion, id_butaca)` impide que una misma butaca se venda más de una vez para una misma función.

Estas restricciones también generan índices únicos, que pueden aprovecharse para determinadas búsquedas.

De esta manera evitamos duplicar índices sobre columnas que ya cuentan con una estructura de acceso.

---

## Optimización del procedimiento almacenado sp_RegistrarCompra

Además de la incorporación de índices, realizamos mejoras en el procedimiento almacenado `sp_RegistrarCompra`, encargado de registrar las compras de entradas del cine.

El objetivo de esta optimización es controlar las operaciones que se ejecutan durante una compra, evitando inconsistencias en los datos y problemas relacionados con la disponibilidad de entradas.

### Incorporación de transacciones

Para controlar las operaciones de registro utilizamos las siguientes instrucciones:

*BEGIN TRANSACTION*

*COMMIT TRANSACTION*

*ROLLBACK TRANSACTION*

Estas instrucciones permiten agrupar varias operaciones para que sean tratadas como una única transacción.

En nuestro procedimiento se utilizan de la siguiente manera:

* **BEGIN TRANSACTION:** inicia la transacción antes de comenzar las operaciones de registro.
* **COMMIT TRANSACTION:** confirma los cambios cuando todas las operaciones se completaron correctamente.
* **ROLLBACK TRANSACTION:** revierte los cambios realizados cuando ocurre un error.

De esta manera, si se produce un problema durante la inserción de los tickets o la actualización del stock, también se puede deshacer el registro de la compra.

### Manejo de errores mediante TRY...CATCH

Incorporamos la estructura:

*BEGIN TRY*

*BEGIN CATCH*

Esta estructura permite controlar los errores que pueden producirse durante la ejecución del procedimiento.

* **BEGIN TRY:** contiene las instrucciones que intentamos ejecutar correctamente.
* **BEGIN CATCH:** permite capturar los errores que se producen durante esas operaciones.

Dentro del bloque CATCH utilizamos:

*IF @@TRANCOUNT > 0*

*ROLLBACK TRANSACTION;*

*THROW;*

* `@@TRANCOUNT` permite conocer la cantidad de transacciones abiertas.
* `ROLLBACK TRANSACTION` revierte las operaciones pendientes.
* `THROW` vuelve a generar el error para informar el problema ocurrido.

Esto permite evitar que una compra quede registrada parcialmente cuando alguna operación falla.

### Control de concurrencia mediante UPDLOCK y HOLDLOCK

Para controlar las compras simultáneas incorporamos las indicaciones:

*WITH (UPDLOCK, HOLDLOCK)*

Estas se utilizan en la consulta que obtiene los datos de la función seleccionada:

*SELECT @Precio = precio_actual, @Stock = stock_disponible, @IdSala = id_sala FROM Funcion WITH (UPDLOCK, HOLDLOCK) WHERE id_funcion = @IdFuncion;*

* **UPDLOCK:** solicita un bloqueo de actualización sobre los registros consultados.
* **HOLDLOCK:** mantiene los bloqueos correspondientes durante la transacción, utilizando un comportamiento equivalente a SERIALIZABLE para esa referencia.

En nuestro sistema estos mecanismos ayudan a evitar que dos compras simultáneas utilicen al mismo tiempo una disponibilidad de stock que todavía no fue actualizada.

### Control del stock disponible

El procedimiento mantiene la actualización del stock mediante la instrucción:

*UPDATE Funcion SET stock_disponible = stock_disponible - @Cantidad WHERE id_funcion = @IdFuncion;*

Esta operación descuenta la cantidad de tickets registrados del stock disponible de la función correspondiente.

Además, el procedimiento verifica previamente que la cantidad solicitada no supere el stock existente.

De esta manera evitamos registrar una compra cuando no hay suficientes entradas disponibles.

Es importante que el descuento del stock se realice mediante un único mecanismo. Por eso, el procedimiento administra esta actualización y no debe duplicarse mediante otro trigger que también descuente las entradas al insertar tickets.

---

## Verificación de las mejoras implementadas

Para comprobar la implementación de los índices podemos consultar las estructuras existentes en SQL Server mediante:

*SELECT t.name AS nombre_tabla, i.name AS nombre_indice, i.type_desc AS tipo_indice FROM sys.indexes AS i INNER JOIN sys.tables AS t ON i.object_id = t.object_id;*

Esta consulta permite observar los índices asociados a las tablas de nuestra base de datos.

También podemos evaluar el comportamiento de las consultas mediante:

*SET STATISTICS IO ON;*

*SET STATISTICS TIME ON;*

Estas instrucciones permiten obtener información sobre las lecturas realizadas y el tiempo de ejecución de las consultas.

Por otra parte, las mejoras del procedimiento se comprueban mediante compras de prueba, verificando que los registros se almacenen correctamente, que los tickets queden asociados a la compra y que el stock se actualice según la cantidad de entradas adquiridas.

<img width="620" height="97" alt="Captura de pantalla 2026-11-03 193508" src="https://github.com/user-attachments/assets/832d04e5-6f43-4ece-ad56-553d0b429b76" />

*Esta es el resultado de la prueba de compra realizada.*

---

## Conclusión

La incorporación de índices y mecanismos de optimización permite mejorar distintos aspectos del funcionamiento de nuestra base de datos. Los índices facilitan el acceso a la información y las relaciones entre las tablas, mientras que las modificaciones realizadas en el procedimiento almacenado permiten controlar las operaciones de compra y mantener la consistencia de los registros.

De esta manera, buscamos que el sistema pueda administrar las consultas y las ventas de entradas de forma más eficiente, evitando estructuras de índices redundantes y reduciendo la posibilidad de inconsistencias durante las operaciones.
