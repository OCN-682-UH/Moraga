### This is my first script. I am learning how to import data ####
### Created By: Jacquin Moraga ####
### Created On: 2025-9-6 ####


### Load Libraries #####
library(tidyverse)
library(here)


### Read In Data ####
Weightdata <- read.csv(here("Week_02" , "Data", "weightdata.csv"))


### Data Analysis ####
head(Weightdata) # looks at the top 6 lines of the data
tail(Weightdata) # looks at the bottom 6 lines of the data
View(Weightdata) # looks at the entire dataframe in a new window
