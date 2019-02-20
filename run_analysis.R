run_analysis <- function(){

  # Set the path to read the appropriate files  
  library(dplyr)
  library(sqldf)
  mypath = "C:/Darpan/DataScience/Course3/Assignment"
  setwd(mypath)
  
  #The below variable is to Read full set test data txt file
  rdtst <- read.csv("X_test.txt",header = FALSE, sep = "",na.strings = "NA", colClasses = "numeric")
  
  #The below variable is to Read full set train data txt file
  rdtrn <- read.csv("X_train.txt",header = FALSE,sep = "",na.strings = "NA", colClasses = "numeric")
  
  #The below variable is to Read features text file
  rdtstlbl <- read.csv("features.txt", header = FALSE, sep = "")
  
  #The below variable is to Extract only the column header data frame
  colHdrs <- as.character(t(rdtstlbl[2]))

  #1.	Merges the training and the test sets to create one data set.
  mgrdata <- rbind(rdtst,rdtrn)

  #Assign column names to the merge data set.
  colnames(mgrdata) <- colHdrs

  #2.	Extracts only the measurements on the mean and standard deviation for each measurement.
  mndata <- mgrdata[, grep("mean|std",colnames(mgrdata))]

  #The below variable is to Read the activity labels from activity_labels.txt file
  actlbl <- read.csv("activity_labels.txt",header=FALSE, sep="")
  
  #The below variable(s) are to Read the Labels from Y test and Y Train text files
  lbltst <- read.csv("y_test.txt", header = FALSE, sep="")
  lbltrn <- read.csv("y_train.txt", header = FALSE, sep="")
  
  #The below variable is to Merge the activity label files into one
  mrglbl <- rbind(lbltst,lbltrn)
  
  #Assign readable column names for Activity and test/train labels.
  colnames(actlbl) <- c("No","Activity")
  colnames(mrglbl) <- c("No")
  
  #The below variable(s) are to Read the subject data from subject test and train text files
  subtst <- read.csv("subject_test.txt", header = FALSE, sep="")
  subtrn <- read.csv("subject_train.txt", header = FALSE, sep="")
  
  #The below variable is to Merge the activity label files into one
  mrgsbj <- rbind(subtst,subtrn)
  
  
  #The below variable Join(s) the data to extract the activity labels for test and train
  
  fnlActLbl <- sqldf("SELECT Activity from mrglbl join actlbl  using(No)")

  #3.	Uses descriptive activity names to name the activities in the data set
  finalResultActy <- cbind(fnlActLbl[,1],mndata)
  finalResultActySub <- cbind(mrgsbj, finalResultActy)
  
  
  
  #4.	Appropriately labels the data set with descriptive variable names.
  
  colnames(finalResultActySub)[1] <- "Subject"
  colnames(finalResultActySub)[2] <- "Activity"
  names(finalResultActySub) <- gsub(x = names(finalResultActySub), pattern = "\\-|\\(|\\)", replacement = "")
  names(finalResultActySub) <- gsub(x = names(finalResultActySub), pattern = "^t", replacement = "Time") 
  names(finalResultActySub) <- gsub(x = names(finalResultActySub), pattern = "Acc", replacement = "Accelerometer") 
  names(finalResultActySub) <- gsub(x = names(finalResultActySub), pattern = "Gyro", replacement = "Gyroscope") 
  names(finalResultActySub) <- gsub(x = names(finalResultActySub), pattern = "Mag", replacement = "Magnitude") 
  names(finalResultActySub) <- gsub(x = names(finalResultActySub), pattern = "^f", replacement = "Frequency")
  names(finalResultActySub) <- gsub(x = names(finalResultActySub), pattern = "mean", replacement = "Mean") 
  names(finalResultActySub) <- gsub(x = names(finalResultActySub), pattern = "std", replacement = "StandardDeviation")
  names(finalResultActySub) <- gsub(x = names(finalResultActySub), pattern = "BodyBody", replacement = "Body") 
  
  
  #5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  write.table(finalResultActySub %>% group_by(Subject, Activity) %>% summarise_all(funs(mean)), file = "Cleaned_DataSet.txt", row.names = FALSE)
  
}
run_analysis()