heat_plot <- function(year1 = 1955, year2 = 2015) {
  file <- read.csv("docs/ocean-heat_fig-1.csv",
                   stringsAsFactors = FALSE)
  
  ocean_heat <- ggplot(file, aes(x = Year, y = NOAA)) +
    geom_point() +
    geom_ribbon(aes(ymax = NOAA, ymin = NOAA),
                fill = "yellow",
                alpha = 0.5) +
    geom_line(aes(x = Year, y = NOAA, color = "Ocean Heat")) +
    scale_color_manual(values = c("darkred", "blue")) +
    scale_y_continuous(breaks = seq(0, 12, 2)) +
    ylab("NOAA")
  
  sea_level_plot <- sea_level_plot +
    xlim(year1, year2)
  
  return(ocean_heat)
}

