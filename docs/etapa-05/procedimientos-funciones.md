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

### Validar el formato de la lista de butacas

*IF ISJSON(@ListaButacas) <> 1
BEGIN
    RAISERROR('La lista de butacas no es valida.', 16, 1);
    RETURN;
END;*

* IF evalúa una condición.
* ISJSON() comprueba si el texto tiene una estructura JSON válida.
* RAISERROR() genera un error con un mensaje personalizado. El nivel 16 indica un error relacionado con la entrada o ejecución que puede corregirse.
* RETURN finaliza la ejecución del procedimiento en ese punto.

### Creamos una variable para las butacas

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

### Rechazar identificadores invalidos/incorrectos

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

### Evitar que se repita una butaca en la misma solicitud

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

### Validar el identificador de compra

IF EXISTS (
    SELECT 1
    FROM Compra
    WHERE id_compra = @IdCompra
)
BEGIN
    RAISERROR('El identificador de compra ya existe.', 16, 1);
    RETURN;
END;

*Consultamos a la tabla "Compra" si el identificador ya esta utilizado.*

### Validar la existencia del Cliente
IF NOT EXISTS (
    SELECT 1 FROM Cliente
    WHERE id_cliente = @IdCliente
)
BEGIN
    RAISERROR('El cliente indicado no existe.', 16, 1);
    RETURN;
END;

*Verificamos la existencia del Cliente*

### Validar la existencia del "Metodo de pago"

IF NOT EXISTS (
    SELECT 1 FROM Metodo_Pago
    WHERE id_pago = @IdPago
)
BEGIN
    RAISERROR('El metodo de pago no existe.', 16, 1);
    RETURN;
END;

*Verificamos la existencia del metodo de pago seleccionado*

### Obtener el precio, stock y la sala de la funcion

DECLARE @Precio DECIMAL(10,2);
DECLARE @Stock INT;
DECLARE @IdSala INT;
DECLARE @Cantidad INT;

SELECT
    @Precio = precio_actual,
    @Stock = stock_disponible,
    @IdSala = id_sala
FROM Funcion
WHERE id_funcion = @IdFuncion;

* @Precio: Precio actual de la función.
* @Stock: Stock disponible.
* @IdSala: Sala donde se proyecta la película.
* @Cantidad: Número de butacas solicitadas.

En el SELECT asignamos a las variables los datos de la funcion cuyo identificador coincide con el "@IdFuncion"

Comprobamos que la funcion exista:
IF @IdSala IS NULL
BEGIN
    RAISERROR('La funcion indicada no existe.', 16, 1);
    RETURN;
END;

Si no encontramos la funcion, las variables no recibiran valor de una fila y a su vez el @IdSala quedara en NULL.
Este procedimiento utiliza esta condicion mencionada para rechazar una "funcion inexistente"

### Calcular la cantidad de tickets y comprobar el stock.

SELECT @Cantidad = COUNT(*)
FROM @Butacas;

Cuenta la cantidad de butacas y guardamos el resultado en @Cantidad.
Luego:

IF @Stock < @Cantidad
BEGIN
    RAISERROR('No hay stock suficiente.', 16, 1);
    RETURN;
END;

Comparamos el @Stock  disponible con la "@Cantidad" solicitada. En caso que el @Stock sea menor la compra sera rechazada.

### Varificamos si las butacas son parte de la sala

IF EXISTS (
    SELECT 1
    FROM @Butacas x
    LEFT JOIN Butaca b
        ON b.id_butaca = x.id_butaca
    WHERE b.id_butaca IS NULL
       OR b.id_sala <> @IdSala
)
BEGIN
    RAISERROR('Hay butacas que no pertenecen a la sala.', 16, 1);
    RETURN;
END;

* El "LEFT JOIN" lo utilizamos para comparar las butacas solicitadas con los registros de la tabla de "Butaca".
* Usamos "x" como alias de la tabla @Butacas
* Usamos "b" como alias de la tabla Butaca
* "ON b.id_butaca = x.id_butaca": Relacionamos ambas tablas por el identificador "id_butaca"
* WHERE b.id_butaca IS NULL: Detectamos las butacas que no existen en la tabla "Butaca"
* OR b.id_sala <> @IdSala: Detectamos las butacas que son pertenecientes a otra sala.

*Si se encuentra alguna la operacion sera rechazada y emitira la leyenda 'Hay butacas que no pertenecen a la sala.'*

### Comprobamos que las butacas no hayan sido vendidas para esa funcion

IF EXISTS (
    SELECT 1
    FROM @Butacas x
    INNER JOIN Ticket t
        ON t.id_butaca = x.id_butaca
       AND t.id_funcion = @IdFuncion
)
BEGIN
    RAISERROR('Una butaca ya fue vendida para esa funcion.', 16, 1);
    RETURN;
END;

* En este apartado del script buscamos las coincidencias entre las Butacas que han sido seleccionadas y los tickets registrados.
Nuestro "INNER JOIN" en este caso lo utilziamos para relacionar las tablas cuando coinciden el identificador de las butacas ("t.id_butaca = x.id_butaca") como el de la funcion ("t.id_funcion = @IdFuncion"). De esta manera aseguramos que una butaca este disponible y pueda usarse en otra funcion pero a su vez tambien que no pueda venderse 2 veces en una misma funcion.

* *Si nuestra funcion encuentra una coincidencia, generara un error y emitira la leyenda: 'Una butaca ya fue vendida para esa funcion.'*

### Registrar una Compra
INSERT INTO Compra (
    id_compra,
    fecha_compra,
    hora_compra,
    total_compra,
    id_pago,
    id_cliente
)
VALUES (
    @IdCompra,
    @FechaCompra,
    @HoraCompra,
    @Precio * @Cantidad,
    @IdPago,
    @IdCliente
);

* El total_compra es calculado mediante una multiplicacion entre el precio y la cantidad elegida de tickets.
* Ejemplo total_compra = $15.000 (precio ticket) x 2 (Cantidad de tickets) = $30.000.

### Numeracion e insercion de los tickets
;WITH ButacasNumeradas AS (
    SELECT
        id_butaca,
        ROW_NUMBER() OVER (
            ORDER BY id_butaca
        ) AS nro_item
    FROM @Butacas
)
INSERT INTO Ticket (
    nro_item,
    id_compra,
    precio_unitario,
    id_butaca,
    id_funcion
)
SELECT
    CONVERT(INT, nro_item),
    @IdCompra,
    @Precio,
    id_butaca,
    @IdFuncion
FROM ButacasNumeradas;

* *En este apartado del script generamos un ticket por cada butaca que haya sido seleccionada*

* "With ButacasNumeradas AS (...)": Define una expresion de tabla, que nos permitira organizar una consulta axuliar.
* ROW_NUMBER(): Asigna de manera de numeros consecutivos a las butacas ordenadas por su identificador.
* ORDER BY id_butaca: Determinara el orden en el que seran numeradas.
* INSERT INTO Ticket: Guarda los tickets en su tabla correspondiente.
* El precio se copia a precio_unitario para conservar el precio historico de cada ticket. De esta manera si cambia el precio actual de una funcion, los registros de compras anteriores mantienen el importe con el que fueron vendidos.     

### Actualizar el stock de la funcion

UPDATE Funcion
SET stock_disponible = stock_disponible - @Cantidad
WHERE id_funcion = @IdFuncion;

* Este apartado descuenta los tickets disponibles mediante la diferencia "stock_disponible - @Cantidad" y posteriormente es guardado y actualizado en "stock_disponible".

### Informe final de resultado de la operacion

SELECT
    @IdCompra AS id_compra,
    @Cantidad AS tickets_registrados,
    @Precio * @Cantidad AS total_compra,
    'Compra registrada correctamente' AS resultado;

* Al final el procedimiento nos devuelve un resumen en una fila con la operacion realizada:
* Identificador de compra.
* La Cantidad de tickets registrados.
* El total calculado.
* Mensaje de confirmacion con la leyenda "Compra registrada correctamente"

*Todo en una columna que la llamamos "resultado"*.
