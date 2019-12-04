map_interact <- function(year = "2007") {
  data2 <- read.csv("docs/project_data_set_1.csv", stringsAsFactors = FALSE)
  
  data2_as_date <- data2
  
  data2_as_date$Date <- as.Date(data2_as_date$Date, "%m/%d/%Y")
  
  data2_yearly <- read.csv("docs/project_data_set_1_yearly.csv",
                           stringsAsFactors = FALSE)
  
  data2_year_month <- read.csv("docs/project_data_set_1_monthly.csv",
                               stringsAsFactors = FALSE)
  
  data2_by_year_df <- data2_yearly %>%
    filter(Year == year)
  
  data2_year_total_starfish <- data2_by_year_df %>%
    group_by(Site) %>%
    summarize(sum = sum(Count))
  
  data2_by_year_df <- inner_join(data2_by_year_df,
                                 data2_year_total_starfish, by = "Site")
  
  popup_map <- paste(sep = "<br/>",
                     paste("Site: ", data2_by_year_df$Site, sep = ""),
                     paste("Starfish Population: ",
                           data2_year_total_starfish$sum, sep = ""))
  
  map2 <- leaflet(data = data2_by_year_df) %>%
    addTiles() %>%
    addCircles(lat = ~Lat,
               lng = ~Long,
               radius = ~sum * 50,
               popup = popup_map,
               fillOpacity = 0.1)
  
  return(map2)
}