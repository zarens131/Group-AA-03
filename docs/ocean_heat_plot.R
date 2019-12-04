heat_plot <- function(year1 = 1955, year2 = 2015) {
  file <- read.csv("docs/ocean-heat_fig-1.csv",
                   stringsAsFactors = FALSE)

  bar_plot <- ggplot(file, aes(x = Year, y = NOAA)) +
    geom_point() +
    geom_ribbon(aes(ymax = NOAA, ymin = NOAA),
                fill = "yellow",
                alpha = 0.5) +
    geom_line(aes(x = Year, y = NOAA, color = "Ocean Heat")) +
    scale_color_manual(values = c("darkred", "blue")) +
    scale_y_continuous(breaks = seq(-7, 17, 2)) +
    ylab("NOAA")
  
  bar_plot <- bar_plot +
    xlim(year1, year2)
  return(bar_plot)
}
  
# ocean_heat <- ggplot(file, aes(x = Year, y = NOAA)) +
#     geom_bar(stat = "identity", position = position_dodge(), fill = "darkred")+
#     theme_minimal()
#     
#   ocean_heat <- ocean_heat +
#     xlim(year1, year2)
#     
#   return(ocean_heat)
#   
#   # geom_text(aes(label = NOAA), vjust = 1.6, size = 1.5) <--- NOT NEEDED 
# 
