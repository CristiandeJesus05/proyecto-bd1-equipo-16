## Seguridad Manejo de permisos a nivel de usuarios y roles en SQL Server

La **Seguridad** en SQL Server permite controlar la autenticación de usuarios y la autorización sobre las operaciones que estos pueden ejecutar en la base de datos. El objetivo principal es implementar la directiva de **mínimo privilegio**, garantizando que cada usuario acceda únicamente a los datos y procedimientos estrictamente necesarios para cumplir su función dentro del sistema
### Ventajas y Aplicaciones

-**Protección de datos sensibles:** Impide que usuarios sin privilegios modifiquen directamente tablas críticas como `Compra`.

 -**Prevención de errores humanos o destructivos:** Restringe sentencias `INSERT`, `UPDATE` o `DELETE` accidentales sobre el catálogo de `Pelicula` o `Funcion`.
 
-**Centralización de reglas de negocio:** Permite otorgar permisos de ejecución (`EXECUTE`) sobre procedimientos almacenados (como `sp_RegistrarCompraSimple`) sin dar acceso directo de escritura a las tablas base.

-**Mantenibilidad mediante roles:** Agrupa usuarios por perfil (ej. cajeros, administradores) para facilitar el otorgamiento o revocación de accesos sin configurar usuario por usuario.

### Implementación en SQL Server Express


La arquitectura de seguridad de SQL Server opera en tres niveles:
1. **Servidor (Logins):** Autenticación mediante modo mixto (Windows Authentication y SQL Server Authentication).

2. **Base de datos (Users):** Mapeo de los logins a usuarios dentro de la base de datos `Cine_del_Parana`.
  
   <img width="459" height="89" alt="users" src="https://github.com/user-attachments/assets/385f5e1f-5da4-4579-865c-bec2bfaf58ef"    />


4. **Objetos y Roles (Permissions):** Asignación de permisos (`GRANT SELECT`, `GRANT EXECUTE`) directamente a usuarios o mediante la inclusión a roles definidos por el usuario o por el sistema (ej. `db_owner`)

<img width="626" height="63" alt="db_owner" src="https://github.com/user-attachments/assets/88f92a03-0f91-4ded-a6a0-b125dec30875" />
<img width="591" height="67" alt="grantExcute" src="https://github.com/user-attachments/assets/63e6ce0d-0772-4f88-a83b-0e4b95f9348b" />
<img width="631" height="90" alt="grandSelect" src="https://github.com/user-attachments/assets/96775d9e-4c72-4708-a578-47c155aaf985" />

   

## Escenarios Posibles:

Se evalúan dos escenarios con las tablas del sistema:

-**Manejo de permisos a nivel de usuarios:** Se crea un usuario `usuario_admin` (con acceso total mediante `db_owner`) y un usuario `usuario_lector` (con permisos `SELECT` sobre la tabla `Compra` y `EXECUTE` sobre el procedimiento almacenado `sp_RegistrarCompraSimple`). Se demuestra que el usuario lector no puede hacer inserciones directas en `Compra`, pero sí puede registrar compras invocando el procedimiento almacenado.

-**Manejo de permisos a nivel de roles del DBMS:** Se crea el rol `rol_consulta_peliculas` con permiso `SELECT` sobre la tabla `Pelicula`. Se asigna a `usuario_con_rol` y se compara su acceso frente a `usuario_sin_rol`.

## Demostración de seguridad
### Verificación del Modo de Autenticación: 
Se ejecutó la consulta de propiedades del servidor para constatar el soporte de autenticación mixta

<img width="323" height="58" alt="modo_autenticación" src="https://github.com/user-attachments/assets/cd130669-bb4d-4f2b-a2db-693aacca7d62" />

### Pruebas a Nivel de Usuarios 

**Prueba A (INSERT directo por `usuario_admin`):** El usuario con rol `db_owner` insertó el registro sin inconvenientes

<img width="514" height="87" alt="consultaEjecutadaCorrectamente" src="https://github.com/user-attachments/assets/56969e4b-3045-4c77-93c6-839f573d5c8a" />


**Prueba B (INSERT directo por `usuario_lector`):** El motor denegó la operación por falta de permisos explícitos de inserción sobre la tabla `Compra`

<img width="785" height="91" alt="pruebaB" src="https://github.com/user-attachments/assets/8e02d208-0956-4f8a-80c9-e9801964aaec" />

**Prueba C (INSERT mediante `sp_RegistrarCompraSimple` por `usuario_lector`):** Se ejecutó con éxito el procedimiento almacenado autorizando la modificación indirecta de la tabla.

<img width="514" height="87" alt="consultaEjecutadaCorrectamente" src="https://github.com/user-attachments/assets/f37a1ef4-bfbf-442d-9c6c-d5cbd3ebb850" />


### Pruebas a Nivel de Roles 

**Prueba D (SELECT por `usuario_con_rol`):** Al pertenecer al rol `rol_consulta_peliculas`, la consulta retornó los registros de la tabla `Pelicula`

<img width="658" height="97" alt="pruebaD" src="https://github.com/user-attachments/assets/301bb3df-84f1-4ddd-b058-b47dacc58485" />


**Prueba E (SELECT por `usuario_sin_rol`):** La consulta fue denegada por no poseer acceso explícito ni heredado a la tabla

<img width="514" height="87" alt="consultaEjecutadaCorrectamente" src="https://github.com/user-attachments/assets/1d115c5b-6d01-4bd0-87ee-737a8db54180" />

<img width="778" height="89" alt="pruebaE" src="https://github.com/user-attachments/assets/d5f42bde-5019-42a4-8448-46f62d86b1c8" />

Se verificó la viabilidad de delegar operaciones de escritura únicamente a través de procedimientos almacenados autorizados sin otorgar acceso directo a las tablas base (Compra), respetando las reglas del negocio del cine.   Se constató la eficiencia de administrar accesos mediante roles grupales (rol_consulta_peliculas), facilitando el mantenimiento y escalabilidad de la seguridad del sistema.   

