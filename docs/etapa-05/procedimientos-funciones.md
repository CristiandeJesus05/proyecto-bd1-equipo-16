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
* Una vez ejecutada la siguiente funcion obtendremos la recaudacion acumulada de la pelicula que indiquemos, incluso cuando todavia no tenga tickets vendidos, en ese mismo caso la funcion devolvera 0.

*La implementacion la comprobaremos mediante los scripts de demostracion que nos permitiran registrar una compra de prueba, consultar tickets
asociados y obtener la recaudacion de las peliculas registradas.*

### Procedimiento Almacenado: *sp_RegistrarCompra*
*Este procedimiento recibe los datos de la compra y una lista de identificadores de butacas*

*Definicion del procedimiento y parametros:
"*CREATE OR ALTER PROCEDURE dbo.sp_RegistrarCompra*"
Esta instrucción crea el procedimiento si no existe o modifica su definición si ya existe. dbo es el esquema de la base de datos.

Los parámetros que aparecen a continuación son los datos que el procedimiento recibe para registrar la compra:
* *@IdCompra*: Identificador de la compra.
* *@FechaCompra*:	Fecha en que se realiza la compra.
* *@HoraCompra*:	Hora de la compra.
* *@IdPago*:	Método de pago seleccionado.
* *@IdCliente*:	Cliente que realiza la compra.
* *@IdFuncion*:	Función de cine para la cual se compran los tickets.
* *@ListaButacas*:	Lista de identificadores de butacas en formato JSON.

#### Validar el formato de la lista de butacas:

*IF ISJSON(@ListaButacas) <> 1
BEGIN
    RAISERROR('La lista de butacas no es valida.', 16, 1);
    RETURN;
END;*

* IF evalúa una condición.
* ISJSON() comprueba si el texto tiene una estructura JSON válida.
* RAISERROR() genera un error con un mensaje personalizado. El nivel 16 indica un error relacionado con la entrada o ejecución que puede corregirse.
* RETURN finaliza la ejecución del procedimiento en ese punto.

#### Creamos una variable para las butacas:

*DECLARE @Butacas TABLE (
    id_butaca INT NULL
);*

*INSERT INTO @Butacas (id_butaca)
SELECT TRY_CONVERT(INT, [value])
FROM OPENJSON(@ListaButacas);*

* DECLARE @Butacas TABLE crea una tabla variable temporal que existe durante la ejecución del procedimiento.
* OPENJSON() lee el contenido del JSON y devuelve sus elementos en filas. Para [N,M], devuelve dos valores.
* [value] es la columna de OPENJSON que contiene cada elemento.
* TRY_CONVERT(INT, [value]) intenta convertir cada valor a un entero. Si no puede, devuelve NULL.
* INSERT INTO introduce los resultados en la tabla variable.

*Utilizamos INT NULL porque inicialmente la tabla permite almacenar NULL para poder detectar después los valores inválidos.*

#### Comprobamos que se hayan indicado las butacas:
   *IF NOT EXISTS (SELECT 1 FROM @Butacas)
   BEGIN
       RAISERROR('Debe indicar al menos una butaca.', 16, 1);
       RETURN;
   END;*

*EXISTS y NOT EXISTS permiten comprobar si una consulta devuelve alguna fila, para este caso en particular NOT EXISTS verifica que la tabla variable no esté vacía. Si no se recibió ninguna butaca, el procedimiento informa el error y termina. SELECT 1 se utiliza porque solo interesa comprobar la existencia de filas, no recuperar sus datos.*

#### Rechazar identificadores invalidos/incorrectos

*IF EXISTS (
    SELECT 1
    FROM @Butacas
    WHERE id_butaca IS NULL OR id_butaca <= 0
)*
*BEGIN
    RAISERROR('La lista contiene una butaca invalida.', 16, 1);
    RETURN;
END;*

Este bloque busca identificadores que no sean válidos:
* id_butaca IS NULL: no se pudo obtener un identificador numérico.
* id_butaca <= 0: el identificador es cero o negativo.
*En caso de que encuentre al menos uno rechaza la operacion*

#### Evitar que se repita una butaca en la misma solicitud

IF (
    SELECT COUNT(*) FROM @Butacas
) <> (
    SELECT COUNT(DISTINCT id_butaca) FROM @Butacas
)
BEGIN
    RAISERROR('No puede repetir una butaca.', 16, 1);
    RETURN;
END;

En este bloque comparamos 2 cantidades:
* COUNT(*): cuenta todas las filas.
* COUNT(DISTINCT id_butaca): cuenta los identificadores diferentes, sin duplicados.

*Si ambas cantidades no coinciden, hay butacas repetidas.*

