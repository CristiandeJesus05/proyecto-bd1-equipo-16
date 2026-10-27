## Entidad: Pelicula  

## Restricciones:  

NOT NULL: En Pelicula, obliga a que cada campo (título, género, descripción y duración) reciba un valor obligatorio, asegurando que la cartelera no tenga información   incompleta. En Metodo_Pago, la columna descripcion_pago carece de esta restricción, lo cual es un error de diseño el sistema permitiría guardar un método de pago   sin nombre  

PRIMARY KEY: Define a id_pelicula y id_pago como los identificadores principales y exclusivos. El motor de la base de datos usará estos campos para buscar y enlazar   la información rápidamente  

UNIQUE: En ambas tablas declaraste CONSTRAINT uq_id UNIQUE sobre los mismos campos que ya son claves primarias. Esto es innecesario, ya que la restricción PRIMARY   KEY aplica implícitamente la unicidad absoluta  

## Integridad:  

Integridad de Entidad: Se garantiza mediante las claves primarias. El sistema hará matemáticamente imposible que existan dos películas o dos métodos de pago con el   mismo número de ID  

Integridad de Dominio: Se mantiene limitando el tipo y tamaño de la información. Por ejemplo, duracion solo aceptará números enteros, y descripcion_pago truncará o   rechazará cualquier texto superior a 50 caracteres  

Preparación para la Integridad Referencial: Ambas son tablas maestras independientes no tienen claves foráneas propias. Su función en la integridad global de tu   sistema es servir como origen de datos. La futura tabla Funcion necesitará apuntar obligatoriamente a un id_pelicula válido que ya exista aquí, y la futura tabla   Venta solo podrá registrar transacciones si el id_pago existe previamente en esta tabla Metodo_Pago  
