library(shiny)

# Define UI for application that draws a histogramcheckboxGroupInput("checkGroup", 
shinyUI(fluidPage(
                  # Application title.
                  titlePanel("Mean of samples"),
                  
                  # Sidebar with a slider input for number of bins. 
                  sidebarLayout(sidebarPanel(h3("Number of samples",align = "center"),
                                             helpText("Select number of samples"),
                                             sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
                                             checkboxGroupInput("checkGroup", 
                                                                label = h3("Checkbox group"), 
                                                                choices = list("Choice 1" = 1, 
                                                                               "Choice 2" = 2, 
                                                                               "Choice 3" = 3),
                                                                                selected = 1)
                                             ),
                                mainPanel(
                                          h6("Episode IV"),
                                          plotOutput("distPlot")
                                          )
                                )
                  )
        )