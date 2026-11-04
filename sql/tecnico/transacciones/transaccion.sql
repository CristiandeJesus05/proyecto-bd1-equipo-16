-- Procedimiento con transaccion
CREATE OR ALTER PROCEDURE dbo.sp_RegistrarCompra
    @IdCompra INT,
    @FechaCompra DATE,
    @HoraCompra TIME,
    @IdPago INT,
    @IdCliente INT,
    @IdFuncion INT,
    @ListaButacas NVARCHAR(MAX),
    @ProvocarError BIT = 0
AS
BEGIN
    -- Evita mensajes adicionales de filas afectadas.
    SET NOCOUNT ON;

    -- Ayuda a que ciertos errores cancelen la transacción.
    SET XACT_ABORT ON;

    BEGIN TRY

        --------------------------------------------------
        -- 1. VALIDACIONES PREVIAS
        --------------------------------------------------

        -- Verificar que la lista de butacas sea JSON válido.
        IF ISJSON(@ListaButacas) <> 1
            THROW 50001, 'La lista de butacas no es valida.', 1;

        -- Tabla temporal en memoria para las butacas recibidas.
        DECLARE @Butacas TABLE (
            id_butaca INT NOT NULL PRIMARY KEY
        );

        -- Validar que los valores puedan convertirse a enteros
        -- positivos antes de insertarlos en la tabla variable.
        IF EXISTS (
            SELECT 1
            FROM OPENJSON(@ListaButacas)
            WHERE TRY_CONVERT(INT, [value]) IS NULL
               OR TRY_CONVERT(INT, [value]) <= 0
        )
            THROW 50002, 'La lista contiene una butaca invalida.', 1;

        -- Cargar los identificadores de butacas.
        -- La clave primaria también impide identificadores repetidos.
        INSERT INTO @Butacas (id_butaca)
        SELECT TRY_CONVERT(INT, [value])
        FROM OPENJSON(@ListaButacas);

        -- Debe seleccionarse al menos una butaca.
        IF NOT EXISTS (SELECT 1 FROM @Butacas)
            THROW 50003, 'Debe indicar al menos una butaca.', 1;

        -- Verificar que el identificador de compra no esté usado.
        IF EXISTS (
            SELECT 1
            FROM Compra
            WHERE id_compra = @IdCompra
        )
            THROW 50004, 'El identificador de compra ya existe.', 1;

        -- Verificar que exista el cliente.
        IF NOT EXISTS (
            SELECT 1
            FROM Cliente
            WHERE id_cliente = @IdCliente
        )
            THROW 50005, 'El cliente indicado no existe.', 1;

        -- Verificar que exista el método de pago.
        IF NOT EXISTS (
            SELECT 1
            FROM Metodo_Pago
            WHERE id_pago = @IdPago
        )
            THROW 50006, 'El metodo de pago no existe.', 1;

        --------------------------------------------------
        -- 2. INICIO DE LA TRANSACCION
        --------------------------------------------------

        BEGIN TRANSACTION;

        --------------------------------------------------
        -- 3. OBTENER Y BLOQUEAR LA FUNCION
        --------------------------------------------------

        DECLARE @Precio DECIMAL(10,2);
        DECLARE @Stock INT;
        DECLARE @IdSala INT;
        DECLARE @Cantidad INT;

        -- Los bloqueos ayudan a evitar que otra transacción
        -- modifique esta función mientras se procesa la venta.
        SELECT
            @Precio = precio_actual,
            @Stock = stock_disponible,
            @IdSala = id_sala
        FROM Funcion WITH (UPDLOCK, HOLDLOCK)
        WHERE id_funcion = @IdFuncion;

        IF @IdSala IS NULL
            THROW 50007, 'La funcion indicada no existe.', 1;

        -- Calcular cuántas butacas se quieren comprar.
        SELECT @Cantidad = COUNT(*)
        FROM @Butacas;

        -- Comprobar que haya stock suficiente.
        IF @Stock IS NULL OR @Stock < @Cantidad
            THROW 50008, 'No hay stock suficiente.', 1;

        --------------------------------------------------
        -- 4. VALIDAR LAS BUTACAS
        --------------------------------------------------

        -- Todas las butacas deben existir y pertenecer
        -- a la sala donde se realiza la función.
        IF EXISTS (
            SELECT 1
            FROM @Butacas AS x
            LEFT JOIN Butaca AS b
                ON b.id_butaca = x.id_butaca
            WHERE b.id_butaca IS NULL
               OR b.id_sala <> @IdSala
        )
            THROW 50009, 'Hay butacas que no pertenecen a la sala.', 1;

        -- Comprobar que las butacas no se hayan vendido
        -- previamente para esta misma función.
        IF EXISTS (
            SELECT 1
            FROM @Butacas AS x
            INNER JOIN Ticket AS t WITH (UPDLOCK, HOLDLOCK)
                ON t.id_butaca = x.id_butaca
               AND t.id_funcion = @IdFuncion
        )
            THROW 50010, 'Una butaca ya fue vendida para esta funcion.', 1;

        --------------------------------------------------
        -- 5. REGISTRAR LA COMPRA
        --------------------------------------------------

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

        --------------------------------------------------
        -- 6. REGISTRAR LOS TICKETS
        --------------------------------------------------

        -- Asignar un número de ítem a cada ticket
        -- dentro de la compra.
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
        
        -- PRUEBA: error provocado después de los INSERT y antes del UPDATE
        IF @ProvocarError = 1
        THROW 50099, 'Error provocado intencionalmente para probar el rollback.', 1;
        --------------------------------------------------
        -- 7. ACTUALIZAR EL STOCK
        --------------------------------------------------

        UPDATE Funcion
        SET stock_disponible = stock_disponible - @Cantidad
        WHERE id_funcion = @IdFuncion
          AND stock_disponible >= @Cantidad;

        -- Si no se actualizó una fila, generar un error.
        IF @@ROWCOUNT = 0
            THROW 50011, 'No se pudo actualizar el stock.', 1;

        --------------------------------------------------
        -- 8. CONFIRMAR LA TRANSACCION
        --------------------------------------------------

        COMMIT TRANSACTION;

        -- Devolver un resumen de la compra registrada.
        SELECT
            @IdCompra AS id_compra,
            @Cantidad AS tickets_registrados,
            @Precio * @Cantidad AS total_compra,
            'Compra registrada correctamente' AS resultado;

    END TRY

    BEGIN CATCH

        --------------------------------------------------
        -- 9. REVERTIR SI OCURRE UN ERROR
        --------------------------------------------------

        -- Si existe una transacción activa o pendiente
        -- de confirmación, revertir sus modificaciones.
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        -- Volver a informar el error original.
        THROW;

    END CATCH;
END;

