####**Victor D. Saldaña C.**
######PhD(c) in Geoinformatics Engineering
######Technical University of Madrid (Spain)
######https://es.linkedin.com/in/victorsalda
######https://github.com/victorsalda
######*September 2016*

###**Overview.**
####This is the report of the first part of the Statistical Inference Peer Assignment:
#A simulation exercise. It includes supporting material such as the codes and figures.

#1. Load packages.
#Let's load the packages we need. If you haven't download them do it first
library("ggplot2")
library("knitr")
library("datasets")
library("ggplot2")
library("ggpmisc")
library("gridExtra")
library("plyr")

#2. Reproducibility.
# Set the seed (55) for reproducibility, i.e., make available to others the data to verify
#the calculations made with the code. 
set.seed(55)

#3. Simulation.
#Create a logical vector to be filled with the means of the "n" samples from
#the exponential distribution. 
means<-vector()

#Loop to fill the vector with 1000 samples (with n= 40) means from the exponential distribution. 
for (i in 1:1000){
        means<-cbind(means,mean(rexp(40,rate=0.2)))
}

#4. Sample Mean versus Theoretical Mean*
#Let's show the sample mean and compare it to the theoretical mean 
#of the distribution. 
histmeans<-hist(means,xlab = "Sample Means", col="light gray",breaks=30,
                main="Sampling distribution of the mean")
cd<-mean(means)
tc<-1/0.2
abline(v=cd,col="blue",lwd=3)
abline(v=tc,col="red",lwd=3)

#5. Sample Variance versus Theoretical Variance.
#Show how variable the sample is (via variance) and compare it to 
#the theoretical variance of the distribution.
vsd<-var(as.vector(means))
vtc<-(1/0.2^2)/40 
barplot(c(vsd,vtc), width = 2, main = "Variance",
        names.arg=c("Sampling","Theorical"),col=c("blue","red"),
        ylim=c(0,0.7))
text(1.3,.68,round(vsd, digits = 3))
text(3.8,.68,round(vtc, digits = 3))

#6.Normality of the distribution.
#Let's show that the distribution is approximately normal. Therefore, a QQPlot
#with normal theorical quantiles is going to be used. 
qqnorm(means)
qqline(means)