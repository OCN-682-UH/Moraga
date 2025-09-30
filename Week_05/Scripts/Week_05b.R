### Online Class Lecture for Week 05 ####
### Created By: Jacquin Moraga ####
### Created On: 2025-9-25 ####

### Load Libraries ####
library(tidyverse)
library(here)
library(lubridate)

### Load Data ####



### Data Analysis ####

ymd("2021-02-24")

mdy("02/04/2024")

mdy("February 24 2021")

dmy("24/02/2024")

ymd_hms("2021-02-24 10:22:20 PM")

mdy_hms("02/24/2021 22:22:20")

mdy_hm("February 24 2021 10:22 PM")

datetimes <- c("02/24/2024 22:22:20",
               "02/25/2024 11:21:10",
               "02/26/2024 8:01:20")

datetimes <- mdy_hms(datetimes)

month(datetimes) #tells you the month number

month(datetimes, label = TRUE) #tells you months by the first 3 letters

month(datetimes, label = TRUE, abbr = FALSE) #tells you month by full name

day(datetimes) #extract day

wday(datetimes, label = TRUE) #extract day of the week

hour(datetimes) #hours
minute(datetimes) #minutes
seconds(datetimes)# seconds

datetimes + hours(4) #can add on hours to a time if in the wrong time zone, need to use an "s" on the hours function

datetimes + days(2) #same but with days

round_date(datetimes, "minute") #rounds the datetimes database to the nearest minute

round_date(datetimes, "5 mins") #rounds to nearest 5 minutes
