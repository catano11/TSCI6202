#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(colourpicker);
library(shinyBS);
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("COVID Dashboard"),

    # Sidebar with a slider input for number of bins
    tabsetPanel(
        tabPanel("COVID_19_Panel",
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput("bins",
                                     "Number of bins:",
                                     min = 1,
                                     max = 50,
                                     value = 30),
                         # colourInput('colour_line', "specify color",value='red'),
                         selectInput("Y value","Specify Variable", colnames(dat1)[-(1:3)],
                                     multiple = TRUE,
                                     selectize = TRUE,
                                     selected = colnames(dat1)[5]),
                         uiOutput("ycol")
                     ),

                     # Show a plot of the generated distribution
                     mainPanel(fluidRow( column(10,
                                                plotlyOutput("distPlot")))
                     ))),
        tabPanel("Empty_for_now", gt_output('gTable_test')),

        tabPanel(title = "NewTestPanel",
                 sidebarLayout(
                     sidebarPanel(
                         selectInput("gt_var", "Select Variables", Summary1$name,
                                     multiple = TRUE,
                                     selectize = TRUE,
                                     selected = Summary1$name),
                         selectInput("gt_col", "Select Statistics", colnames(Summary1),
                                     multiple = TRUE,
                                     selectize = TRUE,
                                     selected = colnames(Summary1))),
                     mainPanel(fluidRow(column(10,
                                               gt_output('distPlot_test'))))
                 )),
        tabPanel(title = "debug", actionButton("debug","DEBUG" )))



))

