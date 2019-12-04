heat_plot <- function() {
  file <- read.csv("docs/ocean-heat_fig-1.csv", stringsAsFactors = FALSE)
  ocean_heat <- ggplot(file, aes(x = Year, y = NOAA)) +
    geom_bar(stat="identity", position=position_dodge(), fill = "darkred")+
    theme_minimal()
  
  return(ocean_heat)
}

# geom_text(aes(label = NOAA), vjust = 1.6, size = 1.5) <--- NOT NEEDED