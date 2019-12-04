# install.packages('ggplot2')
library(ggplot2)

file <- read.csv('docs/ocean-heat_fig-1.csv', stringsAsFactors = FALSE)

bar_plot <- ggplot(file, aes(x = Year, y = NOAA)) +
            geom_point() +
            geom_ribbon(aes(ymax = NOAA, ymin = NOAA),
                        fill = "yellow",
                        alpha = 0.5) +
            geom_line(aes(x = Year, y = Year, color = "Ocean Heat")) +
            scale_color_manual(values = c("darkred", "blue")) +
            scale_y_continuous(breaks = seq(-7, 17, 2))
            ylab("NOAA")
            
            