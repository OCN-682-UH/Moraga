### Online class for Week 4 ####
### Created By: Jacquin Moraga ####
### Created On: 2025-9-22 ####

### Load Libraries ####
library(tidyverse)
library(here)

### Load Data ####
ChemData <- read.csv(here("Week_04","Data","chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

ChemData_Clean <- ChemData %>%
  drop_na() %>% #gets rid of the NAs
  separate(col = Tide_time, #choses the column to seperate
           into = c("Tide", "Time"), #new column names
           sep = "_", #separates by the _
           remove = FALSE) %>%
  unite(col = "Site Zone",
        c(Site,Zone),
        sep = ".",
        remove = FALSE)
head(ChemData_Clean)

ChemData_Long <- ChemData_Clean %>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values")
ChemData_Long%>%
  group_by(Variables, Site) %>%
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE))

ChemData_Long %>%
  ggplot(aes(x = Site,
             y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free")

ChemData_Wide <- ChemData_Long %>%
  pivot_wider(names_from = "Variables",
              values_from = "Values")

ChemData_Extra_Clean <- ChemData %>%
  drop_na() %>%
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") %>%
  group_by(Variables, Site, Time) %>%
  summarize(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>%
  write_csv(here("Week_04", "Output", "summary.csv"))
  
