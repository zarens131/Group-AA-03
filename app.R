## 11/20/2019 GROUP AA03, PROJECT SEA STAR
library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)
library(shinythemes)
#Loading libraries...
ui <- fluidPage(
  #mainPanel() seems to not properly display the "Project Data" label
  main_page <- tabPanel(
    "Project Data", titlePanel("Sea Star Population"),
    leafletOutput("mymap")) #displays interactive map
)

page_one <- tabPanel(
  "Question 1", titlePanel("Are the rising water temperatures along the Western Coast of the United
    States having an impact on the Sea Star population?")
)
page_two <- tabPanel(
  "Question 2", titlePanel(
    "With recent numbers in Sea Star population dwindling, how will the shallow 
  ecosystems be affected and how will the effects change the ocean?")
)
page_three <- tabPanel(
  "Question 3", titlePanel(
    "How does the population of the other animals in the 
    ecosystem appear to affect the sea star population?")
)
page_four <- tabPanel(
  "Question 4", titlePanel(
    "Comparing the global warming temperatures to the general 
    ecosystem where sea stars reside, is there a noticeable trend?")
)
page_five <- tabPanel(
  "Question 5", titlePanel(
    "What correlation is found between the sea level 
    and heat maps from the following datasets?")
)
page_six <- tabPanel(
  "Question 5",
  titlePanel("Sea Level Graph"),
  plotOutput("sealevels")
)
page_seven <- tabPanel(
  "Question 6", titlePanel(
    "When comparing sea level and the oceans ecosystem populations, 
    is there a noticeable trend?")
)

ui <- navbarPage(
  theme = shinytheme("superhero"), "Project Sea Star", # application title
  main_page,         # include the first page content
  page_one,         # include the second page content
  page_two,
  page_three,
  page_four,
  page_five,
  page_six
)
server <- function(input, output) {
  # output$ {call variable <-}
  data1 <- read.csv('docs/project_data_set_1.csv', stringsAsFactors = FALSE)
  
  data1_as_date <- data1
  
  data1_as_date$Date <- as.Date(data1_as_date$Date, "%m/%d/%Y")
  
  data1_yearly <- read.csv('docs/project_data_set_1_yearly.csv',
                           stringsAsFactors = FALSE)
  
  data1_year_month <- read.csv('docs/project_data_set_1_monthly.csv',
                               stringsAsFactors = FALSE)
  
  data1_by_year_df <- data1_yearly %>%
    filter(Year == "2007")
  
  data1_year_total_starfish <- data1_by_year_df %>%
    group_by(Site) %>%
    summarize(sum = sum(Count))
  
  popup_map <- paste(sep = "<br/>",
                     paste("Site: ", data1_year_total_starfish$Site, sep = ""),
                     paste("Starfish Population: ",
                           data1_year_total_starfish$sum, sep = ""))
  
  output$mymap <- renderLeaflet({
    leaflet(data = data1_by_year_df) %>%
      addTiles() %>%
      addCircleMarkers(lat = ~Lat,
                       lng = ~Long,
                       popup = popup_map,
                       stroke = FALSE, fillOpacity = 0.5)
  })
  
  sea_levels <- read.csv('docs/sea-level_fig-1.csv',
                         stringsAsFactors = FALSE)
  
  output$sealevels <- renderPlot({
    ggplot(data = sea_levels, aes(x = Year, y = level)) +
      geom_line(aes(x = Year, y = level, color = "Sea Level")) +
      geom_point() +
      geom_ribbon(aes(ymax = level + interval, ymin = level - interval),
                  fill = "grey70",
                  alpha = 0.5) +
      geom_line(aes(x = Year, y = zero, color = "Normal Sea Level at 1880")) +
      scale_color_manual(values = c("black", "red")) +
      scale_x_continuous(breaks = seq(1880, 2020, 20)) + 
      scale_y_continuous(breaks = seq(0, 12, 2))
  })
  
  #return
}

shinyApp(ui = ui, server = server)
