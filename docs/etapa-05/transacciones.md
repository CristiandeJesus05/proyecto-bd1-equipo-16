## Transacciones
El uso que damos en transacciones es fundamental a la hora de poder manejar datos correctamente, es por ello que su uso, en procedimiento y funciones es fundamental para poder garantizar que no haya inconcistencia en los datos que se carguen, de lo contrario, no se deben cargar los datos.  
* El procedimiento usado es el Procedimiento Almacenado: "sp_RegistrarCompra"  
* Comprobación de error:  
1) Para ello queremos obtener los datos antes de un cambio forzado:  
          <img width="182" height="237" alt="image" src="https://github.com/user-attachments/assets/289a582f-90e7-4949-9e87-dcb5459e0cf1" />

3) El @IdCompra = 1017 es un número nuevo que no existe asique podría considerarse una compra valida. El problema surge cuando es @ListaButacas = '[100]' en la función 12: esa butaca ya tiene ticket vendido para esa función (el ticket 27 de tu lote). Al intentar venderla otra vez, se viola la restricción uq_ticket_funcion_butaca, que impide vender una butaca dos veces en la misma función 
          <img width="794" height="56" alt="image" src="https://github.com/user-attachments/assets/cd773bdb-21ef-4e89-89e9-48084a8ec607" />

4) Como ultimo paso comprobamos que esta transaccion no afecto a los datos original:  
          <img width="495" height="256" alt="image" src="https://github.com/user-attachments/assets/930d7d86-e64d-4fa2-9f76-71cd0124d3ab" />

## Conclusion
Aunque la compra llegó a insertarse dentro de la transacción, al fallar el ticket el `ROLLBACK` deshizo todo y la base quedó exactamente como estaba. Esto demuestra que la transacción cumple su función: "Si una parte de la operación falla, no se guarda ningún dato".
