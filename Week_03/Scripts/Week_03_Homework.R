### Plotting a new penguin graph for homework ####
### Created By: Jacquin Moraga ####
### Created On: 2025-9-15 ####

### Load Libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)

### Load Data ####
glimpse(penguins)

### Data Analysis Section ####

ggplot(data = penguins, #choosing the penguins data for this plot
       mapping = aes(x = species,
                     y = body_mass_g))+ #selected the variables that I wanted to plot for x and y
  geom_boxplot(aes(color = species), #added a boxplot to visualize the data and changed the color to be by species
               outlier.shape = NA)+ #got rid of the outliers since the jitter shows all the data
    geom_jitter(aes(color = species))+ #added a jitter plot on top to show all the data, matched the color with the species
  labs(title = "Penguin Species Mass Distribution", #created a title for the plot
       subtitle = "Who is the chonkiest?", #made a subtitle for the plot
       x ="Species", y = "Body Mass (g)")+ #renamed the x and y axis
  theme_light()+                     #added the "light" theme for aesthetics
  theme(axis.title = element_text(size = 15))+ #makes the axis titles larger
  guides(color = FALSE) #removes the legend since there is no need for one
 
ggsave(here("Week_03","Output","Week_03_Homework.png"), #saves the plot to the correct folder
       width = 5, height = 7) #changes the shape so it doesn't look as fat

