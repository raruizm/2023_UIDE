# MAPA CORDOBA
library(tidyverse)
library(osmdata)
library(sf)
library(ggmap)

# https://dominicroye.github.io/en/2018/accessing-openstreetmap-data-with-r/
# https://wiki.openstreetmap.org/wiki/Map_features
# https://wiki.openstreetmap.org/wiki/ES:Objetos_del_mapa


getbb ("quito ecuador")

streets <- getbb("quito ecuador")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "trunk", "primary", 
                            "secondary", "tertiary")) %>%
  osmdata_sf()

small_streets <- getbb("quito ecuador")%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street")) %>%
  osmdata_sf()

river <- getbb("quito ecuador")%>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

schools <- getbb("quito ecuador")%>%
  opq()%>%
  add_osm_feature(key = "amenity", value = "school") %>%
  osmdata_sf()


getbb ("quito ecuador")

ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .8) +
  coord_sf(xlim = c(-78.6, -78.4),
           ylim = c(-0.40, -0.05),
           expand = FALSE)




################

# ggplot() +
#   geom_sf(data = streets$osm_lines,
#           inherit.aes = FALSE,
#           color = "steelblue",
#           size = .4,
#           alpha = .8) +
#   geom_sf(data = small_streets$osm_lines,
#           inherit.aes = FALSE,
#           color = "black",
#           size = .4,
#           alpha = .6) +
#   geom_sf(data = river$osm_lines,
#           inherit.aes = FALSE,
#           color = "black",
#           size = .2,
#           alpha = .5) +
#   coord_sf(xlim = c(-4.9, -4.7),
#            ylim = c(37.85, 37.92),
#            expand = FALSE)
#   # theme_void()
# 
# ggplot() +
#   geom_sf(data = streets$osm_lines,
#           inherit.aes = FALSE,
#           color = "#7fc0ff",
#           size = .4,
#           alpha = .8) +
#   geom_sf(data = small_streets$osm_lines,
#           inherit.aes = FALSE,
#           color = "#ffbe7f",
#           size = .2,
#           alpha = .6) +
#   geom_sf(data = river$osm_lines,
#           inherit.aes = FALSE,
#           color = "#ffbe7f",
#           size = .2,
#           alpha = .5) +
#   coord_sf(xlim = c(-4.9, -4.7),
#            ylim = c(37.85, 37.92),
#            expand = FALSE) +
#   theme_void() +
#   theme(
#     plot.background = element_rect(fill = "#282828")
#   )


ggplot() +
  # Calles
  geom_sf(data = streets$osm_lines, inherit.aes = FALSE, color = "#ffbe7f", size = .4, alpha = .8) +
  # Pequeñas calles
  geom_sf(data = small_streets$osm_lines, inherit.aes = FALSE, color = "#ffbe7f", size = .1, alpha = .5) +
  # Ríos
  geom_sf(data = river$osm_lines, inherit.aes = FALSE, color = "#7fc0ff", size = 1.5, alpha = .8) +
  # Límites del mapa en coordenadas
  coord_sf(xlim = c(-78.6, -78.4),
           ylim = c(-0.40, -0.05),
           expand = FALSE) +
  theme_void() + 
  # Añadir color de fondo
  theme(plot.background = element_rect(fill = "#282828"))

ggplot() +
  # Calles
  geom_sf(data = streets$osm_lines, inherit.aes = FALSE, color = "#ffbe7f", size = .4, alpha = .8) +
  # Pequeñas calles
  geom_sf(data = small_streets$osm_lines, inherit.aes = FALSE, color = "#ffbe7f", size = .2, alpha = .6) +
  # Ríos
  geom_sf(data = river$osm_lines, inherit.aes = FALSE, color = "#7fc0ff", size = 1.5, alpha = .8) +
  # Torrentes
  geom_sf(data = stream$osm_lines, inherit.aes = FALSE, color = "#7fc0ff", size = .5, alpha = .6) +
  # # Colegios
  # geom_sf(data = schools$osm_polygons, inherit.aes = FALSE, fill= NA, color = "brown1", size = 0.5, alpha = .8) +
  # # Fuentes
  # geom_sf(data = fuentes$osm_points, inherit.aes = FALSE, fill= NA, color = "cyan", size = 0.5, alpha = .8) +
  # # Bares
  # geom_sf(data = bares$osm_points, inherit.aes = FALSE, fill= NA, color = "cyan", size = 0.5, alpha = .8) +
  # Torrentes
  geom_sf(data = lineas_bus$osm_lines, inherit.aes = FALSE, color = "cyan", size = .5, alpha = .6) +
  # Límites del mapa en coordenadas
  coord_sf(xlim = c(-4.83, -4.74), ylim = c(37.84, 37.94), expand = FALSE) +
  theme_void() + 
  # Añadir color de fondo
  theme(plot.background = element_rect(fill = "#282828"))

ggsave("maplineasdebus.png", 
       dpi = 600,
       width = 4.5, height = 6
       )
