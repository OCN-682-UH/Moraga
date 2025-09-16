### Created By: Jacquin Moraga ####
### Created On: 2025-09-09 ####

### Load Libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggthemes)

### Load Data ####
glimpse(penguins)

## Data Analysis Section ####
plot1 <- ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species))+
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill Depth (mm)",
       y = "Bill Length (mm)")+
  scale_color_viridis_d()+
  scale_x_continuous(breaks = c(14,17,21),
                     labels = c("low", "medium", "high"))+
  scale_color_manual(values = c("orange", "purple", "green"))+ 
  theme_classic()+ 
  theme(axis.title = element_text(size = 20,
                                  color = "red"),
        panel.background = element_rect(fill = "linen"))
ggsave(here("Week_03","Output","da_penguin.png" ),
       width = 7, height = 5)

plot1
