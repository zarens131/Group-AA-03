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
        p("Each visualization is a unique interactive map that creatively displays data. 
          Clicking on the dots will provide information that defines the image shown on the map. 
          The drop-down list, in Question1 tab, is a simple time frame demonstrates a time-lapse of 
          the data sets across years. The sliding bars, on Questions 2 and 3 tabs, are used to display 
          data points over time.  The slide bar allows the user the ability to hone in on a specified time frame. 
          Users can vary the time span from years to decades based on interest.")
      ),
      mainPanel(leafletOutput("starfish_map")) #displays interactive map
    ),
    mainPanel(
      h3("Conclusion Statement"),
      p("Our group has found a sudden and rapid change in the sea star population from 2010 to 2017. 
      The data indicates the change maybe continuing to the present. 
      The group findings indicate a possibility of serious changes that could correlate 
      to changes in the global ecosystem. We cannot conclude whether the ecosystems are 
      negatively or positively affected by the noted rise of sea levels and ocean temperature. 
      However, we can conclude that the noted effect of global warming has changed the ecosystem to 
      negatively impact certain populations like the sea star. Understanding correlations and recognizing 
      a noticeable problem within our world is an important step towards our goals as researchers. 
      We have established a set of base conclusions, including recognition of the main problem, 
      finding correlations between data with commonly known world issues, and discovering a data 
      void that can be further expanded. Essentially, we can improve the sea star knowledgebase by 
      being the first to organize such a nuanced and scattered issue.")
    )
  )
)

page_one <- tabPanel(
  "Question 1", titlePanel(
    "Is the sea star population of the West Coast currently being affected by a change in their ecosystem?"),
  sidebarLayout(
    sidebarPanel(
      h3("Navigation Bar"),
      selectInput("year", label = "Year:", choices =
                    list("2007", "2008", "2009", "2010", "2011", "2012",
                         "2013", "2014", "2015", "2016"),
                  selected = "2007")
    ),
    mainPanel(leafletOutput("map_interact"))
  ),
  h3("Research Questions and Findings"),
  mainPanel(
    p("Our group agrees that the sea star population of the West Coast is affected by their ecosystem. 
      We estimate that some time from 2010 to 2011 sea star populations rapidly began to spread and then went 
      into decline Based on our data the population has scattered into four laid (points) as seen on our project data page.")
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
    p("Yes, there has been a sudden and very rapid decline in the sea star population between 2010 to 2011 based on our datasets. 
      This data leads our group to conclude changes in the ecosystem have affected sea stars. 
      Environment changes might include a predator thriving or a lack of food within the studied ecosystem.")
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
    p("Our group findings concluded that there is a correlation between the sea level from question 3 
      and the surface heat map from question 2. From at least the mid-1950s, 
      there has been a rising temperature and sea level spike that has affected 
      the oceans' ecosystems drastically over the decades.")
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
      p("Being Interested in the data trends between global warming and the sea
      star population. Nicholas chose the role of leading coding efforts,
      problem solving, and organizing the essential functions used to complete
      our data graphs.")
    ),
    sidebarPanel(
      p("Zach (Thinker):"),
    ),
    mainPanel(
      p("Being interested in how the sea star population has struggled to adapt to global warming, 
      Zach chose to lead the team's organizational efforts. His work included structuring group meetings, 
      organizing and writing the technical document, and briefing the group members on the situation of the project.")
    ),
    sidebarPanel(
      p("Arya (Innovator):"),
    ),
    mainPanel(
      p("Being interested in human influence on the sea star population, Arya took on the task of leading our research efforts, 
        challenging difficult scenarios in our project, and bringing new ideas to the table.")
    ),
    mainPanel(
      h3("Link to Technical Document: "),
      a("Document", href =
  "https://github.com/zarens131/Group-AA-03/wiki/Sea-Star-Technical-Document")
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