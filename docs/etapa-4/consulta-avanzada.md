# Géneros Populares (Más de 5 Entradas Vendidas)

* **Objetivo del reporte:** Identificar y analizar los géneros cinematográficos de mayor éxito comercial que hayan alcanzado o superado el umbral de 5 entradas vendidas en el cine, evaluando su volumen de boletos e ingresos generados.
* **Criterio de agrupación:** Se utiliza la columna p.genero  de la tabla Pelicula para consolidar las ventas de todas las películas pertenecientes a una misma categoría.


---

**Explicación Detallada de los Componentes:**

1. **Selección de datos y métricas agregadas ( SELECT ):**
   * p.genero: Identifica la categoría o género cinematográfico.
   * COUNT(t.nro_item) AS total_entradas_vendidas: Cuenta el total de tickets vendidos para todas las funciones del género.
   * SUM(t.precio_unitario) AS total_recaudado: Suma el valor monetario de cada ticket para calcular el dinero total reunido por el género.
2. **Unión de tablas ( INNER JOIN):**
   * INNER JOIN Funcion f ON p-id_pelicula = f.id_pelicula: Relaciona cada película con sus funciones programadas.
   * INNER JOIN Ticket t ON f.id_funcion = t.id_funcion: Relaciona cada función con los tickets vendidos.
3. **Agrupación y Filtro de Popularidad (GROUP BY + HAVIN):**
   * GROUP BY p.genero: Agrupa los registros para procesar los datos de forma consolidada por género.
   * HAVING COUNT(t.nro_item) >= 5: Condición clave que filtra los grupos resultantes y muestra **únicamente** los géneros que alcanzaron o superaron las 5 entradas vendidas.
4. **Ordenamiento de resultados ( ORDER BY):**
   * ORDER BY total_entradas_vendidas DESC: Ordena la tabla resultante de mayor a menor según la cantidad total de boletos emitidos.

# Películas Menos Vendidas (Menor Cantidad de Entradas)

- Objetivo del reporte: Identificar y analizar las películas con menor éxito comercial en el cine, considerando la cantidad de entradas vendidas y los ingresos generados. Esta información permite evaluar la demanda de cada película y tomar decisiones sobre promociones, horarios y permanencia en cartelera.
- Criterio de agrupación: Se utiliza la columna p.titulo de la tabla Pelicula para consolidar las ventas correspondientes a cada película, independientemente de la cantidad de funciones programadas.

---

**Explicación detallada de los componentes:** 
1. Selección de datos y métricas agregadas (SELECT):
- p.titulo: identifica el título de la película.
- COUNT(t.nro_item) AS total_entradas_vendidas: cuenta la cantidad total de tickets vendidos para las funciones de cada película.
- SUM(t.precio_unitario) AS total_recaudado: suma el precio de los tickets para calcular los ingresos generados por cada película.
2. Unión de tablas (INNER JOIN y LEFT JOIN):
- INNER JOIN Funcion f ON p.id_pelicula = f.id_pelicula: relaciona cada película con sus funciones programadas.
- LEFT JOIN Ticket t ON f.id_funcion = t.id_funcion: relaciona las funciones con sus tickets vendidos y permite incluir películas cuyas funciones todavía no registran ventas.
3. Agrupación y filtro de ventas (GROUP BY + HAVING):
- GROUP BY p.id_pelicula, p.titulo: agrupa los resultados por película.
- HAVING COUNT(t.nro_item) <= ALL (...): compara las ventas de cada película con las cantidades vendidas por las demás y muestra aquellas que tienen la menor cantidad de entradas vendidas.
4. Ordenamiento de resultados (ORDER BY):
- ORDER BY total_entradas_vendidas ASC: ordena los resultados de menor a mayor cantidad de entradas vendidas, mostrando primero las películas con menor demanda.
