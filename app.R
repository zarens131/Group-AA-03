library(shiny)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  page_one <- tabPanel("First Page",
  titlePanel("Sea Star Population"),
  "Question 1"),
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
"Question 2"
)
page_three <- tabPanel(
  "Question 3"
  )
page_four <- tabPanel(
  "Question 4"
  )
page_five <- tabPanel(
  "Question 5"
  )
page_six <- tabPanel(
  "Question 6"
  )
ui <- navbarPage(
  "Project Sea Star", # application title
  page_one,         # include the first page content
  page_two,         # include the second page content
  page_three,
  page_four,
  page_five,
  page_six
)
server <- function(input, output) {
  # output$ {call variable <-}

  #return
}
  
shinyApp(ui = ui, server = server)
