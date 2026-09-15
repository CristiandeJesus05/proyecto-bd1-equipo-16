* #          Etapa 1: Requerimientos y Dominio del Negocio  
Nuestro proyecto consiste en el desarrollo de una Base de Datos para un sistema de gestión 
de un cine, orientado a la admiración de películas, funciones, clientes y venta de tickets. El 
sistema permitirá gestionar las películas disponibles, las salas y las funciones programadas. 
También permitirá registrar clientes y realizar ventas de tickets, controlando la disponibilidad de 
las butacas en la sala. Este sistema permitirá gestionar el stock disponible de tickets para cada 
función registrar los métodos de pago utilizados y almacenar un historial de las ventas 
realizadas, almacenará el precio unitario del ticket en el momento de realizar la compra para 
garantizar el historial de información y de esa manera evitando que modificaciones posteriores 
en el precio afecten a las ventas ya registradas.  
* ## Regla de negocio:
  RN.01: “Registro de clientes”: Todo cliente deberá estar registrado en el sistema para poder 
realizar la compra de tickets.   
  RN.02: Gestión de películas: Cada película deberá estar registrada en el sistema mediante un 
identificador único.   
  RN.03: Gestión de salas: Cada sala deberá contar con un identificador único y una capacidad 
determinada de butacas.   
  RN.04: Gestión de butacas: Cada butaca deberá tener una fila y un numero asignado.   
  RN.05: Funciones: Cada función deberá estar asociada a una única película, una única sala, 
una única, fecha y un horario determinado.   
  RN.06: No podrán existir dos funciones programadas en la misma sala, fecha y horario.  
  RN.07: Un cliente podrá realzar una venta que incluya uno o varios tickets.  
  RN.08: Toda venta de ticket deberá estar asociada a un único método de pago.  
  RN.09: Gestión de stock de tickets: Cada función tendrá una cantidad determinada de tickets 
disponibles.  
  RN.10: Cada ticket vendido deberá estar asociado a una única butaca perteneciente a la sala 
donde realizará la función.


* ## Alcance del sistema:
    
* ### El sistema incluirá una “Gestión de películas”:  
   Registro de películas  
   Consulta de películas  
   Modificación de información   
   Asociación de películas con funciones
  
* #### Gestión de salas y funciones:   
   Registro de salas  
   Registro de butacas   
   Programación de funciones  
   Asociación de películas y salas  
   Control de horarios    
* #### Registro de clientes:  
   Registro de clientes  
   Identificación de clientes  
   Consulta de clientes  
   Historial de compras  
* #### Venta de tickets:    
   Registro de ventas  
   Compra de uno o varios tickets   
   Selección de función  
   Selección de butaca  
   Control de disponibilidad   
* #### Gestión de stock:    
   Control de tickets disponibles por la función 
   Impedir ventas cuando no haya disponibilidad  
* #### Métodos de pago:  
   Registro de método de pago utilizando en cada venta (Efectivo, Tarjeta de crédito, débito o transferencia)   
* #### Historial de precios:  
   Registrar el precio unitario de cada ticket en el detalle de la venta   
   Conservar el precio histórico, aunque posteriormente cambie el precio de la función  
