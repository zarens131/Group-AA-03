library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)

ui <- fluidPage(
  page_one <- tabPanel("First Page",
  titlePanel("Sea Star Population"),
  "Question 1: Does the rising water temperatures along the Western Coast of the United
    States have any impact on the Sea Star population?"),
  sidebarLayout(
    sidebarPanel(
      # This is where "reactive output" comes into play ex: renderDataTable(),renderTable() etc.
    ),
    mainPanel(
      h3("Primary Content"),
      p("Plots, data tables, etc. would go here")
    )
  )
)
page_two <- tabPanel(
"Question 2: With recent numbers in Sea Star population dwindling, how will the shallow
    ecosystems be affected and how much will that change the ocean?"
)
page_three <- tabPanel(
  "Question 3: How does the population of the other animals in the ecosystem appear to affect the sea star population?"
  )
page_four <- tabPanel(
  "Question 4: Comparing the global warming temperatures to the general ecosystem where sea stars reside, is there a noticeable trend?"
  )
page_five <- tabPanel(
  "Question 5: What correlation is found between the sea level and heat maps from the following datasets."
  )
page_six <- tabPanel(
  "Map",
  titlePanel("Sea Star Population Map"),
  leafletOutput("mymap")
  )
page_seven <- tabPanel("Map",
  titlePanel("Sea Star Population Map"),
  leafletOutput("mymap")
  )
ui <- navbarPage(
  "My Application", # application title
  page_one,         # include the first page content
  page_two,         # include the second page content
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
    
  #return
}
  
shinyApp(ui = ui, server = server)
