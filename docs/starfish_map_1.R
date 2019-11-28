starfish_map <- function(year = "2007") {
  data1 <- read.csv("docs/project_data_set_1.csv", stringsAsFactors = FALSE)
  
  data1_as_date <- data1
  
  data1_as_date$Date <- as.Date(data1_as_date$Date, "%m/%d/%Y")
  
  data1_yearly <- read.csv("docs/project_data_set_1_yearly.csv",
                           stringsAsFactors = FALSE)
  
  data1_year_month <- read.csv("docs/project_data_set_1_monthly.csv",
                               stringsAsFactors = FALSE)
  
  data1_by_year_df <- data1_yearly %>%
    filter(Year == year)
  
  data1_year_total_starfish <- data1_by_year_df %>%
    group_by(Site) %>%
    summarize(sum = sum(Count))
  
  data1_by_year_df <- inner_join(data1_by_year_df,
                                 data1_year_total_starfish, by = "Site")
  
  popup_map <- paste(sep = "<br/>",
                     paste("Site: ", data1_year_total_starfish$Site, sep = ""),
                     paste("Starfish Population: ",
                           data1_year_total_starfish$sum, sep = ""))
  
  map1 <- leaflet(data = data1_by_year_df) %>%
    addTiles() %>%
    addCircles(lat = ~Lat,
                     lng = ~Long,
                     radius = ~sum * 50,
                     popup = popup_map,
               fillOpacity = 0.1)
  
  return(map1)
}