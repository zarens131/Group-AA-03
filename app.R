## 11/20/2019 GROUP AA03, PROJECT SEA STAR
library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)
library(shinythemes)
library(ggvis)
#Loading libraries...
ui <- fluidPage(
  #mainPanel() seems to not properly display the "Project Data" label.
  #Therefore, we will use tabPanel().
  main_page <- tabPanel(
    "Project Data", #displays tab label
    titlePanel("Sea Star Population"), #displays page title
    br(),
    sidebarLayout( 
      sidebarPanel(
        h3("Research Findings") #placeholder text for nav bar
      ),
      mainPanel(leafletOutput("starfish_map")) #displays interactive map
    )
  )
)

page_one <- tabPanel(
  "Question 1", titlePanel(
    "Are the rising water temperatures along the Western Coast of the United
  States having an impact on the Sea Star population?"),
  h2("Research Questions and findings"),
  sidebarLayout(
    sidebarPanel(
      h3("Navigation Bar"),
      selectInput("year", label = "Year:", choices =
                    list("2007", "2008", "2009", "2010", "2011", "2012",
                         "2013", "2014", "2015", "2016", "2017"),
                  selected = "2007")
    ),
    mainPanel(leafletOutput("map_interact"))
  )
)

page_two <- tabPanel(
  "Question 2", titlePanel(
    "With recent numbers in Sea Star population dwindling, how will the shallow
  ecosystems be affected and how will the effects change the ocean?"),
  h2("Research Questions and findings"),
  sidebarPanel(
    h3("Visual") #placeholder for viz
  ),
  sidebarPanel(
    p("Research Findings")
  ),
  sidebarPanel(
    p("Nav bar") #placeholder text for nav bar
  )
)

page_three <- tabPanel(
  "Question 3", titlePanel(
    "How does the population of the other animals in the
  ecosystem appear to affect the sea star population?"),
  sidebarPanel(
    h3("Visual") #placeholder for viz
  ),
  sidebarPanel(
    p("Research Findings")
  ),
  sidebarPanel(
    p("Nav bar") #placeholder text for nav bar
  )
)

page_four <- tabPanel(
  "Question 4", titlePanel(
    "Comparing the global warming temperatures to the general
  ecosystem where sea stars reside, is there a noticeable trend?"),
  titlePanel("Ocean Heat Graph"),
  plotOutput("bar_plot"),
  h2("Research Questions and Findings"),
  sidebarLayout(
    sidebarPanel(
      h3("Navigation Bar"),
      sliderInput("level_slider", label = "Year Range:", min = 1955,
                  max = 2015, value = c(1955, 2015))
    ),
    mainPanel(plotOutput("oceanheat"))
  )
)

page_five <- tabPanel(
  "Question 5", titlePanel(
    "What correlation is found between the sea level
  and heat maps from the following datasets?"),
  h2("Research Questions and findings"),
  titlePanel("Sea Level Graph"), #displays banner title
  sidebarLayout(
    sidebarPanel(
      h3("Navigation Bar"),
      sliderInput("level_slider", label = "Year Range:", min = 1880,
                  max = 2015, value = c(1880, 2015))
    ),
    mainPanel(plotOutput("sealevels"))
  )
)

page_six <- tabPanel(
  "Question 6",
  h3("When comparing sea level and the oceans 
     ecosystem populations, is there a noticeable trend?"),
  sidebarPanel(
    h3("Visual") #placeholder for viz
  ),
  sidebarPanel(
    p("Research Findings")
  ),
  sidebarPanel(
    p("Nav bar") #placeholder text for nav bar
  )
)
page_seven <- tabPanel(
  "Conclusion",
  sidebarPanel(
    h3("Navbar") #placeholder text for nav bar
  ),
  mainPanel(
    h3("Conclusion Statement"),
    p("Conclusion Statement Paragraphs")
  ),
  sidebarPanel(
    h3("Images") #placeholder text for images
  )
)
page_eight <- tabPanel(
  "About Us",
  mainPanel(
    h3("Group Members"), 
    #all placeholder text for read me file info on group),
    sidebarPanel(
      p("Group member:"),
      p("Explanation")
    ),
    sidebarPanel(
      p("Group member:"),
      p("Explanation")
    ),
    sidebarPanel(
      p("Group member:"),
      p("Explanation")
    )
  )
)

ui <- navbarPage(
  theme = shinytheme("superhero"), "Project Sea Star", # application title
  main_page, #creates main page
  page_one, #creates other tab pages
  page_two,
  page_three,
  page_four,
  page_five,
  page_six,
  page_seven,
  page_eight
)

server <- function(input, output) {
  # output$ {call variable <-}
  source('docs/starfish_map_1.R')
  output$starfish_map <- renderLeaflet({
    starfish_map()
  })
  #creates interactive map
  source("docs/starfish_map_2.R")
  output$map_interact <- renderLeaflet({
    map_interact(year())
  })
  #creates sealevels graph
  source('docs/sea_level_plot.R')
  #constructs plot graph and converts to UI from server in shiny
  output$sealevels <- renderPlot({
    sea_level(year1_level(), year2_level())
  })
  #creates ocean heat viz
  source('docs/ocean_heat_plot.R')
  #constructs viz and converts to UI from server in shiny
  output$bar_plot <- renderPlot({
    heat_plot()
  })
  year <- reactive({
    input$year
  })
  year1_level <- reactive({
    input$level_slider[1]
  })
  year2_level <- reactive({
    input$level_slider[2]
  })
  
  #return
}
shinyApp(ui = ui, server = server)