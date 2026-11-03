## Trigger  

TRIGGERS DE AUDITORIA (UPDATE y DELETE)  
1) TABLAS AUXILIARES DE AUDITORIA  
Columnas comunes: operacion ('UPDATE' o 'DELETE'), fecha_operacion,  
hora_operacion y usuario. El resto son los valores viejos del registro

2) TRIGGERS DE AUDITORIA  
En un trigger AFTER UPDATE/DELETE, la tabla "deleted" contiene los  
valores anteriores. Si existen filas en "inserted" fue un UPDATE;  
si no, fue un DELETE
USER_NAME() devuelve el usuario de la base de datos que ejecuto la  
operacion (para ver el login del servidor se puede usar SUSER_SNAME()) 

Tablas auditadas: Cliente, Funcion y Compra 

 2) TRIGGER QUE BLOQUEA EL DELETE  
Tabla protegida: Pelicula (INSTEAD OF DELETE)  

1) TRIGGER QUE NO PERMITE BORRAR
INSTEAD OF DELETE reemplaza al DELETE: emite un mensaje de error y  
la operacion no se realiza


## Auditorias  

-- PRUEBAS de los triggers de auditoria y del bloqueo de DELETE
-- Correr DESPUES de auditoria_cine.sql, con los dos lotes de datos
-- Las pruebas que modifican datos terminan en ROLLBACK: no dejan cambios


-- PRUEBA 1: auditoria de un UPDATE sobre Cliente
-- Esperado:  
<img width="571" height="115" alt="Captura de pantalla 2026-11-03 201018" src="https://github.com/user-attachments/assets/728102c1-bc5a-4c76-8711-89782b99478f" />

-- PRUEBA 2: auditoria de un DELETE sobre Cliente
-- El cliente 3 no tiene compras por eso se puede borrar  
-- Esperado:  
<img width="583" height="125" alt="Captura de pantalla 2026-11-03 201314" src="https://github.com/user-attachments/assets/1fbf0bfc-20fd-4687-a7cd-22c615ab5b2e" />


-- PRUEBA 3: auditoria de un UPDATE sobre Funcion  
-- Esperado:  
<img width="352" height="107" alt="Captura de pantalla 2026-11-03 201424" src="https://github.com/user-attachments/assets/e060ee1f-08d6-4444-882f-e693314e3bd4" />


-- PRUEBA 4: auditoria de un UPDATE sobre Compra  
-- Esperado:  
<img width="357" height="118" alt="Captura de pantalla 2026-11-03 201519" src="https://github.com/user-attachments/assets/299eb18c-1cbb-4ec3-ac68-55e1a608f2a1" />


-- PRUEBA 5: el trigger bloquea el DELETE sobre Pelicula  
-- Esperado:  
<img width="377" height="267" alt="image" src="https://github.com/user-attachments/assets/b3318a43-68a2-4acc-b996-fa792701ae46" />




-- PRUEBA 6: ver con que usuario se registra la auditoria  
<img width="305" height="140" alt="image" src="https://github.com/user-attachments/assets/b25bf8c3-16c4-45f7-b866-f34923bed896" />


