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

        lapply(seq_along(input$`Y value`), function(vv)
            colourInput(paste0(input$`Y value`[vv],
                               "_colour"),"specify color",hcl.colors(20,palette='Dark 3')[vv]))

    })
    # gt_plot ----
    output$gTable_test <- render_gt({
        truncate_cols <- c("count_7_day_moving_avg" , "change_in_7_day_moving_avg")
        gt_preview(dat1) %>%
            cols_hide(hide) %>%
            fmt_number(all_of(truncate_cols), decimals = 1) %>%
            fmt_missing(columns = everything(), missing_text = "Eureka") %>%
            data_color(columns = "total_case_daily_change",
                       colors= scales::col_numeric(palette = c('green','red'),
                                                    domain = NULL)) %>%
                           tab_style(style=list(
                               cell_fill(color = "yellow"), cell_text(weight = 'bold')),
                               locations = cells_body(columns = c(change_in_7_day_moving_avg),
                                                      rows = change_in_7_day_moving_avg > 0)) %>%
                           cols_label(deaths_under_investigation = html("Deaths&nbsp;Investigation"))})



    # distPlot ----

    #message("geom.list")

    output$distPlot <-renderPlotly({
        print("starting render plot")


        geom_list <- lapply(input$`Y value`,
                            function(xx) geom_line(aes_string(y=xx),
                                                   color=input[[paste0(xx, "_colour")]], size=1))

        plt <- ggplot(dat1, aes_string( x = "reporting_date")) +
            geom_list +
            ylab("Counts")
      # browser()
        ggplotly(plt) %>%
            layout(dragmode='select')})


    output$distPlot_test <- render_gt({
        print("starting renderPlot")

        subset(Summary1, name %in% input$gt_var)[,input$gt_col] %>%

            gt() %>%
            cols_hide(hide_spark) %>%
            gt_sparkline (Sparkline, same_limit = F) %>%
            gt_sparkline (Hist, type = "histogram", same_limit = F) %>%
            gt_sparkline (Dense, type = "density", same_limit = F) %>%
            cols_move("Sparkline" , after = "name") %>%
            cols_label("Sparkline" = "**Sparkline**",
                       Hist = html("<span,style='color:red'>Histogram</span>"),
                       .list = list(med =  "Median"))

    })


    observe({if(input$debug>0) browser()})
})
        #        subset(dat2, name %in% input$gt_)[,input$gt_col]) %>%
        #        gt() %>%
        #        cols_move("sparkline", after = "Median") %>%
        #        cols_label(sparkline = md(**Sparkline**)
        #                   Hist= html("<span,style="color:red">Histogram</span>")%>%
        #                       gt_sparkline(sparkline, same_limit = FALSE) %>%
        #                       gt_sparkline(Hist, same_limit = FALSE, type = "histogram")%>%
        #                       gt_sparkline(Dense, same_limit = FALSE, type = "density"),
        #                   )







        #input <- list("Y value" = colnames(dat1)[4:9])

        #lapply(input$"Y value", function(vv) colourInput(paste0(vv, "_colour")))
