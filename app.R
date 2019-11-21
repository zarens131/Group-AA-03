## 11/20/2019 GROUP AA03, PROJECT SEA STAR
library(shiny)
library(dplyr)
library(ggplot2)
<<<<<<< HEAD

=======
library(leaflet)
library(shinythemes)
#Loading libraries...
>>>>>>> 3b046024c94dbdaba490a1503e3709b9354b2c3a
ui <- fluidPage(
  #mainPanel() seems to not properly display the "Project Data" label.
  #Therefore, we will use tabPanel().
  main_page <- tabPanel(
    "Project Data", #displays tab label
    titlePanel("Sea Star Population"), #displays page title
    leafletOutput("mymap"), #displays interactive map
    sidebarPanel(
      h3("Navigation Bar") #placeholder text for nav bar
    ),
    sidebarPanel(
      h3("Research & Background"),
      p("Research & Background summary")
    ),
    sidebarPanel(
      h3("Visual Controls/Key"), #placeholder visual controls and/or key
      p("brief statement on key")
    )
  )
)

page_one <- tabPanel(
  "Question 1", titlePanel(
  "Are the rising water temperatures along the Western Coast of the United
  States having an impact on the Sea Star population?"),
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
  plotOutput("bar_plot"),
  p("Sea level temperature bar graph"),
  sidebarPanel(
    h3("Research Findings")
  ),
  sidebarPanel(
    h3("Visual Controls/Key") #placeholder for viz controls and/or key
  ),
  sidebarPanel(
    p("Nav bar") #placeholder text for nav bar
  )
)

page_five <- tabPanel(
  "Question 5", titlePanel(
    "What correlation is found between the sea level
  and heat maps from the following datasets?"),
  h2("Research Questions and findings"),
  titlePanel("Sea Level Graph"), #displays banner title
  plotOutput("sealevels"), #displays sealevels bar graph
  sidebarPanel(
    h3("Research Findings")
  ),
  sidebarPanel(
    h3("Visual Controls/Key") #placeholder for viz controls and/or key
  ),
  sidebarPanel(
    p("Nav bar") #placeholder text for nav bar
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
<<<<<<< HEAD

=======
  data1 <- read.csv("docs/project_data_set_1.csv", stringsAsFactors = FALSE)
  data1_as_date <- data1
  data1_as_date$Date <- as.Date(data1_as_date$Date, "%m/%d/%Y")
  data1_yearly <- read.csv("docs/project_data_set_1_yearly.csv",
                           stringsAsFactors = FALSE)
  data1_year_month <- read.csv("docs/project_data_set_1_monthly.csv",
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
  #creates sealevels graph
  sea_levels <- read.csv("docs/sea-level_fig-1.csv",
                         stringsAsFactors = FALSE) #reads csv
  #constructs plot graph and converts to UI from server in shiny
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
  #creates ocean heat viz
  file <- read.csv('docs/ocean-heat_fig-1.csv', stringsAsFactors = FALSE) #reads csv
  #constructs viz and converts to UI from server in shiny
  output$bar_plot <- renderPlot({
    bar_plot <- ggplot(file, aes(x = Year, y = NOAA)) +
      geom_bar(stat="identity", position=position_dodge(), fill = "darkred")+
      geom_text(aes(label = NOAA), vjust = 1.6, size = 1.5) +
      theme_minimal()
    bar_plot
  })
>>>>>>> 3b046024c94dbdaba490a1503e3709b9354b2c3a
  #return
}
shinyApp(ui = ui, server = server)