
## Importamos las librerías que nos interesasn
library(tidyverse)
library(sf)
library(glue)
library(leaflet)
library(leaflet.extras)
library(htmlwidgets)

## Hay que estar en la carpeta code análysis
#setwd("analysis/code/")

bandama_especies <- read_sf("../data/bandama_especies.shp") %>%
  st_transform( crs = 4326) %>%
  select(-n)

## Procesamos los datos nos intersa resumir en el sentido de que
## pasamos a tener las especies de unas cuadrículas en una celda de 
## DataFrame separadas con el operador de HTML <br> para la etiqueta de la WEB
perfect_bandama_esp <- bandama_especies %>%
  group_by(geometry) |>
  summarise(especies = paste0(glue("<i>{specie}</i>"), collapse = "<br>> "),
            n = n())

## Características de los colores del mapa de calor
bins <- c(1, 2, 4, Inf)
pal_perfect_bandama_esp <- colorBin("YlOrRd", domain = perfect_bandama_esp$n, bins = bins)

mapa <- leaflet() %>%
  setView(-15.455, 28.03, zoom = 16) %>%
  addProviderTiles("Esri.WorldImagery") %>%
    addPolygons(
      data = perfect_bandama_esp,
      fillColor = ~pal_perfect_bandama_esp(n),
      color = "transparent",
      dashArray = "3",
      popup = paste0("<p style='text-align:left;'>",
                     "<br><strong>Vegetación del lugar 🌱️</strong>", 
                     "<br>----------------------------------", 
                     glue("<br> <strong>Número de especies nativas en total: <u>{perfect_bandama_esp$n}</u></strong>"),
                     glue("<br>> {perfect_bandama_esp$especies}"),
                     "</p>") |> 
                lapply(htmltools::HTML),
              popupOptions = labelOptions(
                style = list("font-weight" = "normal",
                             padding = "3px 8px"),
                textsize = "10px",
                direction = "auto"
              ),              
              highlightOptions = highlightOptions(weight = 5,
                                                  color = "#666",
                                                  fillOpacity = .7,
                                                  dashArray = "",
                                                  bringToFront = FALSE),
              weight = 0, fillOpacity = .9,
              group = "Especies Protegidas") %>% 
  addResetMapButton() %>%
  addScaleBar("bottomleft", scaleBarOptions(metric = TRUE, imperial = FALSE))

saveWidget(mapa, file = "../../index.html", title = "Riqueza de especies")
