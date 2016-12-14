#Title: "Developing Data Products Peer Assignment"
#**Victor D. Saldaña C.**
#PhD(c) in Geoinformatics Engineering
#Technical University of Madrid (Spain)
#https://es.linkedin.com/in/victorsalda
#https://github.com/victorsalda
#*November, 2016*

library(shiny)

# Define server logic required to draw a histogram

shinyServer(function(input, output){
     output$hist <- renderPlot({
       mean<-vector()
       for (i in 1:input$number_of_samples){
         mean[i]<-mean(sample(1:100000, input$size_of_sample, replace=F))
       }
       hist(mean,col="blue",main = "Figure 1. Sampling distribution of the sample mean")
       abline(v=mean(1:100000),col="red",lwd=3)
       abline(v=mean(mean),col="green",lwd=3)
       mean<-a
     })
     output$qqnorm <- renderPlot({
       mean2<-vector()
       for (i in 1:input$number_of_samples){
         mean2[i]<-mean(sample(1:1000000, input$size_of_sample, replace=F))
       }
       qqnorm(mean2, col="black", xlab="Theoretical Quantiles", ylab="Sample's mean Quantiles", main="Figure 2. QQ Plot")
       qqline(mean2)
     })
     output$original <- renderPlot({
       hist(1:1000000, main = "Figure 3. Uniform distribution (Sequence from 1 to 1000000 by 1)",col="green")
     })
})