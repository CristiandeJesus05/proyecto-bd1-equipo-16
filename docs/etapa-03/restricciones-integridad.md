## Entidad: Pelicula  y Metodo Pago

## Restricciones  

NOT NULL: En Pelicula, obliga a que cada campo (título, género, descripción y duración) reciba un valor obligatorio, asegurando que la cartelera no tenga información   incompleta. En Metodo_Pago, la columna descripcion_pago carece de esta restricción, lo cual es un error de diseño el sistema permitiría guardar un método de pago   sin nombre  

PRIMARY KEY: Define a id_pelicula y id_pago como los identificadores principales y exclusivos. El motor de la base de datos usará estos campos para buscar y enlazar   la información rápidamente  

UNIQUE: En ambas tablas declaraste CONSTRAINT uq_id UNIQUE sobre los mismos campos que ya son claves primarias. Esto es innecesario, ya que la restricción PRIMARY   KEY aplica implícitamente la unicidad absoluta  

## Integridad  

Integridad de Entidad: Se garantiza mediante las claves primarias. El sistema hará matemáticamente imposible que existan dos películas o dos métodos de pago con el   mismo número de ID  

Integridad de Dominio: Se mantiene limitando el tipo y tamaño de la información. Por ejemplo, duracion solo aceptará números enteros, y descripcion_pago truncará o   rechazará cualquier texto superior a 50 caracteres  

Preparación para la Integridad Referencial: Ambas son tablas maestras independientes no tienen claves foráneas propias. Su función en la integridad global de tu   sistema es servir como origen de datos. La futura tabla Funcion necesitará apuntar obligatoriamente a un id_pelicula válido que ya exista aquí, y la futura tabla   Venta solo podrá registrar transacciones si el id_pago existe previamente en esta tabla Metodo_Pago  

## Entidad: Butaca

## Restricciones:
* CONSTRAINT uq_numero UNIQUE(numero): Garantiza que no existan dos registros con el mismo numero de butaca
* CONSTRAINT uq_fila UNIQUE(fila): Garantiza que no existan dos registros con la misma fila.

#### Claves Foraneas:
* CONSTRAINT fk_butaca_sala foreign key(id_sala) REFERENCES Sala(id_sala): Establece la relacion entre Butaca y Sala, garantizando que la sala asociada a una butaca exista previanmente en la tabla Sala.

## Integridad

## Entidad: Funcion

## Restricciones:
* CONSTRAINT ck_precio_actual CHECK(precio_actual >= 0): Garantiza que el precio de una función no pueda ser negativo.
* CONSTRAINT ck_stock_disponible CHECK(stock_disponible >= 0): Garantiza que la cantidad de tickets disponibles no pueda ser negativa.

#### Claves Foraneas:
* CONSTRAINT fk_funcion_pelicula foreign key(id_pelicula) REFERENCES Pelicula(id_pelicula): Relaciona cada función con una pelicula existente en la tabla Pelicula.
* CONSTRAINT fk_funcion_sala foreign key(id_sala) REFERENCES Sala(id_sala): Relaciona cada función con una sala existente en la tabla Sala.

## Entidad: Compra

## Restricciones:
* CONSTRAINT ck_total_compra CHECK(total_compra >= 0): Garantiza que el total de una compra no pueda tener un valor negativo.

#### Claves Foraneas:
* CONSTRAINT fk_compra_pago foreign key(id_pago) REFERENCES Metodo_Pago(id_pago): Establece la relación entre la compra y el método de pago utilizado, garantizando que el método de pago exista en la tabla Metodo_Pago.
* CONSTRAINT fk_compra_cliente foreign key(id_cliente) REFERENCES Cliente(id_cliente): Establece la relación entre la compra y el cliente que la realizó, garantizando que el cliente exista en la tabla Cliente.
## Integridad:

## Entidad: Ticket

## Restricciones:
* CONSTRAINT ck_precio_unitario CHECK(precio_unitario >= 0): Garantiza que el precio de un ticket no pueda ser negativo.
#### Clave pimaria:
* CONSTRAINT pk_ticket primary key(nro_item, id_compra): Establecemos una clave primaria compuesta formada por nro_item e id_compra. Esto permite identificar de manera única cada ticket dentro de una determinada compra. Por ejemplo, una compra puede tener los ítems 1, 2 y 3, y otra compra también puede tener los ítems 1, 2 y 3 sin generar conflictos, porque el identificador completo lo formamos combinando ambos valores.

#### Restricciones:
* CONSTRAINT ck_precio_unitario CHECK(precio_unitario >= 0): Garantiza que el precio de un ticket no pueda ser negativo.

#### Claves Foraneas:
* CONSTRAINT fk_ticket_compra foreign key(id_compra) REFERENCES Compra(id_compra): Relaciona cada ticket con la compra a la que pertenece.
* CONSTRAINT fk_ticket_butaca foreign key(id_butaca) REFERENCES Butaca(id_butaca): Relaciona el ticket con la butaca seleccionada.
* CONSTRAINT fk_ticket_funcion foreign key(id_funcion) REFERENCES Funcion(id_funcion): Relaciona el ticket con la función para la cual fue adquirido.
#### "Atributo precio_unitario":
Este nos permite conservar el precio histórico del ticket en el momento de la compra. De esta manera, si posteriormente cambia el precio de una función, el precio registrado en los tickets de compras anteriores no se modifica. Esto permite mantener un historial correcto de las operaciones realizadas.

## Integridad
