# Week 06 Homework
Jacquin Moraga
2025-10-07

<script src="Week_06_homework_files/libs/kePrint-0.0.1/kePrint.js"></script>
<link href="Week_06_homework_files/libs/lightable-0.0.1/lightable.css" rel="stylesheet" />

## Welcome

Welcome to my Quarto document, made for the **Week 06** homework
assignment for the OCN 682 Class.

I will be using the **Maunalua Bay Chemical Data** for this assignment.

## Load Libraries

Here are the various libraries that I used in order to create my figures
and tables

``` r
library(tidyverse) #loads the libraries we are using
library(kableExtra)
library(here)
library(webshot2)
```

## Load Data

Here is where I loaded the data and renamed it to be **“MBay”**

``` r
MBay <- read_csv(here("Week_06", "Data", "chemicaldata_maunalua.csv")) #reads the csv file we are using and names it to a data sheet called "MBay"
```

Lets take a look at the data to see what were working with before we
start

``` r
glimpse(MBay) # looks at the beggining of the data sheet
```

    Rows: 355
    Columns: 15
    $ Waypoint    <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,…
    $ Zone        <chr> "Transition", "Transition", "Transition", "Transition", "D…
    $ Lat         <dbl> 21.27531, 21.27523, 21.27504, 21.27449, 21.27503, 21.27485…
    $ Long        <dbl> -157.7618, -157.7627, -157.7633, -157.7640, -157.7617, -15…
    $ Site        <chr> "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W"…
    $ Season      <chr> "SPRING", "SPRING", "SPRING", "SPRING", "SPRING", "SPRING"…
    $ Tide_time   <chr> "Low_Day", "Low_Day", "Low_Day", "Low_Day", "Low_Day", "Lo…
    $ Temp_in     <dbl> 23.75506, 23.53256, 22.63450, 24.01982, 23.26102, 24.00517…
    $ Salinity    <dbl> 27.74029, 30.61192, 28.37008, 32.82124, 29.12293, 34.02018…
    $ Phosphate   <dbl> 0.54, 0.36, 0.50, 0.25, 0.50, 0.13, 0.28, 0.15, 0.23, 0.11…
    $ Silicate    <dbl> 157.93, 92.59, 143.60, 42.32, 126.47, 15.04, 56.31, 23.10,…
    $ NN          <dbl> 7.92, 3.37, 7.29, 0.79, 7.45, 0.46, 1.59, 0.34, 1.91, 0.25…
    $ pH          <dbl> 7.909, 7.965, 8.023, 7.995, 8.005, 8.019, 8.003, 7.978, 7.…
    $ TA          <dbl> 2161.482, 2145.828, 2272.391, 2219.583, 2151.826, 2216.758…
    $ percent_sgd <dbl> 20.4043928, 11.9625323, 18.5529716, 5.4677003, 16.3397933,…

Looks beautiful, in this data set we will be specifically looking at:

- Salinity
- Submarine groundwater discharge (percent_sgd)
- Sample collection zones (Zones)
- Collection locations (Site)

Lets get started making that plot.

## Making a Plot

Here is where I will be making a plot using the data above.

``` r
MBay %>% #uses the MBay data sheet we made
  drop_na() %>% #gets rid of all NA values
  ggplot(aes(x = percent_sgd, y = Salinity, color = Zone)) + #creates a plot with percent sgd on the x axis and salinity on the Y. The colors of the plot are by zone
  geom_point(size = 1.5, alpha = .6) + #makes a point plot with adjusted point sizes
  facet_grid(~Site) + #makes a faceted plot that is split by Site
  labs( title = "Salinity near SGD in Maunalua Bay",
        x = "Percent Submarine Groundwater Discharge",
        y = "Salinity (ppt)",
        alpha = "Collection Zone") + #added titles and labels to different parts of the graph
  theme_light()+ #added the light theme
  theme(axis.title = element_text(size = 10),
        title = element_text(size = 15),
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 8)) #changed the text sizes for the titles
```

<div id="fig-salt">

<img src="../output/fig-salt-1.png" style="width:70.0%"
data-fig-align="center" />

Figure 1: This figure visualizes the salinity of the ocean water with
relation to surface groundwater percent.

</div>

When looking <a href="#fig-salt" class="quarto-xref">Figure 1</a> you
can see there is an inverse relationship between salinity and percent
surface groundwater discharge. It is also apparent that *Site W* has a
greater range of percent surface groundwater and a higher maximum
percent.

## Making a Table

Now lets make a cool looking table to go with the Plot that we made.

``` r
MBay %>% #uses the MBay data sheet
  drop_na() %>% #gets rid of all NA values
  group_by(Zone) %>% #grouping the data by Zonee
  summarize(Salinity_Mean = mean(Salinity, na.rm = TRUE), #creates a new column for Salinity and sgd with the mean of each per zone
            SGD_Mean = mean(percent_sgd, na.rm = TRUE)) %>%
  kbl() %>% #creates a kabel table
  kable_styling(full_width = FALSE) #limits the width of the table from being across the whole page
```

<div id="tbl-salt">

Table 1: This is a table showing the means of salinity and surface
groundwater discharge by collection zone

<div class="cell-output-display">

| Zone       | Salinity_Mean |  SGD_Mean |
|:-----------|--------------:|----------:|
| Ambient    |      34.59144 | 0.3073834 |
| Diffuse    |      34.08632 | 1.8315924 |
| Offshore   |      34.60565 | 0.2220069 |
| Transition |      33.09165 | 4.7882657 |

</div>

</div>

<a href="#tbl-salt" class="quarto-xref">Table 1</a> has information
showing the average salinity and percent submarine groundwater discharge
by collection zone in Maunalua Bay.
