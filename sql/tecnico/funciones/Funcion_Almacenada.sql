
CREATE OR ALTER FUNCTION dbo.fn_RecaudacionPelicula
(
    @IdPelicula INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN

    --- Declaramos  una variable para almacenar la recaudacion ---
    DECLARE @TotalRecaudado DECIMAL(10,2);

    -- Calculamos la recaudacion de la pelicula ---
    SELECT
        @TotalRecaudado = COALESCE(SUM(t.precio_unitario), 0)
    FROM Ticket t
    INNER JOIN Funcion f
        ON t.id_funcion = f.id_funcion
    WHERE f.id_pelicula = @IdPelicula;

    -- Devuelve el importe calculado ---
    RETURN @TotalRecaudado;

END;
