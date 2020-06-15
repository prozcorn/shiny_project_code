#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = 3 + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
  
  output$velocity_input <- renderUI({
      numericInput('v','Velocity',value=0)
  })
  output$angle_input <- renderUI({
      numericInput('theta','Angle (In degrees from horizontal)',value=0)
  })
  output$initial_h_input <- renderUI({
      numericInput('h0','Initial Height From Ground',value=0)
  })
  output$max_h_input <- renderUI({
      numericInput('hm','Max Height From Ground',value=0)
  })
  output$max_h_t_input <- renderUI({
      numericInput('tm','Time To Max Height',value=0)
  })
  output$max_t_input <- renderUI({
      numericInput('tt','Total Time Traveled In Air',value=0)
  })
  output$range <- renderUI({
        numericInput('xm','Total X distance',value=0)
  })
  
  unknown_stuff <- eventReactive(input$button,{
    if (input$Unknown == '1'){
      paste('Velocity is ',toString(as.numeric(input$xm)/(as.numeric(input$tt)*cos(as.numeric(input$theta)*pi/180))),'m/s')
    }
    else if (input$Unknown == '2'){
      paste('Angle is ',toString(round(acos(as.numeric(input$xm)/(as.numeric(input$tt)*as.numeric(input$v))),2)),' degrees')
    }
    else if (input$Unknown == '3'){
      paste('Initial height is ',toString(as.numeric(input$hm)-as.numeric(input$v)*sin(as.numeric(input$theta)*pi/180)+.5*9.8*
        as.numeric(input$v)*sin(as.numeric(input$theta)*pi/180)/9.8),'m')
    }
    else if (input$Unknown == '4'){
      paste('Max height is ',toString(as.numeric(input$h0)+as.numeric(input$v)*sin(as.numeric(input$theta)*pi/180)-
        .5*9.8*as.numeric(input$v)*sin(as.numeric(input$theta)*pi/180)/9.8),'m')
    }
    else if (input$Unknown == '5'){
      paste('Time to max height is ',toString(as.numeric(input$v)*sin(as.numeric(input$theta)*pi/180)/9.8),'s')
    }
    else if (input$Unknown == '6'){
      paste('Total airtime is ',toString(as.numeric(input$xm)/(as.numeric(input$v)*cos(as.numeric(input$theta)*pi/180))),'s')
    }
    else if (input$Unknown == '7'){
      paste('Total range is ',toString(as.numeric(input$v)*cos(as.numeric(input$theta)*pi/180)*as.numeric(input$tt)),'m')
    }
  })
  output$unknown_value <- renderText(unknown_stuff())
  
})