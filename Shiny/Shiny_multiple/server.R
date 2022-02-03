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

        lapply(input$`Y value`, function(vv) colourInput(paste0(vv, "_colour")
        #colourInput('colour_line_1',
                    ,"specify color"))

    })

    output$distPlot <- renderPlot({
    print("starting renderPlot")
        # generate bins based on input$bins from ui.R
        #x    <- faithful[, 2]
        #bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the ggplot with the specified number of bins
       #browser()


        # input <- list(colour_line=c("red"),
        #              'Y value' = c("strac_covid_positive_in_hospita", "total_case_daily_change",
        #                             "total_case_cumulative")

         geom.list <- lapply(input$`Y value`, function(xx) geom_line(aes_string(y=xx),
                                                                    linetype="dotted",
                                                                    color = input[[paste0(xx, "_colour")]], size=1))
message("geom.list")

         ggplot(dat1, aes_string( x = "reporting_date")) +
             geom.list +
             ylab("Counts")

    })

})



#input <- list("Y value" = colnames(dat1)[4:9])

#lapply(input$"Y value", function(vv) colourInput(paste0(vv, "_colour")))
