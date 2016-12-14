#Title: "Developing Data Products Peer Assignment"
#**Victor D. Saldaña C.**
#PhD(c) in Geoinformatics Engineering
#Technical University of Madrid (Spain)
#https://es.linkedin.com/in/victorsalda
#https://github.com/victorsalda
#*November, 2016*

library(shiny)

# Define UI for application that draws a histogramcheckboxGroupInput("checkGroup", 
shinyUI(fluidPage(
                  # Application title.
                  titlePanel("Sampling distribution of the sample mean"),
              
                  # Sidebar with a slider input for number of bins. 
                  sidebarLayout(sidebarPanel(width = 3,
                                             h3("Settings",align = "center"),
                                             helpText("In this panel you can adjust settings for using the Web App, i.e., 
                                                      the number of samples and the size of them."),
                                             radioButtons("number_of_samples", 
                                                          label = h4("Number of samples"), 
                                                          choices = list("20 samples" = 20, 
                                                                         "50 samples" = 50,
                                                                         "100 samples" = 100,
                                                                         "200 samples" = 200,
                                                                         "500 samples" = 500,
                                                                         "1000 samples" = 1000,
                                                                         "2000 samples" = 2000,
                                                                         "5000 samples" = 5000,
                                                                         "10000 samples" = 10000),
                                                                          selected = 20),
                                             sliderInput("size_of_sample", label = h4("Size of sample"), min = 2, max = 1000, value = 50)
                                             ),
                                mainPanel(
                                          p("This Web App evaluates", strong("The Central Limit Theorem"),"one of the main concepts 
                                            in statistics and, thereby, in Data Science. This theorem states that the mean 
                                            value of a variable obtained from a sample that comes from a population that has any 
                                            underlying distribution approaches a", strong("normal distribution"),"as the sample size increases. 
                                            In fact, if the underlying distribution is normal the size is much less important. Figure 1 shows the 
                                            histogram with the frequencies of the mean value of a group of samples of  
                                            a specific size from a population that is", strong("uniformly distributed"),"as shown in figure 3. On the 
                                            other hand, figure 2 shows a normal QQ plot to evaluate (graphically) the normality of the 
                                            sampling distribution of the sample mean. The greater the size and number of samples the more normal is the 
                                            sampling distribution. The", span ("red line", style = "color:red"),"is the mean value of the uniform distribution (population) 
                                            and the", span("green line", style = "color:green"), "the mean of the sample means."),
                                          plotOutput("hist",width = "60%", height = "300px"),
                                          plotOutput("qqnorm",width = "60%", height = "300px"),
                                          plotOutput("original",width = "60%", height = "300px")
                                          )
                                )
                  )
)