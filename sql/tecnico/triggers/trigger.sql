-- 1 TABLAS AUXILIARES DE AUDITORIA
IF OBJECT_ID('Aud_Cliente', 'U') IS NULL
CREATE TABLE Aud_Cliente(
    id_auditoria    int IDENTITY(1,1) NOT NULL,
    operacion       varchar(6)  NOT NULL,
    fecha_operacion date        NOT NULL,
    hora_operacion  time(0)     NOT NULL,
    usuario         sysname     NOT NULL,
    --- Valores anteriores del cliente 
    id_cliente int,
    dni        int,
    nombre     varchar(60),
    apellido   varchar(60),
    email      varchar(100),
    telefono   varchar(20),
    CONSTRAINT pk_aud_cliente PRIMARY KEY (id_auditoria)
);
 
IF OBJECT_ID('Aud_Funcion', 'U') IS NULL
CREATE TABLE Aud_Funcion(
    id_auditoria    int IDENTITY(1,1) NOT NULL,
    operacion       varchar(6)  NOT NULL,
    fecha_operacion date        NOT NULL,
    hora_operacion  time(0)     NOT NULL,
    usuario         sysname     NOT NULL,
    --- Valores anteriores de la funcion 
    id_funcion       int,
    fecha            date,
    hora             time,
    precio_actual    decimal(10,2),
    stock_disponible int,
    id_pelicula      int,
    id_sala          int,
    CONSTRAINT pk_aud_funcion PRIMARY KEY (id_auditoria)
);
 
IF OBJECT_ID('Aud_Compra', 'U') IS NULL
CREATE TABLE Aud_Compra(
    id_auditoria    int IDENTITY(1,1) NOT NULL,
    operacion       varchar(6)  NOT NULL,
    fecha_operacion date        NOT NULL,
    hora_operacion  time(0)     NOT NULL,
    usuario         sysname     NOT NULL,
    --- Valores anteriores de la compra -
    id_compra    int,
    fecha_compra date,
    hora_compra  time,
    total_compra decimal(10,2),
    id_pago      int,
    id_cliente   int,
    CONSTRAINT pk_aud_compra PRIMARY KEY (id_auditoria)
);
GO
 
-- 2 TRIGGERS DE AUDITORIA

CREATE OR ALTER TRIGGER trg_aud_cliente
ON Cliente
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
 
    INSERT INTO Aud_Cliente (operacion, fecha_operacion, hora_operacion, usuario,
                             id_cliente, dni, nombre, apellido, email, telefono)
    SELECT CASE WHEN EXISTS (SELECT 1 FROM inserted) THEN 'UPDATE' ELSE 'DELETE' END,
           CAST(GETDATE() AS date),
           CAST(GETDATE() AS time(0)),
           USER_NAME(),
           d.id_cliente, d.dni, d.nombre, d.apellido, d.email, d.telefono
    FROM deleted d;
END;
GO
 
CREATE OR ALTER TRIGGER trg_aud_funcion
ON Funcion
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
 
    INSERT INTO Aud_Funcion (operacion, fecha_operacion, hora_operacion, usuario,
                             id_funcion, fecha, hora, precio_actual, stock_disponible,
                             id_pelicula, id_sala)
    SELECT CASE WHEN EXISTS (SELECT 1 FROM inserted) THEN 'UPDATE' ELSE 'DELETE' END,
           CAST(GETDATE() AS date),
           CAST(GETDATE() AS time(0)),
           USER_NAME(),
           d.id_funcion, d.fecha, d.hora, d.precio_actual, d.stock_disponible,
           d.id_pelicula, d.id_sala
    FROM deleted d;
END;
GO
 
CREATE OR ALTER TRIGGER trg_aud_compra
ON Compra
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
 
    INSERT INTO Aud_Compra (operacion, fecha_operacion, hora_operacion, usuario,
                            id_compra, fecha_compra, hora_compra, total_compra,
                            id_pago, id_cliente)
    SELECT CASE WHEN EXISTS (SELECT 1 FROM inserted) THEN 'UPDATE' ELSE 'DELETE' END,
           CAST(GETDATE() AS date),
           CAST(GETDATE() AS time(0)),
           USER_NAME(),
           d.id_compra, d.fecha_compra, d.hora_compra, d.total_compra,
           d.id_pago, d.id_cliente
    FROM deleted d;
END;
GO
 
 
-- 1 TRIGGER QUE NO PERMITE BORRAR

CREATE OR ALTER TRIGGER trg_pelicula_no_delete
ON Pelicula
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
 
    THROW 50040, 'No se permite eliminar peliculas: se conserva el historial de funciones.', 1;
END;
GO


 
