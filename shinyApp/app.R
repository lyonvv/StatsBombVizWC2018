
library(shiny)

ui <- pageWithSidebar(
  headerPanel("World Cup 2018"),
  sidebarPanel(
    selectInput("Player", "Player:", c("Test" = "Test", "test2" = "test2"))
    
    
  ),
  mainPanel()
)

server <- function(input, output) {
  
}


shinyApp(ui, server)

