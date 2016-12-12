####**Victor D. Saldaña C.**
######PhD(c) in Geoinformatics Engineering
######Technical University of Madrid (Spain)
######https://es.linkedin.com/in/victorsalda
######https://github.com/victorsalda
######*September 2016*

#Overview.
####This is the report of the second part of the Statistical Inference Peer Assignment:
#Basic inferential data analysis. It includes supporting material such as the codes and 
#figures.

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

#3. Load the data.
##The data we are going to use in this part of the assignment is the ToothGrowth dataset from R.
#This dataset contains 60 observations of "the Effect of Vitamin C on Tooth Growth 
#in Guinea Pigs". There are three variables: 
#1) Len (Tooth Length, numeric).
#2) Supp (Supplement Type, OJ = orange juice, VC = vitamin C, factor).
#3) Dose (Dose levels of vitamin 0.5, 1, and 2 mg/day, numeric).
data("ToothGrowth")
df<-ToothGrowth

#4. Basic summary of the data.
#Let's summarize and do some tables and quick plots with cluster to explore the data. 
summary(df)
table(df$supp, df$dose)

#5. Confidence intervals and/or hypothesis tests.
#Let's calculate the confidence intervals (ci) for the mean len of the sample with a confidence
#level of 95%
ci<-mean(ToothGrowth$len) + c(-1, 1) * 1.96 * sd(ToothGrowth$len)/sqrt(nrow(ToothGrowth))

#The "ci" conatis the intervals for all the 60 observation of the ToothGrowth dataset. Now,
#let's get the values by supplement type and dose (means).    
means_by_supp<-tapply(ToothGrowth$len,ToothGrowth$supp,mean)
means_by_dose<-tapply(ToothGrowth$len,ToothGrowth$dose,mean)
means_by_supp
means_by_dose

#Let's calculate the confidence intervals (ci) for the mean len of the sample with a confidence
#level of 95% by supplement.
ci_supp_OJ<-means_by_supp[1] + c(-1, 1) * 1.96 * 
        sd(ToothGrowth[ToothGrowth$supp=="OJ",]$len)/sqrt(nrow(ToothGrowth[ToothGrowth$supp=="OJ",]))
ci_supp_VC<-means_by_supp[2] + c(-1, 1) * 1.96 * 
        sd(ToothGrowth[ToothGrowth$supp=="VC",]$len)/sqrt(nrow(ToothGrowth[ToothGrowth$supp=="VC",]))
ci_supp_OJ
ci_supp_VC

#Let's calculate the range of the intervals.
dif_supp_OJ<-ci_supp_OJ[2]-ci_supp_OJ[1]
dif_supp_VC<-ci_supp_VC[2]-ci_supp_VC[1]
dif_supp_OJ
dif_supp_VC

#Let's calculate the confidence intervals (ci) for the mean len of the sample with a confidence
#level of 95% by dose.
ci_dose_0.5<-means_by_dose[1] + c(-1, 1) * 1.96 * 
        sd(ToothGrowth[ToothGrowth$dose==0.5,]$len)/sqrt(nrow(ToothGrowth[ToothGrowth$dose==0.5,]))
ci_dose_1.0<-means_by_dose[2] + c(-1, 1) * 1.96 * 
        sd(ToothGrowth[ToothGrowth$dose==1.0,]$len)/sqrt(nrow(ToothGrowth[ToothGrowth$dose==1.0,]))
ci_dose_2.0<-means_by_dose[3] + c(-1, 1) * 1.96 * 
        sd(ToothGrowth[ToothGrowth$dose==2.0,]$len)/sqrt(nrow(ToothGrowth[ToothGrowth$dose==2.0,]))
ci_dose_0.5
ci_dose_1.0
ci_dose_2.0
dif_dose_0.5<-ci_dose_0.5[2]-ci_dose_0.5[1]
dif_dose_1.0<-ci_dose_1.0[2]-ci_dose_1.0[1]
dif_dose_2.0<-ci_dose_2.0[2]-ci_dose_2.0[1]
dif_dose_0.5
dif_dose_1.0
dif_dose_2.0

#Let's calculate some clusters to do a better interpretation of the intervals. 
cluster<-kmeans(df[,-2], centers = 3)
df[,4]<-as.factor(cluster$cluster)
colnames(df)[4]<-"cluster"
facets<-qplot(dose, len, data = df, shape=supp, size=I(2))+geom_smooth(method="lm")+
        ggtitle("Regressions")+facet_grid(supp ~ .)

#Let's add the regression line formula and the value of R^2 in every plot (facet). 
#The basic idea is to create a function (reg_func) whose argument is the data frame with the 
#data (dataframe). Inside this function is created another function with the model of the 
#regression in these case a linear model with a straight line. From this 
#function that was created inside the coefficients and R^2 are obtained.
regression=function(df){
        #setting the regression function. 
        reg_fun<-lm(formula=df$len~df$dose) #regression function
        #getting the slope, intercept, R square and adjusted R squared of 
        #the regression function (with 3 decimals).
        slope<-round(coef(reg_fun)[2],3)  
        intercept<-round(coef(reg_fun)[1],3) 
        R2<-round(as.numeric(summary(reg_fun)[8]),3)
        R2.Adj<-round(as.numeric(summary(reg_fun)[9]),3)
        c(slope,intercept,R2,R2.Adj)
}
regressions_data<-ddply(ToothGrowth,"supp",regression)
colnames(regressions_data)<-c ("supp","slope","intercept","R2","R2.Adj")

facets+geom_label(data=regressions_data, inherit.aes=FALSE,aes(x = 1.2, y = 32, 
                                                               label=paste("slope=",slope,","," ","intercept=",intercept,","," ","R^2=",R2,",",
                                                                           " ","R^2.Adj=",R2.Adj)))


#Let's consider dose and supp at the same time. Let's suppose len (Tooth Length) is normal distributed. So, no matter the 
#sample size the distribution of the sample mean is normally distributed, as well. Let's also assume that the 60 observations are 
#independent. Now, let's also suppose that the sample have been divided randomly in two groups of 30 individuals. One of these groups 
#(OJ or VC). We can consider that the two groups are sample from two different population, and let suppose these two population have the 
#same variance. 

#Therefore, we have two samples of 30 observations each from two population with the len variable is normally distributed and 
#not have the same variance. Now we want to evaluate is the difference in the mean of the len in both group is just by chance or 
#depends on the supplement and dose. So, the null hypothesis we want to contrast is that the mean difference between the two 
#is zero (0). Let's do this contrast first with all doses together and then by dose. In any case, with a 95% confidence levels,
#so that we have only a 5% chance of making a Type I error.

t.test(ToothGrowth[ToothGrowth$supp=="OJ",]$len, y = ToothGrowth[ToothGrowth$supp=="VC",]$len, alternative = "two.sided", mu = 0, 
       paired = FALSE, var.equal = TRUE, conf.level = 0.95)

#Now, let's do the same by dose.  

#dose:0.5 mg/day. 
pv_0.5<-(t.test(ToothGrowth[ToothGrowth$supp=="OJ"&ToothGrowth$dose==0.5,]$len, y = ToothGrowth[ToothGrowth$supp=="VC"&ToothGrowth$dose==0.5,]$len,
alternative = "two.sided", mu = 0,paired = FALSE, var.equal = TRUE, conf.level = 0.95))[3]

#dose:1.0 mg/day. 
pv_1.0<-(t.test(ToothGrowth[ToothGrowth$supp=="OJ"&ToothGrowth$dose==1.0,]$len, y = ToothGrowth[ToothGrowth$supp=="VC"&ToothGrowth$dose==1.0,]$len, 
alternative = "two.sided", mu = 0,paired = FALSE, var.equal = TRUE, conf.level = 0.95))[3]

#dose:2.0 mg/day. 
pv_2.0<-(t.test(ToothGrowth[ToothGrowth$supp=="OJ"&ToothGrowth$dose==2.0,]$len, y = ToothGrowth[ToothGrowth$supp=="VC"&ToothGrowth$dose==2.0,]$len, 
alternative = "two.sided", mu = 0,paired = FALSE, var.equal = TRUE, conf.level = 0.95))[3]

#p-values.
paste("pv_0.5=",round(as.numeric(pv_0.5),6),",","pv_1.0=",round(as.numeric(pv_1.0),6),",","pv_2.0=",round(as.numeric(pv_2.0),5))