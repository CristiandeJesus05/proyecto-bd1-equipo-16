/* =====================================================
   PROCEDIMIENTO ALMACENADO: sp_RegistrarCompra
   PROYECTO: CINE DEL PARANA
   MOTOR: SQL SERVER

   OBJETIVO:
   Registrar una compra, generar sus tickets y actualizar
   el stock disponible de la funcion seleccionada.

   IMPORTANTE:
   El procedimiento administra el descuento del stock.
   No debe existir otro trigger que realice el mismo
   descuento al insertar tickets.
   ===================================================== */

CREATE OR ALTER PROCEDURE dbo.sp_RegistrarCompra

    @IdCompra INT,
    @FechaCompra DATE,
    @HoraCompra TIME,
    @IdPago INT,
    @IdCliente INT,
    @IdFuncion INT,
    @ListaButacas NVARCHAR(MAX)

AS
BEGIN

    -- Evita mensajes adicionales de filas afectadas.
    SET NOCOUNT ON;

    -- Permite revertir la transaccion ante errores.
    SET XACT_ABORT ON;


    /* =================================================
       1. VALIDAR LA LISTA DE BUTACAS
       ================================================= */

    -- Comprobar que se haya recibido un JSON valido.
    IF @ListaButacas IS NULL
       OR ISJSON(@ListaButacas) <> 1
    BEGIN
        THROW 50001, 'La lista de butacas no es valida.', 1;
    END;


    -- Crear una tabla temporal en memoria para guardar
    -- los identificadores de las butacas solicitadas.

    DECLARE @Butacas TABLE (
        id_butaca INT NULL
    );


    -- Obtener los identificadores desde el JSON.
    -- Se espera un formato como: [100,101,102]

    INSERT INTO @Butacas (id_butaca)
    SELECT TRY_CONVERT(INT, [value])
    FROM OPENJSON(@ListaButacas);


    -- Comprobar que se haya indicado al menos una butaca.
    IF NOT EXISTS (
        SELECT 1
        FROM @Butacas
    )
    BEGIN
        THROW 50002, 'Debe indicar al menos una butaca.', 1;
    END;


    -- Rechazar identificadores nulos o negativos.
    IF EXISTS (
        SELECT 1
        FROM @Butacas
        WHERE id_butaca IS NULL
           OR id_butaca <= 0
    )
    BEGIN
        THROW 50003, 'La lista contiene una butaca invalida.', 1;
    END;


    -- Evitar que una misma butaca aparezca repetida
    -- dentro de la solicitud de compra.

    IF (
        SELECT COUNT(*)
        FROM @Butacas
    ) <> (
        SELECT COUNT(DISTINCT id_butaca)
        FROM @Butacas
    )
    BEGIN
        THROW 50004, 'No puede repetir una butaca.', 1;
    END;


    /* =================================================
       2. DECLARAR VARIABLES
       ================================================= */

    DECLARE @Precio DECIMAL(10,2);
    DECLARE @Stock INT;
    DECLARE @IdSala INT;
    DECLARE @Cantidad INT;


    -- Contar la cantidad de butacas solicitadas.
    SELECT @Cantidad = COUNT(*)
    FROM @Butacas;


    /* =================================================
       3. INICIAR LA TRANSACCION
       ================================================= */

    BEGIN TRY

        BEGIN TRANSACTION;


        /* =============================================
           4. VALIDAR EL IDENTIFICADOR DE COMPRA
           ============================================= */

        -- Comprobar que el identificador no se encuentre
        -- registrado previamente.

        IF EXISTS (
            SELECT 1
            FROM Compra WITH (UPDLOCK, HOLDLOCK)
            WHERE id_compra = @IdCompra
        )
        BEGIN
            THROW 50005, 'El identificador de compra ya existe.', 1;
        END;


        /* =============================================
           5. VALIDAR CLIENTE Y METODO DE PAGO
           ============================================= */

        -- Comprobar que exista el cliente indicado.

        IF NOT EXISTS (
            SELECT 1
            FROM Cliente
            WHERE id_cliente = @IdCliente
        )
        BEGIN
            THROW 50006, 'El cliente indicado no existe.', 1;
        END;


        -- Comprobar que exista el metodo de pago.

        IF NOT EXISTS (
            SELECT 1
            FROM Metodo_Pago
            WHERE id_pago = @IdPago
        )
        BEGIN
            THROW 50007, 'El metodo de pago indicado no existe.', 1;
        END;


        /* =============================================
           6. OBTENER LOS DATOS DE LA FUNCION
           ============================================= */

        -- UPDLOCK y HOLDLOCK mantienen bloqueada la fila
        -- de la funcion durante la transaccion.
        -- Esto ayuda a controlar compras simultaneas.

        SELECT
            @Precio = precio_actual,
            @Stock = stock_disponible,
            @IdSala = id_sala
        FROM Funcion WITH (UPDLOCK, HOLDLOCK)
        WHERE id_funcion = @IdFuncion;


        -- Comprobar que la funcion exista.
        IF @IdSala IS NULL
        BEGIN
            THROW 50008, 'La funcion indicada no existe.', 1;
        END;


        -- Comprobar que el precio y el stock sean validos.
        IF @Precio IS NULL OR @Stock IS NULL
        BEGIN
            THROW 50009, 'La funcion tiene datos incompletos.', 1;
        END;


        /* =============================================
           7. COMPROBAR EL STOCK DISPONIBLE
           ============================================= */

        -- Verificar que haya suficientes entradas
        -- para cubrir la cantidad solicitada.

        IF @Stock < @Cantidad
        BEGIN
            THROW 50010, 'No hay stock suficiente.', 1;
        END;


        /* =============================================
           8. VALIDAR LA PERTENENCIA DE LAS BUTACAS
           ============================================= */

        -- Comprobar que todas las butacas existan
        -- y correspondan a la sala de la funcion.

        IF EXISTS (
            SELECT 1
            FROM @Butacas AS x
            LEFT JOIN Butaca AS b
                ON b.id_butaca = x.id_butaca
            WHERE b.id_butaca IS NULL
               OR b.id_sala <> @IdSala
        )
        BEGIN
            THROW 50011, 'Hay butacas que no pertenecen a la sala.', 1;
        END;


        /* =============================================
           9. VERIFICAR QUE LAS BUTACAS NO ESTEN VENDIDAS
           ============================================= */

        -- Comprobar que ninguna de las butacas solicitadas
        -- tenga un ticket registrado para esa funcion.

        IF EXISTS (
            SELECT 1
            FROM @Butacas AS x
            INNER JOIN Ticket AS t
                ON t.id_butaca = x.id_butaca
               AND t.id_funcion = @IdFuncion
        )
        BEGIN
            THROW 50012, 'Una butaca ya fue vendida para esa funcion.', 1;
        END;


        /* =============================================
           10. REGISTRAR LA COMPRA
           ============================================= */

        -- Calcular el total multiplicando el precio
        -- vigente por la cantidad de butacas.

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


        /* =============================================
           11. REGISTRAR LOS TICKETS
           ============================================= */

        -- Generar un numero de item para cada ticket.
        -- El precio se guarda como valor historico,
        -- aunque posteriormente cambie el precio
        -- de la funcion.

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


        /* =============================================
           12. ACTUALIZAR EL STOCK
           ============================================= */

        -- Descontar del stock la cantidad de entradas
        -- que se acaban de registrar.

        UPDATE Funcion

        SET stock_disponible = stock_disponible - @Cantidad

        WHERE id_funcion = @IdFuncion
          AND stock_disponible >= @Cantidad;


        -- Comprobar que la actualizacion se haya realizado.
        IF @@ROWCOUNT = 0
        BEGIN
            THROW 50013, 'No se pudo actualizar el stock.', 1;
        END;


        /* =============================================
           13. CONFIRMAR LA TRANSACCION
           ============================================= */

        -- Si todas las operaciones fueron correctas,
        -- confirmar definitivamente la compra.

        COMMIT TRANSACTION;


        /* =============================================
           14. INFORMAR EL RESULTADO
           ============================================= */

        SELECT
            @IdCompra AS id_compra,
            @Cantidad AS tickets_registrados,
            @Precio * @Cantidad AS total_compra,
            'Compra registrada correctamente' AS resultado;


    END TRY


    /* =================================================
       15. CONTROLAR ERRORES
       ================================================= */

    BEGIN CATCH

        -- Si ocurre un error, deshacer las operaciones
        -- realizadas durante la transaccion.

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;


        -- Devolver el error para informar qué ocurrió.
        THROW;

    END CATCH;

END;