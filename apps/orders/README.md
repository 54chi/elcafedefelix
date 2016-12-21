# Orders

API para el sistema de órdenes de compra de El Café de Félix.

### El Graph de las Ordenes de El Café de Félix

Manejar variedades como productos, subproductos, something else?

El Graph extiende el que ya habíamos empezado con el sistema de recetas, agregando los siguientes nodes y relaciones:

### Nodos:
- cliente (nombre, e-mail, teléfono): es nuestro consumidor. E.g. Maria, Jose, Robin, etc. Por defecto el cliente asignado es "invitado".
- orden (número, fecha): Item del recibo. En este caso la orden es el pedido de un producto con sus variaciones
- producto (nombre, precio unitario)
- variaciones al producto. Son modificadores al producto en cuestión, y afectan el inventario
- recibo: agrupa las ordenes
- pago: cancela el recibo

#### Relaciones:

- (cliente)-[COLOCA]->(ordenes)
- (orden)-[INCLUYE]->(productos)
- (orden)-[INCLUYE]->(variaciones)

- (cliente)-[PAGA]->(pagos)
- (pago)-[REFIERE]->(recibos)
- (recibo)-[INCLUYE]->(ordenes)
- (cliente)-[RECIBE]->(recibos)

PS. Creo que llamar "orden" a una línea del recibo puede ser un poco confuso. Capaz cambie el concepto más adelante.

Query:

```
//Añadimos un "precio base" a nuestros productos (en este ejemplo, un café latte)
MATCH (_p01:Producto {nombre: "Latte"})
  SET _p01.preciobase=3.50

CREATE
//creamos variaciones al producto, con el costo asociado
  (_v01:Variacion {nombre: "Espresso Shot +1",tipo:"mas", modificador:0.50}),
  (_v02:Variacion {nombre: "Espresso Shot -1",tipo:"menos", modificador:0}),
  (_v03:Variacion {nombre: "Leche Descremada",tipo:"reemplazo",modificador:0}),
  (_v04:Variacion {nombre: "Leche de Soya",tipo:"reemplazo", modificador:1.00}),
  (_v05:Variacion {nombre: "Leche de Almendras",tipo:"reemplazo",modificador:1.00}),
  (_v06:Variacion {nombre: "Leche de Nuez",tipo:"reemplazo",modificador:1.50}),

//creamos unos clientes de prueba
  (_cliente00:Cliente {nombre: "invitado"}),
  (_cliente01:Cliente {nombre: "Juan", email:"juan@tomacafe.com", telefono: "1234567890"}),
  (_cliente02:Cliente {nombre: "Marta", email:"martatieneunmarcapasos@porelcafe.com", nota: "crítica de comida", telefono: "543210"}),

//ESCENARIO: "invitado" coloca una orden que incluye un latte con 2 extra shotss y leche de soya
  (_o01:Orden {id:"0001", fecha: 20161220, hora: 170230, total:5.50}),
  (_cliente00)-[:COLOCA]->(_o01),
  (_o01)-[:INCLUYE {cantidad:1}]->(_p01),
  (_o01)-[:INCLUYE {cantidad:2}]->(_v01),
  (_o01)-[:INCLUYE {cantidad:1}]->(_v04),

//un recibo es creado para la(s) orden(es) y pagada por el cliente con su tarjeta visa (el sistema de pago es externo)
  (_recibo01:Recibo {id:"0000001", fecha:20161220, total: 5.50}),
  (_recibo01)-[:INCLUYE]->(_o01),
  (_pago01:Pago {id:"11000001", tarjeta: "VISA", token: "131231231sasad", status: "completo", fecha:20161220, hora: 170305, total: 5.50}),
  (_pago01)-[:REFIERE]->(_recibo01),
  (_cliente00)-[:PAGA]->(_pago01),
  (_cliente00)-[:RECIBE]->(_recibo01)

```
