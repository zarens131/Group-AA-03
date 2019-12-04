heat_plot <- function(year1 = 1955, year2 = 2015) {
  file <- read.csv("docs/ocean-heat_fig-1.csv",
                   stringsAsFactors = FALSE)

   ocean_heat <- ggplot(file, aes(x = Year, y = NOAA)) +
     geom_bar(stat = "identity", position = position_dodge(),
              fill = "darkred") +
       theme_minimal()

     ocean_heat <- ocean_heat +
       xlim(year1, year2)

     return(ocean_heat)

}
