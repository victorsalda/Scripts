## Coursera Getting and Cleaning Data Course Project 2
## By: Victor D. Saldaña C.

# runAnalysis.r "Script Description".

## This script will perform the Coursera Getting and Cleaning Data Course Project 2 
## 1. Merge the training and the test sets to create one data set.
## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately label the data set with descriptive activity names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

.................................................................................................................
.................................................................................................................
.................................................................................................................


## 1. Merge the training data set and the test data set to get one.

#Set working directory to the location where the UCI HAR Dataset was unzipped
setwd("C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files")

# Importing features.
features <- read.table("C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files/features.txt",header=FALSE) 

# Importing activity type and assigning column names.
activitytype <- read.table("C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files/activity_labels.txt",header=FALSE)
colnames(activitytype) <- c("activityId","activitytype")

# Importing train data, assigning column and getting the final train dataset.
subjectTrain <- read.table("C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files/train/subject_train.txt",header=FALSE)
xTrain <- read.table("C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files/train/X_train.txt",header=FALSE)
yTrain <- read.table("C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files/train/y_train.txt",header=FALSE)
colnames(subjectTrain) <- "subjectId"
colnames(xTrain) <- features[,2] 
colnames(yTrain) <- "activityId"
trainingData = cbind(yTrain,subjectTrain,xTrain) ##final training dataset.

# Importing test data, assigning column and getting the final test dataset.
subjectTest <- read.table("C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files/test/subject_test.txt",header=FALSE); #imports subject_test.txt
xTest <- read.table("C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files/test/X_test.txt",header=FALSE); #imports x_test.txt
yTest <- read.table("C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files/test/y_test.txt",header=FALSE); #imports y_test.txt
colnames(subjectTest) <- "subjectId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityId"
testData <- cbind(yTest,subjectTest,xTest) ##final test dataset. 

# Final training+test data set and colnames's vector. 
UltimateData <- rbind(trainingData,testData)
colNames  <- colnames(UltimateData) 


## 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Logical vector for subsetting ID, mean and standar desviation and ultimate data.
logicalVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames))
UltimateData <- UltimateData[logicalVector==TRUE]



## 3. Use descriptive activity names to name the activities in the data set.

# Merge the UltimateData and the acitivityType table in order 
# to include descriptive activity names and then update colNames Vector.
UltimateData = merge(UltimateData,activitytype,by="activityId",all.x=TRUE) ##adding "activitytype" column. 
colNames  = colnames(UltimateData) 



## 4. Appropriately label the data set with descriptive activity names. 

# Cleaning up the variable names and new UltimateData's column names. 
for (i in 1:length(colNames)) 
{
            colNames[i] <- gsub("\\()","",colNames[i])
            colNames[i] <- gsub("-std$","StdDev",colNames[i])
            colNames[i] <- gsub("-mean","Mean",colNames[i])
            colNames[i] <- gsub("^(t)","time",colNames[i])
            colNames[i] <- gsub("^(f)","freq",colNames[i])
            colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
            colNames[i] <- gsub("([Bb]ody)","Body",colNames[i])
            colNames[i] <- gsub("[Gg]yro","Gyro",colNames[i])
            colNames[i] <- gsub("AccMag","AccMagnitude",colNames[i])
            colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
            colNames[i] <- gsub("JerkMag","JerkMagnitude",colNames[i])
            colNames[i] <- gsub("GyroMag","GyroMagnitude",colNames[i])
}
colnames(UltimateData) <- colNames


## 5. Create a second, independent tidy data set with the average of each variable 
## for each activity and each subject. 

# Create a new table, UltimateDataNew without the activitytype column and calculation 
# Every variable's mean
UltimateDataNew <- UltimateData[,1:48] ##also works UltimateData[,names(UltimateData) != "activitytype"].
TidyData <- aggregate(UltimateDataNew[,names(UltimateDataNew) != c("activityId","subjectId")],
            by=list(activityId=UltimateDataNew$activityId,subjectId = UltimateDataNew$subjectId),mean);

# Merge the TidyData and activitytype in order to include descriptive activity 
TidyData <- merge(TidyData,activitytype,by="activityId",all.x=TRUE);

# TidyData set as file.  
write.table(TidyData, "C:/Victor/Estudios/6.MOOCs/Getting_and_Cleaning_Data/Getdata_project_files/TidyData.txt",row.names=TRUE,sep="\t");