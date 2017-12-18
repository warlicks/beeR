#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$selectX <- renderUI({
    tagList(
      selectInput("varX", label=NULL, choices=names(styles))
    )
  })

  output$selectY <- renderUI({
    tagList(
      selectInput("varY", label=NULL, choices=names(styles))
    )
  })

  data <- eventReactive(input$Submit, {
    return(subset(styles, !is.na(styles[,input$varX]) | !is.na(styles[,input$varY])))
  })

  output$Plot <- renderPlot({
    ggplot(data = data(),
           mapping = aes(x = as.numeric(data()[,input$varX]),
                         y = as.numeric(input$varY),
                         color = category.name)) +
      geom_point(position = position_jitter()) +
      scale_color_brewer(type = "qual", palette = 3) +
      labs(x = "Minimum OG", y = "Minimum IBU",
           color = "Style Category") +
      theme_classic()
  })

  output$info <- renderPrint({
    brushedPoints(styles, input$plot_brush, "selectX", "selectY")
  })

})
