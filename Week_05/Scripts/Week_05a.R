### In class lecture for week 05 ####
### Created By: Jacquin Moraga ####
### Created On: 2025-9-23 ####

### Load Libraries ####
library(tidyverse)
library(here)
library(cowsay)

### Load Data ####
EnviroData<-read_csv(here("Week_05","Data", "site.characteristics.data.csv"))
                     
 TPCData<-read_csv(here("Week_05","data","Topt_data.csv"))
### Data Analysis ####

EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, # pivot the data wider
              values_from = values) %>%
  arrange(site.letter) # arrange the dataframe by site

FullData_left<- left_join(TPCData, EnviroData_wide)

data1 <- FullData_left %>%
  group_by(name) %>%
  summarize(mean_CCA = mean(CCA.cover, na.rm = TRUE),
            var_CCA = var(CCA.cover, na.rm = TRUE),
            mean_algal = mean(algal.cover, na.rm = TRUE),
            var_algal = var(algal.cover, na.rm = TRUE),
            mean_p.acuta = mean(p.acuta.cover, na.rm = TRUE),
            var_p.acuta = var(p.acuta.cover, na.rm = TRUE),
            mean_coral = mean(coral.cover, na.rm = TRUE),
            var_coral = var(coral.cover, na.rm = TRUE),
            mean_substrate = mean(substrate.cover, na.rm = TRUE),
            var_substrate = var(substrate.cover, na.rm = TRUE))
view(data1)

data2 <- FullData_left %>%
  drop_na() %>%
  group_by(name) %>%
  summarize(mean_E = mean(E),
            mean_Eh = mean(Eh),
            mean_lnc = mean(lnc),
            mean_Th = mean(Th),
            mean_Topt = mean(Topt))

T1 <- tibble(Site.ID = c("A", "B", "C", "D"),
             Temperature = c(14.1, 16.7, 15.3, 12.8))

T2 <- tibble(Site.ID = c("A", "B", "D", "E"),
             pH = c(7.3, 7.8, 8.1, 7.9))

left_join(T1, T2) #keeps the left data set and only adds what matches from the right
right_join(T1, T2) #keeps the right data set and only adds what matched from the left

inner_join(T1, T2) #only keeps what both data sets have

full_join(T1, T2) #keeps everything from both and combines it all

semi_join(T1, T2) #keeps rows that are the same but only the column from left data

anti_join(T1, T2) #only keeps the data from the left that doesn't match the right

say("whats up") #makes a cow say stuff
