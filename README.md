# Cuadrículas para cálculo de abundancia/riqueza de especies.

La idea es crear capas de los Espacios Naturales Protegidos (ENP) con Cuadrículas para: calcular la abundancia y riqueza de especies en las cuadrículas marcadas, cargarlas en el IGN y determinar zonas donde fotografiar/anotar especies.

El tamaño de las los espacios naturales protegidos y las cuadrículas puede seleccionarse según convenencia:

Para ello se usarán los siguientes datos Públicos:

* SHP Red de Espacios Naturales Protegidos proporcionados en los [Datos Públicos de la institución SITCAN](https://opendata.sitcan.es/). 
* Mallas terrestres geográficas [REGCAN95 de 1 x 1 Km](https://www.miteco.gob.es/es/biodiversidad/servicios/banco-datos-naturaleza/informacion-disponible/bdn-cart-aux-descargas-ccaa.html#UTM).

## Ejemplo práctico del WorkFlow:

### 1. Selección de los ENP.

Para seleccionar los ENP de Bandama y Jinámar en el archivo [workflow.ipynb](workflow.ipynb):

* Celda de *código* del Jupyter nº **<u>10</u>**.
* Seleccionar el código del ENP <i>(<strong>C-**</strong>)</i>, en el caso de Bandama C-14.

```
## Selecciona los ENP que quieras generar cuadrículas, ej: Jinámar
enp_seleccion = "C-14"   

enp_seleccionado = enps_gran_canaria_procesado[enps_gran_canaria_procesado["codigo"].isin(enp_seleccion)]

## Tabla de Espacios que has seleccionado para generar cuadrículas
enp_seleccionado
```

### 2. Selección del tamaño de las cuadrículas.

Posteriormente, para seleccionar el tamaño de las cuadrículas en el archivo [workflow.ipynb](workflow.ipynb):

* Celda de *código* del Jupyter nº **<u>13</u>**.
* Seleccionar el número de cuadrículas en ```tamanio = tamanio_cuadriculas = x```.
* Ejemplo de 100 x 100 m.

```
tamanio = tamanio_cuadriculas = 100

grid_selected = crear_cuadriculas(grid_filtrado, tamanio)
enp_grid = grid_selected[grid_selected.intersects(enp_seleccionado.unary_union)]
enp_grid["cuadricula"] = ["cuadricula-" + str(i) for i in range(1,(len(enp_grid) + 1),1)]
enp_grid.to_file(f"results/{enp_seleccion}.shp")
```

### 3. Superposición con fotografías referenciadas.

Tengo algunas especies nativas (no protegidas) fotorrerenciadas de la Caldera de Bandama.

Se pueden usar varias herramientas para combinar las cuadrículas con las coordenadas de las imágenes, las más comunes son QGIS y ArcGis.

En este caso he creado un HTML con R/Python para mostrar un análisis reproducible con los pasos necesarios en este lenguaje a partir de código abierto ([capeta de analysis](analysis/)), y que cualquiera que queira realizar el suyo propio pueda intentarlo.

Visita la [WEB](https://juancarlosbio.github.io/Cuadriculas_Especies/) que he hecho para ver el resultado de ejemplo.