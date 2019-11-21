# install.packages('dplyr')
library(dplyr)
# install.packages('ggplot2')
library(ggplot2)
# install.packages('leaflet')
library(leaflet)

# read data from file

data1 <- read.csv('docs/project_data_set_1.csv', stringsAsFactors = FALSE)

data1_as_date <- data1

data1_as_date$Date <- as.Date(data1_as_date$Date, "%m/%d/%Y")

data1_yearly <- read.csv('docs/project_data_set_1_yearly.csv',
                         stringsAsFactors = FALSE)

data1_year_month <- read.csv('docs/project_data_set_1_monthly.csv',
                             stringsAsFactors = FALSE)

data1_by_year <- function(year) {
  data1_by_year_df <- data1_yearly %>%
    filter(Year == year)
  
  data1_year_total_starfish <- data1_by_year_df %>%
    group_by(Site) %>%
    summarize(sum = sum(Count))
  
  popup_map <- paste(sep = "<br/>",
                     paste("Site: ", data1_year_total_starfish$Site, sep = ""),
                     paste("Starfish Population: ",
                           data1_year_total_starfish$sum, sep = ""))
  
  leaflet(data = data1_by_year_df) %>%
    addTiles() %>%
    addCircleMarkers(lat = ~Lat,
                     lng = ~Long,
                     popup = popup_map,
                     stroke = FALSE, fillOpacity = 0.5)
  
}


data1_by_month <- function(year) {
  data1_by_month_df <- data1_yearly %>%
    filter(Year == year)
  
  data1_year_total_starfish <- data1_by_year_df %>%
    group_by(Site) %>%
    summarize(sum = sum(Count))
  
  popup_map <- paste(sep = "<br/>",
                     paste("Site: ", data1_year_total_starfish$Site, sep = ""),
                     paste("Starfish Population: ",
                           data1_year_total_starfish$sum, sep = ""))
  
  leaflet(data = data1_by_year_df) %>%
    addTiles() %>%
    addCircleMarkers(lat = ~Lat,
                     lng = ~Long,
                     popup = popup_map,
                     stroke = FALSE, fillOpacity = 0.5)
  
}

