#This function (corr) calculates the correlation between sulphate and nitrate in the 
#csv files where the number of completely observed cases (on all variables) is 
#greater than the threshold. If there is not any, it returns a numeric vector of length 0.
#Has Three arguments:
#1. Directory: indicates where are the .csv files (don't forget use #"", for instance, 
#              "C:/Users/Proyects".
#2. Threshold: indicates the minimum number of completes cases that need to have a csv 
#              file to be considered.             
#3. id: are the files (by index) to be evaluated, for instance c(1:4,6,7,34:50).
corr <- function(dir, threshold=0,id){
    #Define a variable (wd) with the actual working directory. This is to set back 
    #the actual directory at the end on the execution of the function.
    wd<-getwd()
    
    #Set the directory of the .csv files and define a variable (dir_of_files) of it
    setwd(dir)
    dir_of_files<-getwd()
    
    #Vector with the .csv files.
    vector_files<-list.files(dir_of_files)
    
    #Logical vector to save the number of complete cases in every csv file.
    complete_cases<-vector()
    
    #Function to calculate the vector with the number of complete cases of the csv file.    
    for (i in id){
        complete_cases<-rbind(complete_cases,sum(complete.cases(read.csv(vector_files[i])))) 
    }
    #Determine the index (location) of the maximum value of complete cases (index_max)  
    #in all the csv files.     
    index__max<-which.max(complete_cases)
    
    #Subset from the vector of complete cases the maximum value (max).
    max<-complete_cases[index__max,1]
    
    #If the threshold set as argument in the function is greater than the maximum value of 
    #complete cases (max) it means that there is not even a csv file that overpasses
    #the threshold. Therefore, the function should return a numeric vector of length 0. 
    #On the other hand, If the threshold set is smaller than the maximum value of complete
    #cases (max) there is at least one csv file that overpasses the threshold set and the 
    #function should calculate the correlations between sulphate and nitrate for every csv file.   
    if(threshold<=max){
        #If the condition is TRUE so is needed to get a vector (files) with the .csv 
        #files that overpass the threshold (files).  
        files<-vector()
        for (i in id){
            if(sum(complete.cases(read.csv(vector_files[i])))>=threshold){
                files<-rbind(files,vector_files[i]) 
            }   
        }
        #Create a logical data frame to be filled with the observations of all the csv 
        #files that overpass the threshold.  
        obs<-data.frame()
        for (i in 1:length(files)){
            obs<-rbind(obs, read.csv((files[i])))   
        }
        #Clean the data frame to only work with the completed cases (No NA in any attribute)
        clean_obs<-obs[complete.cases(obs),]
        
        #In the cleaned data frame "obs" there are observations from all the csv files that 
        #overpassed the threshold. So, let's divide the data by the ID attribute that is the 
        #identification of the csv file.  
        split_obs<-split(clean_obs,clean_obs$ID)
        
        #Once the observation have been split by csv file, next step is to calculate the 
        #correlation by ID (i.e. by file) and create a vector that contains this correlations. 
        correlations<-vector()
        for (i in 1:length(split_obs)){
            correlations<-cbind(correlations,cor(split_obs[[i]][2],split_obs[[i]][3]))
        }
        print (as.vector(correlations))
    }else{
        empty_vector<-vector(mode="numeric",length=0)
        print (empty_vector)
    }
    #Set back the actual working directory.
    setwd(wd)
}