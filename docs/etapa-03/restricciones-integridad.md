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
CONSTRAINT uq_butaca_sala UNIQUE (id_sala, fila, numero): la combinación de sala, fila y número es la que identifica la ubicación de una butaca.

#### Clave primaria:
* CONSTRAINT pk_butaca primary key(id_butaca): Define id_butaca como el identificador unico para cada butaca

#### Claves Foraneas:
* CONSTRAINT fk_butaca_sala foreign key(id_sala) REFERENCES Sala(id_sala): Establece la relacion entre Butaca y Sala, garantizando que la sala asociada a una butaca exista previanmente en la tabla Sala.

## Integridad
* Integridad de Entidad: Se garantiza mediante la clave primaria pk_butaca, que utiliza el atributo id_butaca para identificar de manera única cada butaca. Esto impide que existan dos butacas con el mismo identificador y garantiza que cada registro tenga una identidad propia.

* Integridad de Dominio: Se establece mediante los tipos de datos y las restricciones definidas sobre los atributos de la tabla. La restricción UNIQUE(fila, numero, id_sala) impide que existan dos butacas con la misma fila y número dentro de una misma sala. Esto permite que distintas salas tengan butacas con iguales números y filas, sin generar conflictos en su identificación.

* Integridad Referencial: Se garantiza mediante la clave foránea fk_butaca_sala, que vincula cada butaca con una sala existente en la tabla Sala. De esta manera, no se puede registrar una butaca asociada a una sala que no exista previamente en la base de datos.


## Entidad: Funcion

## Restricciones:
* CONSTRAINT ck_precio_actual CHECK(precio_actual >= 0): Garantiza que el precio de una función no pueda ser negativo.
* CONSTRAINT ck_stock_disponible CHECK(stock_disponible >= 0): Garantiza que la cantidad de tickets disponibles no pueda ser negativa.
* CONSTRAINT uq_funcion_especifica UNIQUE (fecha,hora,id_sala): Al poner unico los 3, nos aseguramos que una funcion no empiece en la misma sala y hora.

#### Clave primaria:
* CONSTRAINT pk_funcion primary key(id_funcion): Define id_funcion como el identificador unico para cada funcion.

#### Claves Foraneas:
* CONSTRAINT fk_funcion_pelicula foreign key(id_pelicula) REFERENCES Pelicula(id_pelicula): Relaciona cada función con una pelicula existente en la tabla Pelicula.
* CONSTRAINT fk_funcion_sala foreign key(id_sala) REFERENCES Sala(id_sala): Relaciona cada función con una sala existente en la tabla Sala.
 
## Integridad:
* Integridad de Entidad: Se garantiza mediante la clave primaria pk_funcion, que identifica de manera única cada función a través del atributo id_funcion. Esto evita que existan dos funciones con el mismo identificador.

* Integridad de Dominio: Se establece mediante los tipos de datos y las restricciones CHECK aplicadas a los atributos precio_actual y stock_disponible. La restricción ck_precio_actual impide registrar precios negativos, mientras que ck_stock_disponible evita que la cantidad de tickets disponibles sea inferior a cero. De esta forma, se garantiza que los precios y el stock mantengan valores válidos.

* Integridad Referencial: Se garantiza mediante las claves foráneas fk_funcion_pelicula y fk_funcion_sala. La primera asegura que cada función esté asociada a una película existente en la tabla Pelicula, mientras que la segunda garantiza que la sala asignada exista en la tabla Sala. Esto evita registrar funciones vinculadas a películas o salas inexistentes.

* Integridad de las Reglas de Negocio: Se garantiza mediante la restricción de unicidad definida sobre la sala, la fecha y el horario de la función. Esta restricción impide que se programen dos funciones en la misma sala para el mismo momento, evitando superposiciones en la cartelera. Al mismo tiempo, permite que se proyecten películas diferentes en salas distintas durante el mismo horario.

## Entidad: Compra

## Restricciones:
* CONSTRAINT ck_total_compra CHECK(total_compra >= 0): Garantiza que el total de una compra no pueda tener un valor negativo.

#### Clave primaria: 
* CONSTRAINT pk_compra primary key(id_compra): Define id_compra como el identificador unico de para cada una de las compras realizadas.

#### Claves Foraneas:
* CONSTRAINT fk_compra_pago foreign key(id_pago) REFERENCES Metodo_Pago(id_pago): Establece la relación entre la compra y el método de pago utilizado, garantizando que el método de pago exista en la tabla Metodo_Pago.
* CONSTRAINT fk_compra_cliente foreign key(id_cliente) REFERENCES Cliente(id_cliente): Establece la relación entre la compra y el cliente que la realizó, garantizando que el cliente exista en la tabla Cliente.

## Integridad:
* Integridad de Entidad: Se garantiza mediante la clave primaria pk_compra, que identifica de manera única cada compra realizada a través del atributo id_compra. Esto permite distinguir cada operación de venta y evita que existan compras con identificadores duplicados.

* Integridad de Dominio: Se establece mediante los tipos de datos y la restricción ck_total_compra, que impide registrar un importe total negativo. Esto garantiza que el total de una compra no pueda ser inferior a cero. Además, los atributos obligatorios deben contar con restricciones NOT NULL para evitar que se registren compras con información esencial incompleta.

* Integridad Referencial: Se garantiza mediante las claves foráneas fk_compra_pago y fk_compra_cliente. La primera asegura que el método de pago utilizado exista previamente en la tabla Metodo_Pago, mientras que la segunda garantiza que el cliente asociado a la compra exista en la tabla Cliente. De esta manera, cada compra queda vinculada a un método de pago y a un cliente válidos.

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

* Integridad de Entidad: Se garantiza mediante la clave primaria compuesta pk_ticket, formada por los atributos nro_item e id_compra. Esta combinación identifica de manera única cada ticket dentro de una compra. Por ejemplo, dos compras diferentes pueden tener un ticket con nro_item = 1 sin generar conflictos, porque cada ticket queda identificado por la combinación de su número de ítem y el identificador de la compra correspondiente.

* Integridad de Dominio: Se establece mediante los tipos de datos y la restricción ck_precio_unitario, que impide registrar precios unitarios negativos. Además, los atributos obligatorios deben contar con restricciones NOT NULL para garantizar que cada ticket tenga asociados los datos necesarios para su correcta identificación y registro.

* Integridad Referencial: Se garantiza mediante las claves foráneas fk_ticket_compra, fk_ticket_butaca y fk_ticket_funcion. La primera asegura que el ticket pertenezca a una compra existente en la tabla Compra; la segunda garantiza que la butaca seleccionada exista en Butaca; y la tercera verifica que la función para la cual se adquirió el ticket exista en Funcion. De esta forma, se evita registrar tickets relacionados con compras, butacas o funciones inexistentes.

* Integridad de la Asignación de Butacas: Se garantiza mediante la restricción UNIQUE(id_funcion, id_butaca), que impide asignar la misma butaca a más de un ticket para una misma función. Esto evita la venta duplicada de un asiento durante una proyección, aunque permite que esa misma butaca se venda nuevamente para otra función en un horario diferente.

* Integridad del Historial de Precios: Se garantiza mediante el atributo precio_unitario, que conserva el precio del ticket al momento de la compra. Si posteriormente se modifica el precio de una función, los tickets vendidos anteriormente mantienen su precio original. Esto permite preservar el historial de las operaciones comerciales y calcular correctamente el importe de cada compra.
