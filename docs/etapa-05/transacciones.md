## Transacciones
El uso que damos en transacciones es fundamental a la hora de poder manejar datos correctamente, es por ello que su uso, en procedimiento y funciones es fundamental para poder garantizar que no haya inconcistencia en los datos que se carguen, de lo contrario, no se deben cargar los datos.  
* El procedimiento usado es el Procedimiento Almacenado: "sp_RegistrarCompra"  
* Comprobación de error:  
1) Para ello queremos obtener los datos antes de un cambio forzado:  
          <img width="202" height="202" alt="image" src="https://github.com/user-attachments/assets/eb173f14-0b10-4805-b19f-58587aa29b90" />

3) El @IdCompra = 1017 es un número nuevo que no existe asique podría considerarse una compra valida. El problema surge cuando es @ListaButacas = '[100]' en la función 12: esa butaca ya tiene ticket vendido para esa función (el ticket 27 de tu lote). Al intentar venderla otra vez, se viola la restricción uq_ticket_funcion_butaca, que impide vender una butaca dos veces en la misma función 
          <img width="830" height="64" alt="image" src="https://github.com/user-attachments/assets/e0808400-3dbc-484a-954c-95eb7209f599" />

4) Como ultimo paso comprobamos que esta transaccion no afecto a los datos original:  
          <img width="506" height="244" alt="image" src="https://github.com/user-attachments/assets/6d8f28cd-093a-41b0-b9ad-758c3e13d6a4" />

## Conclusion
Aunque la compra llegó a insertarse dentro de la transacción, al fallar el ticket el `ROLLBACK` deshizo todo y la base quedó exactamente como estaba. Esto demuestra que la transacción cumple su función: "Si una parte de la operación falla, no se guarda ningún dato".
