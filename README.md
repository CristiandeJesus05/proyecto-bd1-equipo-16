* # Proyecto-BD1-Grupo16   


* ### Nombre del Proyecto: 
"Cine del Paraná”   

* ### Descripción: 
Nuestro proyecto consiste en desarrollar una base de datos para gestionar un cine, incluyendo películas, funciones, salas, clientes y ventas de tickets.  
* ### Objetivo: 
El objetivo del sistema es controlar la disponibilidad de las butacas, registrar los métodos de pago y mantener un historial de las ventas realizadas. Además, busca conservar el precio de cada ticket al momento de la compra, evitando que futuras modificaciones afecten a las ventas anteriores.  
* ### Integrantes:
1. Solis, Ignacio Emiliano   
2. Segovia, Cristian de Jesús  
3. Gonzales Coene, Rita  
4. Torres, Fabiana Yaquelin   
5. Román, Virginia Guadalupe  
* ### Tecnologías utilizadas:  
 1- Microsoft SQL Server.   
 2- SQL (lenguaje de consultas).  
 3- SQL Server Management Studio (SSMS).  
* ## Estructura del proyecto: 
#### - docs/ : 
Contiene las carpetas de las etapas que fuimos elaborando a lo largo del cuatrimestre:  
  1- Etapa 01: contiene una explicación en que consiste nuestro proyecto, las regla de negocio que se maneja y el alcance del sistema.  
  2- Etapa 02: Contiene imagen del modelo der y el modelo relacional, explicando las cardinalidades y las claves primarias, por ultimo la normalización aplicadas  
  3- Etapa 03: Contiene la explicación de cada tabla junto con sus restricciones, por ultiimo contiene una validacion de datos de cada uno.  
  4- Etapa 04: Contiene consultas ficticias, donde se aborda consultas basicas, como comprobante de venta,informe de venta y consulta avanzadas  
  5- Etapa 05: Trata sobre mejoras y funcionalidades avanzadas de la base de datos, como la optimización de consultas, procedimientos, seguridad, transacciones y auditorías mediante triggers, permitiendo buscar mejorar el funcionamiento, el control y la seguridad del sistema.  
#### - Sql/: 
Contiene las carpetas de los codigos en lenguaje sql para uso de la base de datos:  
    - Consultas/: Contiene las consultas de comprobante de venta,informe de venta y consulta avanzadas.  
    - ddl/: Contiene la definición de las tablas, junto con la restricciones y relaciones entre ellas.  
    - dml/: Contiene el lote de datos de prueba de la base de datos, con el que se maneja para hacer consultas.  
    - tecnico/: Contiene las mejoras y funcionalidades como funciones, procedimiento, transaciones, seguridad y trigger.  
    - documentacion.md: Contiene una explicacion detallada de la definicion de las tablas con sus restricciones y claves foraneas.   
* ## Instrucciones de instalación: 
Esta guía te lleva paso a paso para tener la base de datos de **Cine del Paraná** funcionando en tu computadora, aunque nunca hayas instalado nada de esto.  
### Paso n.º 1: Instalar Microsoft SQL Server  
1. Entrá a la página oficial de descargas: https://www.microsoft.com/sql-server/sql-server-downloads  
2. Descargá la edición **Developer** (gratuita) o la **Express**.  
3. Ejecutá el instalador y elegí la instalación **Básica**.  
4. Al terminar, anotá el nombre del servidor que aparece en pantalla. Lo vas a necesitar para conectarte.  
### Paso n.º 2: Instalar SQL Server Management Studio (SSMS)  
1. Descargalo desde: https://learn.microsoft.com/sql/ssms/download-sql-server-management-studio-ssms  
2. Ejecutá el instalador y seguí los pasos hasta terminar.  
3. Abrí SSMS, escribí el nombre del servidor del paso anterior y hacé clic en **Conectar**.  
### Paso n.º 3: Descargar el repositorio  
**Opción A: clonar con Git**
```bash
git clone https://github.com/CristiandeJesus05/proyecto-bd1-equipo-16.git
```  
**Opción B: descargar el ZIP**  
1. En la página principal del repositorio, hacé clic en el botón verde **Code**.
2. Elegí **Download ZIP**.
3. Descomprimí la carpeta en un lugar fácil de encontrar.
### Paso n.º 4: Ejecutar los scripts SQL en el orden correcto  
Los scripts están dentro de la carpeta `sql/`. Para abrir cada uno en SSMS, andá a **Archivo > Abrir > Archivo**, seleccionalo y hacé clic en **Ejecutar** (o presioná `F5`).  
Ejecutalos en este orden:  
1. **`sql/ddl/Creacion_BBD.sql`**: crea la base de datos y sus tablas.
2. **`sql/dml/Lotes_De_Datos.sql`**: carga datos de prueba (películas, salas, clientes, etc.).
3. **Scripts de `sql/tecnico/`** (opcional, pertenecen a la etapa 05): agregan mejoras a la base. Están organizados en las carpetas `indices`, `procedimientos`, `funciones`, `transacciones`, `triggers` y `seguridad`.
4. **Scripts de `sql/consultas/`** (opcional): consultas de ejemplo, como `comprobante_venta.sql`, `informe_ventas.sql` y `consulta_avanzada.sql`.

- Respeta el orden: primero se crea la base (paso 1) y recién después se cargan los datos (paso 2). Si lo hacés al revés, vas a obtener errores.  
-Si querés entender qué hace cada script técnico, la explicación está en la carpeta `docs/etapa-05/`.

### Paso n.º 5: Verificar que la base de datos se creó correctamente

1. En el **Explorador de objetos** (panel izquierdo de SSMS), hacé clic derecho sobre **Bases de datos** y elegí **Actualizar**.
2. Tiene que aparecer la base de datos del Cine del Paraná.
3. Desplegala y entrá en la carpeta **Tablas**: tienen que estar las tablas del sistema.
4. Para confirmar que los datos de prueba se cargaron, abrí una **Nueva consulta**, elegí la base en el selector de arriba a la izquierda y ejecutá cualquiera de las consultas de `sql/consultas/`, por ejemplo `informe_ventas.sql`.

Si la consulta corre sin errores y muestra resultados, ¡ya está todo listo!
