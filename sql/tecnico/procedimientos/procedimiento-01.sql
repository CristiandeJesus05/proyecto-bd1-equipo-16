
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
    SET NOCOUNT ON;

    -- Validar que la lista de butacas sea JSON valido.
    IF ISJSON(@ListaButacas) <> 1
    BEGIN
        RAISERROR('La lista de butacas no es valida.', 16, 1);
        RETURN;
    END;

    -- Cargar los identificadores de butacas recibidos.
    DECLARE @Butacas TABLE (
        id_butaca INT NULL
    );

    INSERT INTO @Butacas (id_butaca)
    SELECT TRY_CONVERT(INT, [value])
    FROM OPENJSON(@ListaButacas);

    -- Comprobar que se haya indicado al menos una butaca.
    IF NOT EXISTS (SELECT 1 FROM @Butacas)
    BEGIN
        RAISERROR('Debe indicar al menos una butaca.', 16, 1);
        RETURN;
    END;

    -- Rechazar identificadores invalidos.
    IF EXISTS (
        SELECT 1
        FROM @Butacas
        WHERE id_butaca IS NULL OR id_butaca <= 0
    )
    BEGIN
        RAISERROR('La lista contiene una butaca invalida.', 16, 1);
        RETURN;
    END;

    -- Evitar repetir una butaca en la misma solicitud.
    IF (
        SELECT COUNT(*) FROM @Butacas
    ) <> (
        SELECT COUNT(DISTINCT id_butaca) FROM @Butacas
    )
    BEGIN
        RAISERROR('No puede repetir una butaca.', 16, 1);
        RETURN;
    END;

    -- Evitar repetir el identificador de compra.
    IF EXISTS (
        SELECT 1
        FROM Compra
        WHERE id_compra = @IdCompra
    )
    BEGIN
        RAISERROR('El identificador de compra ya existe.', 16, 1);
        RETURN;
    END;

    -- Comprobar que existan el cliente y el metodo de pago.
    IF NOT EXISTS (
        SELECT 1 FROM Cliente
        WHERE id_cliente = @IdCliente
    )
    BEGIN
        RAISERROR('El cliente indicado no existe.', 16, 1);
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT 1 FROM Metodo_Pago
        WHERE id_pago = @IdPago
    )
    BEGIN
        RAISERROR('El metodo de pago indicado no existe.', 16, 1);
        RETURN;
    END;

    -- Obtener el precio, stock y sala de la funcion.
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

    IF @IdSala IS NULL
    BEGIN
        RAISERROR('La funcion indicada no existe.', 16, 1);
        RETURN;
    END;

    SELECT @Cantidad = COUNT(*)
    FROM @Butacas;

    -- Comprobar disponibilidad de stock.
    IF @Stock < @Cantidad
    BEGIN
        RAISERROR('No hay stock suficiente.', 16, 1);
        RETURN;
    END;

    -- Verificar que las butacas pertenezcan a la sala.
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

    -- Verificar que no se hayan vendido para esa funcion.
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

    -- Registrar la compra con el total calculado.
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

    -- Registrar un ticket por cada butaca.
    -- Se guarda el precio vigente como precio historico.
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

    -- Actualizar el stock de la funcion.
    UPDATE Funcion
    SET stock_disponible = stock_disponible - @Cantidad
    WHERE id_funcion = @IdFuncion;

    -- Informar el resultado de la operacion.
    SELECT
        @IdCompra AS id_compra,
        @Cantidad AS tickets_registrados,
        @Precio * @Cantidad AS total_compra,
        'Compra registrada correctamente' AS resultado;
END;


