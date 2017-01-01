#this function is to calculate how many complete rows are in a set of.csv files
#that are in a directory. Has only one arguments, directory that indicates where 
#are the .csv files (don't forget use "", for instance, "C:/Users/Proyects").

def complete (dir):
    ##Importing needed modules.
    import os, csv, pandas, numpy
    
    ##Setting directory where files are.    
    os.chdir(dir)
    
    ##Creatig a empty lists and definig variables.
    csv_files_number=[]
    complete_cases=[]
    a=0
    
    ##Looping in the directory where the files are.     
    for i in os.listdir(dir):
        if i.endswith(".csv"):
            a +=1
    for j in range (a):
        csv_files_number.append(j+1)
    
    csv_files_number=pandas.DataFrame (csv_files_number, columns = ['csv_number'])
    print csv_files_number
    
    ##Loop in the directory where the csv files ignoring other files extentions and
    ##create a file object using the open(), read it and create a list of list object.       
    for k in os.listdir(dir):
        if k.endswith(".csv"):
            open_object = open(k,"rb")
            read_data=csv.reader(open_object)
            csv_file=[row for row in read_data]
            open_object.close()
    
            ## turn the list of list object into a panda data frame using the first row as a header.           
            csv_files_as_df=pandas.DataFrame (csv_file, columns=csv_file.pop(0))
            
            ##Replace missing values NA (strings) with pandas data frame missing values NaN
            csv_files_as_df=csv_files_as_df.replace("NA",numpy.nan)
        
            ##Subset rows with NaN, i.e., incomplete cases.
            csv_files_as_df_com_cases= csv_files_as_df[csv_files_as_df.isnull().T.any()]
            
            ##Number of total, incomplete (rows with at least one NaN) and complete cases (rows without any NaN) 
            total_cases=csv_files_as_df.shape[0] 
            incomplete_cases=csv_files_as_df_com_cases.shape[0]
            
            #complete_cases list
            complete_cases.append(total_cases - incomplete_cases)
   
    ##Complete cases as a panda data frame
    complete_cases=pandas.DataFrame (complete_cases, columns = ['complete cases'])
    print complete_cases
    
    ##Concact the two panda data frames: csv_files_number and complete_cases.     
    csv_files_number_complete_cases=pandas.concat([csv_files_number,complete_cases], axis=1)
    print csv_files_number_complete_cases
