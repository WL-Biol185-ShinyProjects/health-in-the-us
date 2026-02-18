library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("outputstates.csv"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("BarByState")
    )
  )
)
