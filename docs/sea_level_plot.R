sea_level <- function(year1 = 1880, year2 = 2015) {
  sea_levels <- read.csv("docs/sea-level_fig-1.csv",
                         stringsAsFactors = FALSE)

  sea_level_plot <- ggplot(data = sea_levels, aes(x = Year, y = level)) +
    geom_line(aes(x = Year, y = level, color = "Sea Level")) +
    geom_point() +
    geom_ribbon(aes(ymax = level + interval, ymin = level - interval),
                fill = "grey70",
                alpha = 0.5) +
    geom_line(aes(x = Year, y = zero, color = "Normal Sea Level at 1880")) +
    scale_color_manual(values = c("black", "red")) +
    scale_y_continuous(breaks = seq(0, 12, 2)) +
    ylab("Level (M)")

  sea_level_plot <- sea_level_plot +
    xlim(year1, year2)

  return(sea_level_plot)
}
