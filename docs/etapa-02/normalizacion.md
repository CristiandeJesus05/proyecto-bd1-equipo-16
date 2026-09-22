**Primera Forma Normal (1FN):**

El modelo cumple con la **1FN** porque cada campo de cada tabla almacena un valor **atómico e indivisible** (un solo dato por celda). Las relaciones de uno a muchos (como Compra con Ticket o Sala con Butaca) se resuelven mediante tablas independientes conectadas por Claves Foráneas, evitando por completo el uso de multiples datos agrupados, atributos multivaluados o columnas repetitivas dentro de una misma fila.

**Segunda Forma Normal (2FN):**

El modelo cumple con 1FN y todos los atributos no clave **dependen en su totalidad de la clave primaria** (no existen dependencias parciales en tablas con clave primaria compuesta). Las tablas con clave primaria simple (como Pelicula o Metodo_pago) cumplen 2FN por definicion al ser claves simples. Ademas las claves compuestas (como Ticket o Butaca), todos sus datos dependen de la clave primaria compuesta completa. Por eso, este modelo cumple con **2FN**.

**Tercera Forma Normal (3FN):**
