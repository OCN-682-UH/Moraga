### Homework 2 for Week 4 ####
### Created By: Jacquin Moraga ####
### Created On: 2025-9-23 ####

### Load Libraries ####
library(tidyverse)
library(here)

### Load Data ####
ChemData <- read.csv(here("Week_04","Data","chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

ChemData_Better <- ChemData %>% #assigning my new datasheet
  drop_na() %>% #getting rid of NAs
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_")%>% #separated the Tide_time column into "Tide" and "Time" and separated by "_"
  unite(col = "Coordinates",
        c(Lat,Long),
        sep = ",") %>% #put together the Lat and Long Columns and have the values separated by ","
  pivot_longer(cols = Phosphate:pH,#Made the dataset longer by making the columns Phosphate through pH into rows
               names_to = "Chemistry",
               values_to = "Numbers") #named the new columns "Chemistry" and "Numbers"

  ChemData_Better %>% #chose the new dataset
  ggplot(aes(x = Chemistry,
             y = Numbers))+ #plotted with the Chemistry column on the x axis and Numbers on the y axis
  geom_point(aes(color = Chemistry))+ #created a point plot and made it color coded by Chemistry value
    labs(title = "Groundwater Fun",
         x = "Chemistry",
         y = "Values")+ #renames the titles of the plot and the axis
    theme_light()+ #gave it a theme
    guides(color = FALSE) #got rid of the legend since we don't need it
  
  ggsave(here("Week_04","Output","Homework_2.png")) #saved the plot as an image in the right folder
  
  ChemData_Better%>% #selected my new dataset
  group_by(Chemistry)%>% #grouped values by the new Chemistry column
  summarize(Mean_Numbers = mean(Numbers, na.rm = TRUE)) %>% #took the mean of each of these values
    write.csv(here("Week_04","Output","Homework_2.csv")) #exported the summary as a csv file into the correct folder
