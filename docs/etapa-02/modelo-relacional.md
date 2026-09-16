* # Modelo Relacional

<img width="3258" height="1821" alt="modelo-relacional" src="https://github.com/user-attachments/assets/2ad414c4-ddee-4d5f-b966-d02851e93de2" />

* ### Cardinalidades
- Cliente -- realiza -- Compra "1:N" : Un cliente puede realizar muchas compras, pero cada compra pertenece a un unico cliente.
- Metodo_pago -- utiliza -- Compra "1:N" : Un meteodo de pago puede utilizarse en muchas compras, pero cada compra utiliza un unico metodo de pago.
- Compra -- contiene -- Ticket "1:N" : Una compra contiene uno o varios tickets, y cada ticket pertenece a una unica compra.
- Pelicula -- tiene -- Funcion "1:N" : Una pelicula puede tener muchas funciones, pero cada funcion corresponde a una unica pelicula.
- Sala -- tiene -- Funcion "1:N" : Una sala puede tener muchas funciones, pero cada funcion se realiza en una unica sala.
- Sala -- posee -- Butaca "1:N" : Una sala posee muchas butacas, pero cada butaca pertenece a una unica sala.
- Funcion -- corresponde a -- Ticket "1:N": Una funcion puede tener muchos tickets vendidos, pero cada ticket corresponde a una unica funcion.
- Butaca -- es asignada a -- Ticket "1:N": Una butaca puede utilizarse en distintos tickets a lo largo del tiempo, pero cada ticket corresponde a un unica butaca.
