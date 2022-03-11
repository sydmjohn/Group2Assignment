library(shiny)
library(quantmod)
library(shinydashboard)
library(ggplot2)
library(tidyquant)
library(fpp3)
library(ggthemes)


start <- as.Date("2008-01-01")
end <- as.Date("2022-01-01")
stocks <- tq_get(c("AAPL", "SPG", "FB", "GOOG","AMD","TDOC"), from= start, to= end)
library(shiny)

ui <- dashboardPage(
  
  dashboardHeader(title="Stock Price Fluctuation"),
  dashboardSidebar(),
  
  dashboardBody(
    selectInput("select", 
                label= h3("Select Company"), 
                choices = list("AAPL"= "AAPL", 
                               "SPG" = "SPG", 
                               "FB" = "FB", 
                               "GOOG"= "GOOG", 
                               "AMD" = "AMD", 
                               "TDOC" = "TDOC"), 
                selected= "AAPL"), 
    
    hr(), 
    plotOutput("fig2"))
  
  
)
server <- function(input, output){
  output$fig2 <- renderPlot(
    stocks %>% filter(symbol == input$select) %>% 
      ggplot(aes(x = date,y = close)) + 
      geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
      labs(title = "Stock Analysis",
           y = "Price", x = "") +
      coord_x_date(xlim = c(start,end)) +
      theme_economist_white()
  )
}

shinyApp(ui,server)

