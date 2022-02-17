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
    print("starting shinyServer")

    output$ycol <- renderUI({

        lapply(seq_along(input$`Y value`), function(vv) colourInput(paste0(input$`Y value`[vv],
                            "_colour"),"specify color",hcl.colors(20,palette='Dark 3')[vv]))

    })

    output$distPlot <- renderPlotly({
    print("starting renderPlot")


         geom.list <- lapply(input$`Y value`, function(xx) geom_line(aes_string(y=xx),
                                                                    #linetype="dotted",
                                                                    color = input[[paste0(xx, "_colour")]], size=1))
#message("geom.list")

         plt <- ggplot(dat1, aes_string( x = "reporting_date")) +
             geom.list +
             ylab("Counts")
         ggplotly(plt) %>%
             layout(dragmode='select')

    })

})



#input <- list("Y value" = colnames(dat1)[4:9])

#lapply(input$"Y value", function(vv) colourInput(paste0(vv, "_colour")))
