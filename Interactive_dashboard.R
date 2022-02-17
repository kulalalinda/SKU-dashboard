# Define UI 
# load("C:/Dashboard/interactive dashboard/full_SALES_PL.Rdata")
source("get_data.R")
load("simulation_data.RData")


library(tidyverse)
library(lubridate)
current_period <<- floor_date((Sys.Date()), "month") # current month 

ui=shinyUI(pageWithSidebar(
  
  
  
  # Application title
  
  headerPanel("Unconstraint Time Series Decomposition"),
  
 
  
  # Sidebar with controls to select the dataset and forecast ahead duration
  
  sidebarPanel(
    # lst.measures <- as.list(unique(full_sales$forecast_item)),
    # market_choices <- lst.measures,
    selectInput("variable","ID:",
                choices =  unique(full_sales$forecast_item)),

                # 
    numericInput("ahead", "Months to Forecast Ahead:", 12),
    
    
    
    submitButton("Run")
    
  ),
  
  
  
  
  
  
  
  # Show the caption and forecast plots
  
  mainPanel(
    
    h3(textOutput("caption")),
    
    
    
    tabsetPanel(
      
      
      
      tabPanel("Timeseries Decomposition", plotOutput("dcompPlot"))
      
    )
    
  )
  
))

library(shiny)

library(datasets)


library(forecast)
# source("./function/get_data.R")


server=shinyServer(function(input, output){
  
  # Combine the selected variables into a new data frame  
get_data(current_period)
   
 hist_ts_onesku<-reactive({
   # res = as.numeric(gsub(".*?([0-9]+).*", "\\1", market_choices[[1]])) 
     # if (input$variable== ID)
     #   
     # {
       
       hist_ts[[gsub(".*?([0-9]+).*", "\\1", input$variable)]]
       
     # } 
   # else {
   #     
   #     return(hist_ts[["212815"]])
   #  
   #   }
                      
  }) 
 
  
  output$caption <- renderText({
    
    paste("Forecast Item: ", input$variable)
    
  })
  
  
  
  output$dcompPlot <- renderPlot({
    
    # ds_ts <- ts(hist_ts_onesku(), frequency=12)
    
    # f <- decompose(ds_ts)
    
    plot(decompose(hist_ts_onesku()))
    
  })
  
  
  
  
  # output$arimaForecastPlot <- renderPlot({
  #   
  #   fit <- auto.arima(getDataset())
  #   
  #   plot(forecast(fit, h=input$ahead))
  #   
  # })
  # 
  
  
  # output$etsForecastPlot <- renderPlot({
  #   
  #   fit <- ets(getDataset())
  #   
  #   plot(forecast(fit, h=input$ahead))
  #   
  # })
  # 
  # 
  
})

shinyApp(ui = ui, server = server)




