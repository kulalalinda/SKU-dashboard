# Define UI 


library(tidyverse)
library(lubridate)
current_period <<- floor_date((Sys.Date()), "month")-months(3) # current month 

ui=shinyUI(pageWithSidebar(
  
  
  
  # Application title
  
  headerPanel("Unconstraint Forecast Decomposition"),
  
 
  
  # Sidebar with controls to select the dataset and forecast ahead duration
  
  sidebarPanel(
    # lst.measures <- as.list(unique(full_sales$forecast_item)),
    # market_choices <- lst.measures,
    selectInput("variable","ID:",
                choices =  unique(full_sales$forecast_item)),
                # select=forecast_item),
                # choices = c("RO: 191522 MAALOX 2 DC 400-400MG TAB BL4X10 RO" =  "191522",
                #             "RO: 212815 IBALGIN SPORT 2.5G/+ CREAM TB1 M24 RO" = "212815")),
    # selectInput("market", "Market: ",c("RO")),
                
                # list("AMARYL 2MG TAB BL15 M36" = "191522", 
                #      
                #      "PLAVIX 75MG TABCO BL7 M35" = "PLAVIX",
                #      
                #      "COAPRO 150-12.5MG TAB BL7 M35" = "COAPRO",
                #      
                #      "APROVEL 150MG TABCO BL7 M35" = "APROVEL")),
                # 
    numericInput("ahead", "Months to Forecast Ahead:", 12),
    
    
    
    submitButton("Run")
    
  ),
  
  
  
  
  
  
  
  # Show the caption and forecast plots
  
  mainPanel(
    
    h3(textOutput("caption")),
    
    
    
    tabsetPanel(
      
      # tabPanel("Exponetial Smoothing (ETS) Forecast", plotOutput("etsForecastPlot")), 
      # 
      # tabPanel("Arima Forecast", plotOutput("arimaForecastPlot")),
      
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
    
    paste("Dataset: ", input$variable)
    
  })
  
  
  
  output$dcompPlot <- renderPlot({
    
    ds_ts <- ts(hist_ts_onesku(), frequency=12)
    
    f <- decompose(ds_ts)
    
    plot(f)
    
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




