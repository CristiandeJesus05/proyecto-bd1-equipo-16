
**Métricas Sin Índice:**
Tiempo de CPU = 250ms
Tiempo total de ejecución = 2851 ms
Cantidad de lecturas lógicas = 4714
Operación Principal = Clustered Index Scan

![[sin_indice.png]]
 
**Métricas Con Índice sobre la fecha:**
Tiempo de CPU = 1406 ms
Tiempo total de ejecución = 5402 ms
Cantidad de lecturas lógicas = 613.928
Operación Principal = Index Seek + Key Lookup

![[conIndiceSobreFecha.png]]


**Métricas Con Índice Con Cobertura :**
Tiempo de CPU = 187ms
Tiempo total de ejecución = 3960 ms
Cantidad de lecturas lógicas = 550
Operación Principal = Index Seek
![[conIndice.png]]


**Conclusión del Rendimiento de la tabla Compra con su diferentes índices:**
La comparación del rendimiento en la tabla **Compra** permite analizar claramente el impacto de la indexación según los resultados obtenidos:

En primer lugar, la consulta sin índices obliga a SQL Server a realizar un escaneo completo de la tabla (**Clustered Index Scan**), procesando 4.714 páginas de memoria para leer el millón de registros generados y aplicar el filtro de fecha.

En segundo lugar, al utilizar un índice simple sobre la fecha, la búsqueda inicial es más eficiente, pero la consulta devuelve un volumen amplio (200.357 filas) y requiere acceder a la tabla principal (**Key Lookup**) para obtener el total de la compra. Esta combinación dispara las lecturas lógicas a 613.928 páginas debido al alto costo del acceso aleatorio.

Por último, el índice de cobertura (`INCLUDE`) logra la máxima optimización al almacenar directamente la columna del total dentro del propio índice. Esto permite que el motor resuelva toda la petición mediante un **Index Seek** puro sin tocar la tabla física, reduciendo las lecturas lógicas a tan solo 550 páginas (una disminución superior al 88% respecto al escenario base) y minimizando el tiempo de CPU a 187 ms.

**Tabla Comparativa de Rendimientos:** 

![[tablaComparativa.png]]








