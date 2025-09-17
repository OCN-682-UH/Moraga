### Created By: Jacquin Moraga #####
### Created On: 2025-9-16 ####

### Load Libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)

### Load Data ####
glimpse(penguins)
head(penguins)

### Data Analysis ####

filter(.data = penguins, #tells where to pull data from
       body_mass_g > "5000", # the actual function, can put in "" if a number or leave by itself
       year == 2008) #using a comma makes it execute both filters

filter(.data = penguins,
       year %in% c(2008,2009), # now selecting for the either the years 2008 or 2009
                              #you need to use c() when selecting more than one thing
       island != "Dream", #and selecting for islands that aren't Dream
       species %in% c("Adelie","Gentoo")) #and selecting for species "Adelie" and "Gentoo"

data2<-mutate(.data = penguins, #adds a column of data, THIS IS HOW TO DO CALCULATIONS IN THE DATA
       body_mass_kg = body_mass_g/100, #named new column "body_mass_kg", consists of the mass in g divided by 100
       bill_length_depth = bill_length_mm/bill_depth_mm)

view(data2)

data3<-mutate(.data = penguins,
       chonk = flipper_length_mm+body_mass_g, #creates a new column with mutate
       big_chonk = ifelse(body_mass_g>4000, "big", "small")) #creates conditional column saying if greater its "big" and smaller its "small"

view(data3)

data4<- penguins%>% #using penguins data
  group_by(island)%>% #grouping everything by island
  summarize(mean_flipper = mean(flipper_length_mm, na.rm=TRUE), #creating a column called "mean_flipper" which calculates the mean of all flippers,
                                                                # na.rm=TRUE is telling to remove all NA's from the mean calculation, this is nessecary
            min_flipper = min(flipper_length_mm, na.rm = TRUE)) #creates column for min flipper length telling the minimum flipper length per island

view(data4)

data5<- penguins%>%
  drop_na(sex)%>%  #removes all the NA's from the "sex" column permanently
  ggplot(aes(x = sex, y = flipper_length_mm))+
  geom_boxplot()

