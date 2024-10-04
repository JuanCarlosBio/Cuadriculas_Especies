library(tidyverse)
library(sf)
library(glue)
library(leaflet)
library(leaflet.extras)
library(htmlwidgets)

bandama_especies <- read_sf("../data/bandama_especies.shp") %>%
  select(-n)

perfect_bandama_esp <- bandama_especies %>%
  group_by(geometry) |>
  summarise(especies = paste0(glue("<i>{specie}</i>"), collapse = "<br>> "),
            n = n())

bins <- c(1, 2, 4, 6, Inf)
pal_perfect_bandama_esp <- colorBin("YlOrRd", domain = perfect_bandama_esp$n, bins = bins)

leaflet() %>%
  setView(-15.455, 28.03, zoom = 16) %>%
  addProviderTiles("Esri.WorldImagery") %>%
    addPolygons(
      data = perfect_bandama_esp,
      fillColor = ~pal_perfect_bandama_esp(n),
      color = "transparent",
      dashArray = "3",
      popup = paste0("<p style='text-align:left;'>",
                     "<br><strong>Especies Nativas del lugar</strong>", 
                     "<br>======================", 
                     glue("<br>==> <strong>Número de especies protegidas en total: <u>{perfect_bandama_esp$n}</u></strong>"),
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

saveWidget(map, file = "index.html")
