library(shiny)

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
  "Question 6: When comparing sea level and the oceans ecosystem populations, is there a noticeable trend?"
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
  
  #return
}
  
shinyApp(ui = ui, server = server)
