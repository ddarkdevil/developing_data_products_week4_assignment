#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

source("helpers.R")
library(shiny)
library(plyr)
library(ggplot2)
library(rgeos)
library(maptools)
library(gpclib)
library(maps)
library(mapproj)

# Read Data
mydata <- read.csv("amazon.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel(title = h3("Analyzing the data on the forest fires in Brazil", align = "center")),
   br(), br(),
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        # Adding a radio button, just because I can
        radioButtons("amazon", 
                     label = "Select Data: ",
                     choices = list("Amazon Data" = 'Amaz'),
                     selected = 'Glob'),
        br(),   br(),
        # Add Variable for Year Selection
        sliderInput("YearRange", "Select Year Range : ", min=1998, max=2017, value=c(1998, 2017), step=1
        ),
        
        br(),   br(),
      #------------------------------------------------------------------
      # Add Variables selection option from January to December : 
      selectInput("var", "Select Variable from Dataset", 
                  choices=c("Jan"=2, "Feb"=3, "Mar"=4, "Apr"=5, 
                            "May"=6, "Jun"=7, "Jul"=8, "Aug"=9, 
                            "Sep"=10, "Oct"=11, "Nov"=12, "Dec"=13),
                  multiple=TRUE, selected = "Jan"
      ),
      br(),   br()
      #------------------------------------------------------------------
      # Change background color for body
      #tags$style("body{background-color:lightyellow; color:brown}")
   ),
      
      # Show a plot of the generated distribution
   mainPanel(
     #------------------------------------------------------------------
     # Create tab panes
     tabsetPanel(type="tab",
                 tabPanel("Summary",verbatimTextOutput("sumry")),
                 tabPanel("Structure", verbatimTextOutput("struct")),
                 tabPanel("Data", tableOutput("displayData")),
                 tabPanel("Plot", plotOutput("mygraph"))
     )
     
     #------------------------------------------------------------------
   )
   
  )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  cols <- reactive({
    as.numeric(c(input$var))
    
  })
  mylabel <- reactive({
    if(input$amazon == 'Amaz'){
      lable <- "Plot for Brazilian Rainforest Data"
    }
  })
  
  myFinalData <- reactive({
    #------------------------------------------------------------------
    # Get data rows for selected year
    mydata1 <- mydata[mydata$year >= input$YearRange[1], ] # From Year
    mydata1 <- mydata1[mydata1$year <= input$YearRange[2], ] # To Year
    #------------------------------------------------------------------
    # Get Data for selected months as variable
    mydata2<- mydata1[, c(1, sort(cols()))]
    #------------------------------------------------------------------
    # Get data rows for selected year
    data.frame(mydata2)
    #------------------------------------------------------------------
    
  })
   
  # Prepare "Data tab"
  output$displayData <- renderTable({
    myFinalData()
  })
  
  # Prepare Structure Tab
  renderstr <- reactive({ str(myFinalData())})
  
  output$struct <- renderPrint({
    renderstr()
  })
  
  # Prepare Summary Tab
  rendersumry <- reactive({ summary(myFinalData())})
  
  output$sumry <- renderPrint({
    rendersumry()
  })
  
  # Prepare Plot Tab
  output$mygraph <- renderPlot({
    plotdata <- myFinalData()
    plot(plotdata, col=c(1,2,3,4,5,6,7,8,9), main=mylabel())
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)