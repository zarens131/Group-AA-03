## 11/20/2019 GROUP AA03, PROJECT SEA STAR
library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)
library(shinythemes)
library(ggvis)
library(tidyr)
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
        h3("Technology"),
        p("Each visualization is a unique interactable map that displays data in a creative way. 
          Clicking on the dots will provide information that correlates to the image shown on the map. 
          The drop-down list is a simple time frame that lapses over our data sets years. 
          The sliding bars are used to show large amounts of data and to hone in on the requested 
          time frames over the decades shown in the later questions.")
      ),
      mainPanel(leafletOutput("starfish_map")) #displays interactive map
    ),
    mainPanel(
      h3("Conclusion Statement"),
      p("Our group has found a sudden and rapid change in the sea star population from 2010 to 2017, even possibly the present.
        What we have found that could lead to such a drastic change are 
        global ecosystem issues that definently have correlation.
        We cannot conclude whether the ecosystems are negatively or 
        positively affected by the rising of sea levels and ocean temperature.
        However, we can conclude that this drastic affect from global warming 
        has changed the ecosystem to negatively impact certain populations like the sea star.
        Understanding correlations and recognizing a huge problem within our world is an important step towards our goals as researchers. 
        Even though we have not reached a definite conclusion to the issue at hand. 
        We have smaller conclusions such as recognizing the main problem, finding correlations between data on 
        commonly known world issues, and finding a lack of data that can be expanded upon. Essentially, 
        we can improve the researching field of sea star population data 
        by being the first to organize such a nuanced and scattered issue.")
    )
  )
)

page_one <- tabPanel(
  "Question 1", titlePanel(
    "Are the sea star population of the west coast currently being affected by a change in their ecosystem?"),
  sidebarLayout(
    sidebarPanel(
      h3("Navigation Bar"),
      selectInput("year", label = "Year:", choices =
                    list("2007", "2008", "2009", "2010", "2011", "2012",
                         "2013", "2014", "2015", "2016", "2017"),
                  selected = "2007")
    ),
    mainPanel(leafletOutput("map_interact"))
  ),
  h3("Research Questions and Findings"),
  mainPanel(
    p("Absolutely. We estimate that sometime during 2010 to 2011 that sea star populations rapidly began to spread and ultimately decline.
      The sea star populations, based on our data from up to 2017, have scattered into four laid (points) on our project data page. ")
  )
)
page_two <- tabPanel(
  "Question 2", titlePanel(
    "Comparing the global warming temperatures to the general
  ecosystem where sea stars reside, is there a noticeable trend?"),
  titlePanel("Ocean Heat Graph"),
  sidebarLayout(
    sidebarPanel(
      h3("Navigation Bar"),
      sliderInput("heat_slider", label = "Year Range:", min = 1955,
                  max = 2015, value = c(1955, 2015))
    ),
    mainPanel(plotOutput("bar_plot"))
  ),
  h3("Research Questions and Findings"),
  mainPanel(
    p("Yes, there has been a sudden and very rapid decline in the sea star population 
      that we can estimate happened around 2010 to 2011 based on our datasets. 
      This leads our group findings to associate the change in the ecosystem to affect a 
      certain predator thriving or a lack of food within the studied ecosystem.")
  )
)
page_three <- tabPanel(
  "Question 3", titlePanel(
    "What correlation is found between the sea level
  and heat maps from the following datasets?"),
  titlePanel("Sea Level Graph"), #displays banner title
  sidebarLayout(
    sidebarPanel(
      h3("Navigation Bar"),
      sliderInput("level_slider", label = "Year Range:", min = 1880,
                  max = 2015, value = c(1880, 2015))
    ),
    mainPanel(plotOutput("sealevels"))
  ),
  h3("Research Questions and Findings"),
  mainPanel(
    p("Our group findings concluded that there is a correlation between the sea level 
    from question 3 and the surface heat map from question 2. 
    From at least the mid 1950's, there has been a rising temperature spike 
    and sea level spike that has affected the oceans ecosystems drastically over the decades. ")
  )
)
page_four <- tabPanel(
  "About Us",
  mainPanel(
    h3("Group Members -"), 
    #all placeholder text for read me file info on group
    sidebarPanel(
      p("Nicholas (Coder):"),
    ),
    mainPanel(
      p("Being Interested in the data trends between global warming and the sea star population. 
        Nicholas chose the role of leading coding efforts, 
        problem solving, and organizing the essential functions used to complete our data graphs.")
    ),
    sidebarPanel(
      p("Zach (Thinker):"),
    ),
    mainPanel(
      p("Being interested in how the sea star population has struggled to adapt to global warming. 
        Zach chose to fill the role of leading the team's organizational efforts. 
        Such as group meetings, organizing and writing the technical document, 
        and ensuring or briefing the group members on the projects situation.")
    ),
    sidebarPanel(
      p("Arya (Innovator):"),
    ),
    mainPanel(
      p("Being interested in human influence towards the sea star population. 
        Arya took on the task of leading our research efforts, 
        challenging difficult scenarios in our project, and bringing new ideas to the table.")
    ),
    mainPanel(
      h3("Link to Technical Document: "),
      p("https://github.com/zarens131/Group-AA-03/wiki/Sea-Star-Technical-Document")
    )
  )
)
ui <- navbarPage(
  theme = shinytheme("superhero"), "Project Sea Star", # application title
  main_page, #creates main page
  page_one, #creates other tab pages
  page_two,
  page_three,
  page_four
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
    heat_plot(year1_heat(), year2_heat())
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
  year1_heat <- reactive({
    input$heat_slider[1]
  })
  year2_heat <- reactive({
    input$heat_slider[2]
  })
  #return
}
shinyApp(ui = ui, server = server)