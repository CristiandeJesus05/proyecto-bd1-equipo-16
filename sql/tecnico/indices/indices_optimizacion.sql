-- Consultar los índices existentes en las tablas del cine.
-- Permite identificar claves primarias, restricciones UNIQUE
-- e índices creados manualmente.

SELECT
    t.name AS nombre_tabla,
    i.name AS nombre_indice,
    i.type_desc AS tipo_indice,
    i.is_unique AS es_unico
FROM sys.indexes AS i
INNER JOIN sys.tables AS t
    ON i.object_id = t.object_id
WHERE t.name IN (
    'Cliente',
    'Compra',
    'Metodo_Pago',
    'Butaca',
    'Funcion',
    'Ticket'
)
AND i.name IS NOT NULL
ORDER BY
    t.name,
    i.name;


-- Consultar los triggers asociados a las tablas Compra,
-- Funcion y Ticket.

SELECT
    OBJECT_NAME(parent_id) AS tabla,
    name AS nombre_trigger,
    is_disabled AS esta_deshabilitado
FROM sys.triggers
WHERE parent_id IN (
    OBJECT_ID('dbo.Compra'),
    OBJECT_ID('dbo.Funcion'),
    OBJECT_ID('dbo.Ticket')
);



/* =====================================================
   INDICES PARA OPTIMIZAR LA BASE DE DATOS
   PROYECTO: CINE DEL PARANA
   MOTOR: SQL SERVER
   ===================================================== */


-- -----------------------------------------------------
-- TABLA COMPRA
-- -----------------------------------------------------

-- Facilita las búsquedas y relaciones entre clientes
-- y las compras que realizaron.

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'idx_compra_cliente'
      AND object_id = OBJECT_ID('dbo.Compra')
)
BEGIN
    CREATE INDEX idx_compra_cliente
    ON dbo.Compra(id_cliente);
END;


-- Facilita las consultas de compras según
-- el método de pago utilizado.

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'idx_compra_pago'
      AND object_id = OBJECT_ID('dbo.Compra')
)
BEGIN
    CREATE INDEX idx_compra_pago
    ON dbo.Compra(id_pago);
END;


-- -----------------------------------------------------
-- TABLA FUNCION
-- -----------------------------------------------------

-- Optimiza la búsqueda de funciones correspondientes
-- a una película determinada.
-- Es útil para los informes de ventas por película.

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'idx_funcion_pelicula'
      AND object_id = OBJECT_ID('dbo.Funcion')
)
BEGIN
    CREATE INDEX idx_funcion_pelicula
    ON dbo.Funcion(id_pelicula);
END;


-- Facilita la búsqueda de funciones por sala y fecha.
-- Es útil para consultar la programación del cine.

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'idx_funcion_sala_fecha'
      AND object_id = OBJECT_ID('dbo.Funcion')
)
BEGIN
    CREATE INDEX idx_funcion_sala_fecha
    ON dbo.Funcion(id_sala, fecha);
END;


-- -----------------------------------------------------
-- TABLA TICKET
-- -----------------------------------------------------

-- Facilita la búsqueda de los tickets asociados
-- a una compra determinada.

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'idx_ticket_compra'
      AND object_id = OBJECT_ID('dbo.Ticket')
)
BEGIN
    CREATE INDEX idx_ticket_compra
    ON dbo.Ticket(id_compra);
END;


