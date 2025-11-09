
library(shiny)
library(here)
library(tidyverse)


chem <- read_csv("chemicaldata_maunalua.csv") #reading in the dataset

chem_new <- chem %>%
  pivot_longer(cols = c(Phosphate:NN), names_to = "nutrients", values_to = "concentrations")
#making longer columns and using the three nutrients, I would've used more but nothing has the concentration values so i figured these are all ppt or something

ui <- fluidPage( #need this for it to work

  selectInput("Nutrient", label ="Choose Nutrient", choices = unique(chem_new$nutrients)), #making a dropdown menu for the different nutrient options

  plotOutput("summary"), #connecting to the plot output with the name summary, I've changed it a couple times but kept the name bc I'm to afraid to change it and make it not work
  
  tableOutput("table") #same but for my table with the name table

)

server <- function(input, output, session) {
  
  output$summary <- renderPlot({# choosing a plot for my first output
    filtered_chem <- chem_new %>% 
      filter(nutrients == input$Nutrient) #filtering the plot to just be from the options of the dropdown menu
    
    ggplot(filtered_chem, aes(x = Zone, y = concentrations, fill = Season)) +
      geom_boxplot() +
      facet_wrap(~Season, scales = "free_y") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") #made a boxplot with boxes by zone and faceted for season, learned fow to angle x axis text for a better read
    
  })
  
  output$table <-renderTable({ #making a table, originally tried to make a kable table but I couldn't figure it out so maybe will try again another time
    chem%>%
      summarize(Salinity_mean = mean(Salinity, na.rm = TRUE),
                Phosphate_mean = mean(Phosphate, na.rm = TRUE),
                Silicate_mean = mean(Silicate, na.rm = TRUE),
                NN_mean = mean(NN, na.rm = TRUE),
                pH_mean = mean(pH, na.rm = TRUE),
                Total_alkalinity_mean = mean(TA, na.rm = TRUE),
                SGD_Mean = mean(percent_sgd, na.rm = TRUE)) #made a table as my second output that provides the means of all the different variables in thr dataset, wanted to include all of them becuase I can
  })
}

shinyApp(ui = ui, server = server) #need this for it to work
