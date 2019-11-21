# install.packages('ggplot2')
library(ggplot2)

file <- read.csv('docs/ocean-heat_fig-1.csv', stringsAsFactors = FALSE)

bar_plot <- ggplot(file, aes(x = Year, y = NOAA)) +
  geom_bar(stat="identity", position=position_dodge(), fill = "darkred")+
  geom_text(aes(label = NOAA), vjust = 1.6, size = 1.5) +
  theme_minimal()
bar_plot
