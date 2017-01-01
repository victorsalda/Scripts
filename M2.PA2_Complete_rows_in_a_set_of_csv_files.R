#This function is to calculate how many complete rows are in a set of.csv files
#that are located in a directory. Has two arguments, directory that indicates where 
#are the .csv files (don't forget use "", for instance, "C:/Users/Proyects") and 
#id that are the files (by index) to be evaluated.

complete <- function(dir, id){
    
    #Define a variable (wd) with the actual working directory. This is to set back 
    #the actual directory at the end on the execution of the function.  
    wd<-getwd()
    
    #Set the directory of the .csv files and define a variable (dir_of_files) of it
    setwd(dir)
    dir_of_files<-getwd()
    
    #Vctor with the .cv files in the directory.
    vector_files<-list.files(dir_of_files)
    
    #Create a logical vector to be filled with the number of completes observations 
    #in the .csv files.
    com_obs<-vector()
    
    #Loop to fill the vector and make it a column vector with rbind. 
    for (i in id){
            com_obs<-rbind(com_obs,sum(complete.cases(read.csv(vector_files[i]))))
    }
    #Set back the actual working directory.
    setwd(wd)
     
    #Create a data.frame with two columns id and com_obs
    datacomplete<-data.frame(id,com_obs)
    
    #Show the data.frame
    datacomplete
} 