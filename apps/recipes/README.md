# Recipes

Buscador de recetas para El Cafe de Félix.

### El Graph de las recetas de El Café de Félix:

Un extracto de algunos de los productos del menú de El Café de Félix.

![El Graph ](https://hatarakimaseando.files.wordpress.com/2016/12/menu02.png?w=1024)

Query:

```
CREATE
// categorias de productos a la venta
  (_c1:Categoria {nombre: "Bebidas"}),
  (_c2:Categoria {nombre: "Alimentos Frescos"}),
  (_c3:Categoria {nombre: "Alimentos Envasados"}),
  (_c4:Categoria {nombre: "Mercaderia"}),
// subcategorias de bebidas
  (_c10:Categoria {nombre: "Café Pasado"}),
  (_c11:Categoria {nombre: "Espresso"}),
  (_c12:Categoria {nombre: "Infusiones"}),
  (_c13:Categoria {nombre: "Chocolate"}),
  (_c1)-[:AGRUPA]->(_c10),
  (_c1)-[:AGRUPA]->(_c11),
  (_c1)-[:AGRUPA]->(_c12),
  (_c1)-[:AGRUPA]->(_c13),
// productos de cafe pasado
  (_cp00:Producto {nombre: "Café de la casa oscuro"}),
  (_cp01:Producto {nombre: "Café de la casa ligero"}),
  (_cp02:Producto {nombre: "Prensa Francesa"}),
  (_cp03:Producto {nombre: "Aeropress"}),
  (_cp04:Producto {nombre: "Chemex"}),  
  (_cp05:Producto {nombre: "Café descafeínado"}),
  (_c10)-[:AGRUPA]->(_cp00),    
  (_c10)-[:AGRUPA]->(_cp01),    
  (_c10)-[:AGRUPA]->(_cp02),    
  (_c10)-[:AGRUPA]->(_cp03),    
  (_c10)-[:AGRUPA]->(_cp04),    
  (_c10)-[:AGRUPA]->(_cp05),
// productos del menu de espressos
  (_ce0:Producto {nombre: "Café Espresso", costo: 1, precio: 3, presentacion: "demitasse", descripcion: "yada, yada, yada"}),
  (_ce1:Producto {nombre: "Americano", costo: 1.1, precio: 6, presentacion: "taza básica"}),
  (_ce2:Producto {nombre: "Latte"}),
  (_ce3:Producto {nombre: "Mocha"}),
  (_ce4:Producto {nombre: "Black Eye"}),
  (_ce5:Producto {nombre: "Red Eye"}),
  (_ce6:Producto {nombre: "Dead Eye"}),
  (_ce7:Producto {nombre: "Breve"}),
  (_ce8:Producto {nombre: "Au Lait"}),
  (_ce9:Producto {nombre: "Café con Leche"}),
  (_ce10:Producto {nombre: "Capuccino"}),
  (_ce11:Producto {nombre: "Vienés"}),
  (_c11)-[:AGRUPA]->(_ce0),
  (_c11)-[:AGRUPA]->(_ce1),  
  (_c11)-[:AGRUPA]->(_ce2),  
  (_c11)-[:AGRUPA]->(_ce3),  
  (_c11)-[:AGRUPA]->(_ce4),  
  (_c11)-[:AGRUPA]->(_ce5),  
  (_c11)-[:AGRUPA]->(_ce6),  
  (_c11)-[:AGRUPA]->(_ce7),  
  (_c11)-[:AGRUPA]->(_ce8),  
  (_c11)-[:AGRUPA]->(_ce9),  
  (_c11)-[:AGRUPA]->(_ce10),  
  (_c11)-[:AGRUPA]->(_ce11),
// subproductos: preparados en casa y usados para nuestros productos
  (_sp0:SubProducto {nombre: "Shot de Espresso"}),
  (_sp1:SubProducto {nombre: "Espuma de Leche"}),
// ingredientes básicos
  (_i0:Ingrediente {nombre: "Café molido"}),
  (_i1:Ingrediente {nombre: "Hojas de té"}),
  (_i2:Ingrediente {nombre: "Agua filtrada"}),
  (_i3:Ingrediente {nombre: "Azúcar blanca"}),
  (_i4:Ingrediente {nombre: "Azúcar rubia"}),
  (_i5:Ingrediente {nombre: "Edulcorante"}),
  (_i6:Ingrediente {nombre: "Miel de Abeja"}),
  (_i7:Ingrediente {nombre: "Chancaca"}),
  (_i8:Ingrediente {nombre: "Sirope de chocolate"}),
  (_i9:Ingrediente {nombre: "Canela en polvo"}),
  (_i10:Ingrediente {nombre: "Nuez moscada"}),
  (_i11:Ingrediente {nombre: "Crema Chantilly"}),
  (_i12:Ingrediente {nombre: "Leche"}),
  (_i13:Ingrediente {nombre: "Crema de Leche"}),
// recetas básicas para los subproductos
  (_sp0)-[:NECESITA {cantidad: 0.25, medida: "onzas"}]->(_i0),
  (_sp0)-[:NECESITA {cantidad: 1, medida: "onzas"}]->(_i2),
  (_sp1)-[:NECESITA {cantidad: 8, medida: "onzas"}]->(_i12),
// recetas básicas de espresso (por porción ~8 onzas en promedio)
  (_ce0)-[:NECESITA {cantidad:1, medida: "jigger"}]->(_sp0),
  (_ce1)-[:NECESITA {cantidad:2, medida: "jigger"}]->(_sp0),
  (_ce1)-[:NECESITA {cantidad:6, medida: "onzas"}]->(_i2),
  (_ce2)-[:NECESITA {cantidad:2, medida: "jigger"}]->(_sp0),
  (_ce2)-[:NECESITA {cantidad:6, medida: "onzas"}]->(_sp1),
  (_ce3)-[:NECESITA {cantidad:2, medida: "jigger"}]->(_sp0),
  (_ce3)-[:NECESITA {cantidad:1, medida: "onzas"}]->(_i8),
  (_ce3)-[:NECESITA {cantidad:6, medida: "onzas"}]->(_sp1),
  (_ce3)-[:NECESITA {cantidad:1, medida: "shots"}]->(_i11),
  (_ce4)-[:NECESITA {cantidad:2, medida: "jigger"}]->(_sp0),
  (_ce4)-[:NECESITA {cantidad:6, medida: "onzas"}]->(_cp00),
  (_ce5)-[:NECESITA {cantidad:1, medida: "jigger"}]->(_sp0),
  (_ce5)-[:NECESITA {cantidad:7, medida: "onzas"}]->(_cp00),
  (_ce6)-[:NECESITA {cantidad:3, medida: "jigger"}]->(_sp0),
  (_ce6)-[:NECESITA {cantidad:5, medida: "onzas"}]->(_cp00),
  (_ce7)-[:NECESITA {cantidad:1, medida: "jigger"}]->(_sp0),
  (_ce7)-[:NECESITA {cantidad:1, medida: "onzas"}]->(_i13),
  (_ce8)-[:NECESITA {cantidad:3, medida: "onzas"}]->(_cp02),
  (_ce8)-[:NECESITA {cantidad:3, medida: "onzas", nota: "sin espuma"}]->(_sp1),
  (_ce9)-[:NECESITA {cantidad:3, medida: "onzas"}]->(_cp00),
  (_ce9)-[:NECESITA {cantidad:3, medida: "onzas", nota: "calentar a 80C"}]->(_i12),
  (_ce10)-[:NECESITA {cantidad:2, medida: "jigger"}]->(_sp0),
  (_ce10)-[:NECESITA {cantidad:2, medida: "onzas"}]->(_i12),  
  (_ce10)-[:NECESITA {cantidad:2, medida: "onzas"}]->(_sp1),
  (_ce11)-[:NECESITA {cantidad:6, medida: "onzas"}]->(_cp00),
  (_ce11)-[:NECESITA {cantidad:1, medida: "shots"}]->(_i11)
```
