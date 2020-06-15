#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Solving A Simple Parabolic Motition Problem. Select Your Unknown Value, Enter The Known Values That You Are Asked For Then Hit Calculate To Get The Uknown Value."),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       radioButtons("Unknown",
                   "What are you solving for",
                   choices = list("Velocity" = 1,
                                  "Angle (from horizontal)" = 2,
                                  "Initial Height From Ground" = 3,
                                  "Max Height From Ground" = 4,
                                  "Time To Max Height" = 5,
                                  "Total Time Traveled In Air" = 6,
                                  'Total X distance' = 7))
       ,
        conditionalPanel(condition = 'input.Unknown != "1"', uiOutput("velocity_input"))
       ,conditionalPanel(condition = 'input.Unknown != "2"',uiOutput("angle_input"))
       ,conditionalPanel(condition = 'input.Unknown == "4"',uiOutput("initial_h_input"))
       ,conditionalPanel(condition = 'input.Unknown == "3"',uiOutput("max_h_input"))
       ,conditionalPanel(condition = 'input.Unknown != "6" && input.Unknown != "3" && input.Unknown != "4" && input.Unknown != "5"',uiOutput("max_t_input"))
       ,conditionalPanel(condition = "input.Unknown != '7' && input.Unknown != '3' && input.Unknown != '4' && input.Unknown != '5'",uiOutput('range'))
       ,actionButton("button", "Calculate Unknown")
       ),
      
    # Show a plot of the generated distribution
    mainPanel(
       textOutput('unknown_value')
    )
  )
))
