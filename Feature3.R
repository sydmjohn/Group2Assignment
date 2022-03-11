library(shiny)
library(tidyquant)
library(quantmod)
start<- as.Date("2017-01-01")
end <- as.Date("2022-03-01")
STOCK10 <- c("BRK-A", "LDSVF", "NXGPF", "AMZN", "SEB", "NVR", "BKNg", "MKL", "MRF", "GOOGL")
TOP10STOCKS <- tq_get(STOCK10, from = start, to = end)


ui <- fluidPage( 
  
  sidebarPanel(
    radioButtons("radio", label = h3("Select Top Company"),
                 choices = 
                   c("BRK-A", "LDSVF", "NXGPF", "AMZN", "SEB", "NVR", "BKNg", "MKL", "MRF", "GOOGL")),
    dateInput("date", label = h3("Stock Date"), value = "2021-01-01")
  ),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
)

server <- function(input, output, session) {
  output$value <- renderPrint( 
    ({ TOP10STOCKS$close[which(TOP10STOCKS$date == input$date &
                                 TOP10STOCKS$symbol == input$radio)]
      
    })
    
  )
}

shinyApp(ui = ui, server = server)
