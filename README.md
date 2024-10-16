# Cuadrículas para cálculo de abundancia/riqueza de especies

La idea es crear capas de los Espacios Naturales Protegidos (ENP) con Cuadrículas para: calcular la abundancia y riqueza de especies en las cuadrículas marcadas, cargarlas en el IGN y determinar zonas donde fotografiar especies.

El tamaño de las los espacios naturales protegidos y las cuadrículas puede seleccionarse según convenencia:

## Ejemplo práctico del WorkFlow :

### 1. Selección de los ENP

Para seleccionar los ENP de Bandama y Jinámar en el archivo [workflow.ipynb](workflow.ipynb):

* Celda de *código* del Jupyter nº **<u>7</u>**
* Seleccionar el código del ENP <i>(<strong>C-**</strong>)</i>, en el caso de Bandama C-14 y Jinámar C-29 

```
## Selecciona los ENP que quieras generar cuadrículas
enp_seleccion = [
  "C-14",       # = Jinámar
  "C-29"        # = Bandama 
  ]

enp_seleccionado = enps_gran_canaria_procesado[enps_gran_canaria_procesado["codigo"].isin(enp_seleccion)]

## Tabla de Espacios que has seleccionado para generar cuadrículas
enp_seleccionado
```

### 2. Selección del tamaño de las cuadrículas

Posteriormente, para seleccionar el tamaño de las cuadrículas en el archivo [workflow.ipynb](workflow.ipynb):

* Celda de *código* del Jupyter nº **<u>9</u>**
* Seleccionar el número de cuadrículas en ```m2 = metros_cuadrados = *```
* Ejemplo de 50 x 50 m (cuadrículas de 2500 m<sup>2</sup>)

```
m2 = metros_cuadrados = 50

os.makedirs("results/", exist_ok=True)

for codigo in enp_seleccionado["codigo"].unique():
    enp_unico = enp_seleccionado[enp_seleccionado["codigo"] == codigo]
    enp_grid = crear_cuadriculas(enp_unico, m2)
    enp_grid = enp_grid[enp_grid.intersects(enp_unico.unary_union)]
    enp_grid.to_file(f"results/{codigo}.kml", driver='KML')
```