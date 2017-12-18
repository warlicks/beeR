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
  titlePanel("StyleSpace: beer style explorer"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      tags$h5("Select a variable for the X-axis in the box below"),
      uiOutput(outputId = "selectX"),
      tags$h5("Select a variable for the Y-axis in the box below"),
      uiOutput(outputId = "selectY"),
      actionButton(inputId="Submit", label = "Submit")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot", brush="plot_brush", click="plot_click"),
      verbatimTextOutput("info")
    )
  )
))
