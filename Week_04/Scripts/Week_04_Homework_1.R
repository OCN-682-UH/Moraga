### Homework 1 for Week 4 ####
### Created By: Jacquin Moraga ####
### Created On: 2025-9-16 ####

### Load Libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)

### Load Data ####
glimpse(penguins)


### Data Analysis ####

#Question_1

penguins%>% #uses the penguins data
  group_by(species)%>% #groups the following by species
  summarize(mean_body_mass = mean(body_mass_g, na.rm=TRUE), #creates the mean of body mass
            variance_body_mass = var(body_mass_g, na.rm=TRUE)) #creates the variance of body mass

penguins%>% #uses the penguins data
  group_by(island)%>% #groups the following by island
  summarize(mean_body_mass = mean(body_mass_g, na.rm=TRUE),#creates the mean of body mass
            variance_body_mass = var(body_mass_g, na.rm=TRUE)) #creates the variance of body mass

penguins%>% #uses the penguins data
  drop_na(sex)%>% #gets rid of the NA's in the "sex" column, prevents a third grouping under "NA"
  group_by(sex)%>% #groups the following by sex
  summarize(mean_body_mass = mean(body_mass_g, na.rm=TRUE),#creates the mean of body mass
            variance_body_mass = var(body_mass_g, na.rm=TRUE)) #creates the variance of body mass

#Question_2

penguins%>% #uses penguins data set
  filter(sex != "male")%>% #filters to exclude males and just have females
  mutate(log_mass = log(body_mass_g))%>% #creates a new column with the log of body mass
  select(species, island, sex, log_mass)%>% #selects these specific columns to have in the data
  ggplot(aes(x = island, y = log_mass,
             fill = island))+ #selects island for the x axis and log_mass for y and fills them with color
  geom_violin()+ #creates a violin plot
  labs(title = "Log Mass of Penguins",
       x = "Island",
       y = "Log Mass (g)")+ #gives titles to the axis and the entire plot
  theme_classic()+ #puts a theme on the plot
  guides(fill = FALSE) #gets rid of the unnecessary legend

ggsave(here("Week_04","Output","Homework_1.png"), #saves it as an image
       width = 5, height = 7)  #creates the size I want which is 5x7 inches

