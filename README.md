# Cuadrículas para cálculo de abundancia/riqueza de especies

La idea es crear capas de los Espacios Naturales Protegidos (ENP) con Cuadrículas para: calcular la abundancia y riqueza de especies en las cuadrículas marcadas, cargarlas en el IGN y determinar zonas donde fotografiar especies.

El tamaño de las los espacios naturales protegidos y las cuadrículas puede seleccionarse según convenencia:

## Ejemplo práctico del WorkFlow :

### 1. Selección de los ENP

Para seleccionar los ENP de Bandama y Jinámar en el archivo [workflow.ipynb](workflow.ipynb):

* Celda de *código* del Jupyter nº **<u>10</u>**
* Seleccionar el código del ENP <i>(<strong>C-**</strong>)</i>, en el caso de Bandama C-14 y Jinámar C-29 

```
## Selecciona los ENP que quieras generar cuadrículas, ej: Jinámar
enp_seleccion = "C-29"   

enp_seleccionado = enps_gran_canaria_procesado[enps_gran_canaria_procesado["codigo"].isin(enp_seleccion)]

## Tabla de Espacios que has seleccionado para generar cuadrículas
enp_seleccionado
```

### 2. Selección del tamaño de las cuadrículas

Posteriormente, para seleccionar el tamaño de las cuadrículas en el archivo [workflow.ipynb](workflow.ipynb):

* Celda de *código* del Jupyter nº **<u>13</u>**
* Seleccionar el número de cuadrículas en ```m2 = tamanio_cuadriculas = x```
* Ejemplo de 50 x 50 m (cuadrículas de 2500 m<sup>2</sup>)

```
tamanio = tamanio_cuadriculas = 50

grid_selected = crear_cuadriculas(grid_filtrado, tamanio)
enp_grid = grid_selected[grid_selected.intersects(enp_seleccionado.unary_union)]
enp_grid["cuadricula"] = ["cuadricula-" + str(i) for i in range(1,(len(enp_grid) + 1),1)]
enp_grid.to_file(f"results/{enp_seleccion}.shp")
```