#This function (corr) calculates the correlation between sulphate and nitrate in the 
#csv files where the number of completely observed cases (on all variables) is 
#greater than the threshold. If there is not any, it returns a numeric vector of length 0.
#Has Three arguments:
#1. Directory: indicates where are the .csv files (don't forget use #"", for instance, 
#                   "C:/Users/Proyects".
#2. Threshold: indicates the minimum number of completes cases that need to have a csv 
#                    file to be considered.             
#3. ID: are the files (by list) to be evaluated, for instance ID =list(range(10,13))+list(20:21)+...
#includes only n the evaluation the csv files [11, 12, 13, 21]. Recall Python starts indexing with 0.

def corr (directory, threshold,ID):
    #Importing needed modules.
    import os, csv, pandas, numpy
    
    #Setting directory where files are.    
    os.chdir(directory)
    
    #Creating empty lists and defining variables.
    list_files=[] #list for csv files as panda data frames. 
    list_evaluated_files=[] #the csv files as panda data frames considered for evaluation 
                                     #difined by ID parameter. 
    vector_complete_cases=[] #vector with number of complete cases in every csv files as panda 
                                           #data frames evaluated.
    list_used_files=[] #list with the panda data frames considered for evaluation that overpass 
                              #the threshold.
    
    #Loop in the directory where the csv files are ignoring other files extensions and
    #create a file object using the built-in function open(), read it and create a list of list object.
    #Reading the csv file on the hard way, instead of using pandas.read.csv.        
    for i in os.listdir(directory):
        if i.endswith(".csv"):
            open_object = open(i,"rb")
            read_data=csv.reader(open_object)
            csv_file=[row for row in read_data]
            open_object.close()
                
            #Turn the list of list object into a panda data frame using the first row as a header.           
            csv_files_as_df=pandas.DataFrame (csv_file, columns=csv_file.pop(0))
                
            #Replace missing values NA (strings) with pandas data frame missing values NaN.
            csv_files_as_df=csv_files_as_df.replace("NA",numpy.nan)
                
            #Create a list with the panda data frames.            
            list_files.append(csv_files_as_df)
                
            #Make  list_files a global variable by defining a global one ( list_files_final). This 
            #new variable contains al the pandas data frames.             
            global  a
            a= list_files
    for j in ID:
         LF=list_files[j]
         list_evaluated_files.append(LF)
         global b
         b = list_evaluated_files                
                     
    for k in list_evaluated_files:
        #Number of complete rows of the "i" evaluated data frame. 
        complete_rows=k.dropna().shape[0] 
        
        #vector with number of complete cases and asiination to a global varaible.
        vector_complete_cases.append(complete_rows)        
        global vector_complete_cases_final        
        vector_complete_cases_final=vector_complete_cases
       
        #Determine the maximum value of complete cases in all the csv files.     
        max_value=max(vector_complete_cases)

        #If the threshold set as argument in the function is greater than the maximum value of 
        #complete cases (max_value) it means that there is not even a csv file that overpasses
        #the threshold. Therefore, the function should return a numeric vector of length 0. 
        #On the other hand, If the threshold set is smaller than the maximum value of complete
        #cases (max) there is at least one csv file that overpasses the threshold set and the 
        #function should calculate the correlations between sulphate and nitrate for every csv file. 
        
    if threshold <=max_value:
        #If the condition is TRUE so is needed to get a vector (files) with the .csv
        #files that overpass the threshold (files).  
         for i in  list_evaluated_files:
             if i.dropna().shape[0]>=threshold:
                 list_used_files.append(i)
                 global c                        
                 c= list_used_files         
         
         #Concatenate all data frames that overpass the threshold:
         global data_frame_final
         data_frame_final=pandas.concat(list_used_files,ignore_index=True)
         
         #Clean the data frame final to only work with the complete cases.
         global data_frame_final_NoNaN             
         data_frame_final_NoNaN=data_frame_final.dropna()
         
         #Change the data type of the "nitrate" and "sulfate" column that is "object" (string) to
         #float. It was used .loc for recommendation of Pandas developers. It would have worked 
         #with just data_frame_final_NoNaN["nitrate"]=......
         data_frame_final_NoNaN.loc[:,"nitrate"]=data_frame_final_NoNaN.nitrate.astype(float)
         data_frame_final_NoNaN.loc[:,"sulfate"]=data_frame_final_NoNaN.sulfate.astype(float)
                  
         #In the cleaned data frame "data_frame_final_NoNaN" there are observations from all 
         #the csv files that overpassed the threshold. So, let's divide id by the ID attribute that 
         #is the identification of the csv file.  
         data_frame_final_NoNaN.sort(["ID"])        
         return data_frame_final_NoNaN.groupby("ID").corr()
         
    else:
        print "No .csv reaches the threshold"