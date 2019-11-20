# install.packages('dplyr')
library(dplyr)
# install.packages('ggplot2')
library(ggplot2)

# read data from file

data1 <- read.csv('docs/project_data_set_1.csv', stringsAsFactors = FALSE)



data1_as_date <- as.Date(data1, )