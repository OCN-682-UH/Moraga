### Created By: Jacquin Moraga ####
### Created On: 2025-09-09 ####


## Load Libraries ####
library(ggplot2)
library(palmerpenguins)
library(tidyverse)



## Glimpse Data ####
glimpse(penguins)


ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species,
                     aplha = flipper_length_mm)) +
geom_point()+ 
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, Gentoo",
       x = "Bill depth (mm)", y = "Bill length (mm)",
       color = "Species",
       caption = "Source: Palmer Station")+ 
  scale_color_viridis_d()

