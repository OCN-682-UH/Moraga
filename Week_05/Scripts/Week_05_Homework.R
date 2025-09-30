### Homework for Week 05 ####
### Created By: Jacquin Moraga ####
### Created On: 2025-9-29 ####

### Load Libraries ####
library(tidyverse)
library(here)
library(lubridate)

### Load Data ####
Cond <- read_csv(here("Week_05","Data","CondData.csv")) #reads in the conductivity data
Depth<-read_csv(here("Week_05","data","DepthData.csv")) #reads in the depth data

view(Cond) #these help take a look at what the data is that I'll be working with
head(Cond)
view(Depth)
head(Depth)

### Data Analysis ####

Data_party <- Cond %>% #making a new dataframe using the Cond data
  mutate(date = round_date(mdy_hms(date), "10 seconds")) %>% #using mutate to create a new column with the correct date, naming it "date"
                                                              #in the previous line I also rounded it to the nearest 10 seconds and converted it into the proper format at the same time
  inner_join(Depth, by = "date") %>% #used the inner_join function to combine the Cond data and the Depth data by date and only keeping what both share, anything not shared is excluded
  mutate(date = round_date(date, unit = "minute")) %>% #once they are joined I rounded the dates to the nearest minute rather than second
  mutate(day = round_date(date, unit = "day")) %>% #used mutate to create a new column for just day so I could take the average date, was a little confused why we need average day but trying to follow the homework instructions
  group_by(date) %>% #grouping everything by the date column which is now rounded to the minute to average everything
  summarise(
    avg_depth = mean(Depth, na.rm = TRUE), #making a column for average depth by the date rounded to the minute
    avg_temperature = mean(Temperature, na.rm = TRUE), #same as above for temp
    avg_salinity = mean(Salinity, na.rm = TRUE), #same as above for salinity
    avg_date = mean(day, na.rm = TRUE)) #same as above for date
    

ggplot(data = Data_party, #using my new dataset with the means of the values
       mapping = aes(x = date,
                     y = avg_temperature,
                     alpha = avg_depth)) + #set the x and y axis and added another dimension of depth through the alpha function
  geom_point(aes(color = avg_temperature), #made the color based on the temperature
             show.legend = TRUE)+ #added a legend for depth, removed the legend for temperature later
  scale_color_gradient(low = "blue",
                       high = "red")+ #made a gradient for the coloration of temperature
  labs(title = "Average Temperature on 01/15/21",
       x = "Time (hr)",
       y = "Average Temperature (C)",
       alpha = "Depth (m)")+ #added titles to the plot, axis, and the legend
  guides(color = FALSE)+ #got rid of the temperature legend
  theme_grey()+ #slapped on a good ol theme
  theme(axis.title = element_text(size = 10),
        title = element_text(size = 15),
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 8)) #played around with the sizes of the different tiles to get it how I liked

# I know that this part is not piped to the rest but it was making my dataset weird if I tried to save the csv earlier in the script

ggsave(here("Week_05","Output","Homework_5.png"), #saves my plot to my output folder in week 5
       width = 5, height = 7) #saves at a width of 5 and height of 7

write.csv(here("Week_05","Data","Summarized_Data_Homework_5.csv")) #saves the dataframe as a csv in the data folder in week 5
