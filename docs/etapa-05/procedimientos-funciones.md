## Procedimientos y Funciones Almacenadas

### Aplicacion al sistema de venta de tickets de cine
Para nuestro sistema desarrollado implementamos los siguientes dos componentes
* Procedimiento Almacenado:  sp_RegistrarCompra: permitira registrar una compra realizada por un cliente, asociar los tickets a una función y a sus respectivas butacas, conservar el precio unitario aplicado y actualizar el stock disponible.
* Funcion Almacenada:  fn_RecaudacionPelicula: calculara la recaudación total obtenida por una película a partir de los precios unitarios almacenados en los tickets que hayan sido vendidos.

"*Estos componentes se relacionaran con las tablas de:* Compra, Ticket, Funcion, Pelicula, Metodo_Pago y Butaca."

### Ventajas y fundamentos de aplicacion
* La siguiente implementacion nos permitira reutilizar las operaciones de registro de compras y los calculos de recaudacion, disminuyendo asi la necesidad de tener que escribir consultas extensas cada vez que se requiere realizar alguna de estas tareas. Nos ayudara a centralizar las validaciones, como la disponibilidad del stock y la propia correspondencia entre las butacas y las salas de la funcion.

*Mediante nuestra funcion de recaudacion facilitara la elaboracion de informes y el analisis de los ingresos generados por cada pelicula*

### Resultados esperados
* Una vez ejecutado el siguiente procedimiento el sistema podra registrar una compra y sus tickets, conservando el precio aplicado en el momento de la operacion
* Una ve ejecutada la siguiente funcion obtendremos la recaudacion acumulada de la pelicula que indiquemos, incluso cuando todavia no tenga tickets vendidos, en ese mismo caso la funcion devolvera 0.

*La implementacion la comprobaremos mediante los scripts de demostracion que nos permitiran registrar una compra de prueba, consultar tickets
asociados y obtener la recaudacion de las peliculas registradas.*
