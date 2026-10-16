# Reporte Agregado:
### - Total de ventas realizadas en un rango de fechas determinada.
Esta consulta muestra los tickets vendidos, la cantidad de compras realizadas y la recaudacion por cada pelicula.

<img width="488" height="106" alt="Captura de pantalla 2026-10-16 152610" src="https://github.com/user-attachments/assets/f89167ca-e35a-46a3-b524-870af692c80d" />

Utilizamos la tabla de "Pelicula" como nuestro criterio de agrupacion para desarrollar la consulta.

### - Descripcion de variables y codigo SQL utlizado:
Declaramos dos variables tanto de "Inicio" como de "Fin" para determinar el intervalo de fechas que deseamos consultar.
* DECLARE @Fecha_Inicio: Fecha de inicio del informe realizado.
* DECLARE @Fecha_Fin: Fecha de fin del informe realizado.

#### Seleccion de los datos utlizados:
* p.id_pelicula: Identifica a la pelicula.
* COUNT(*) AS tickets_vendidos: Cuenta los tickets registrados en cada uno de los grupos y los muestra con el titulo "tickets_vendidos".
* COUNT(DISTINCT c.id_compra) AS cantidad_compras: Cuenta las diferentes compras asociadas a cada una de las peliculas y las muestra con el titulo "cantidad_compras".
* SUM(t.precio_unitario) AS total_recaudado: Suma el "precio unitario" de cada uno de los tickets y posteriormente muestra le "total_recaudado".

#### Union de las tablas ("INNER JOIN"):
* INNER JOIN Funcion f ON p.id_pelicula = f.id_pelicula: Identifica que pelicula es proyectada en una determinada funcion
* INNER JOIN Ticket t ON f.id_funcion = t.id_funcion: Identifica que ticket corresponde a cada funcion.
* INNER JOIN Compra c ON t.id_compra = c.id_compra: Identifica que ticket corresponde a cada compra.

#### Filtros de fechas con clausura ("WHERE"):
##### "WHERE c.fecha_compra >= @Fecha_Inicio AND c.fecha_compra < DATEADD(DAY, 1, @Fecha_Fin)":
* ">= @Fecha_Inicio": Incluimos las compras desde la fecha inicial determinda.
* "< DATEADD(DAY, 1, @Fecha_Fin)": Excluimos la compras realizadas desde el dia despues de la fecha final determinada.

#### Agrupacion de los resultados ("GROUP BY") Y Ordenar los resultados ("ORDEN BY"):
* GROUP BY p.id_pelicula, p.titulo: Agrupamos los registros que corresponden a una misma pelicula para obtener en una fila los datos de pelicula con su cantiadad de tickets, compras realizadas y total de la recaudacion.
* ORDER BY total_recaudado DESC: Ordenamos las peliculas que tuvieron mayor recaudacion a las que tuvieron menor recaudacion.
