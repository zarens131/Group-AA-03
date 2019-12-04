# install.packages('ggplot2')
library(ggplot2)

file <- read.csv('docs/ocean-heat_fig-1.csv', stringsAsFactors = FALSE)

bar_plot <- ggplot(file, aes(x = Year, y = NOAA)) +
            geom_line(aes(x = Year, y = NOAA, color = "Ocean Heat")) +
            geom_point() +
            geom_ribbon(aes(ymax = Year + interval, ymin = Year - interval),
                        fill = "grey70",
                        alpha = 0.5) +
            geom_line(aes(x = Year, y = zero, color = "Normal Ocean Heat at 1955")) +
            scale_color_manual(values = c("black", "darkred")) +
            scale_x_continuous(breaks = seq(1955, 2015, 20))+ 
            scale_y_continuous(breaks = seq(0, 12, 2))
