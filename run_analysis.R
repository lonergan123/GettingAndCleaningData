##run_analysis.R / Getting and Cleaning Data Course Project

##First, Set Working Directory
setwd("C:/Users/Kevin/SkyDrive/Documents/Personal/Coursera/Getting and Cleaning Data")

## Import Relavent Data Sets
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")

#Set Column Names
colnames(x_test) <- features[,2]
colnames(x_train) <- features[,2]
colnames(y_test) <- "activity"
colnames(y_train) <- "activity"
colnames(subject_test) <- "subject"
colnames(subject_train) <- "subject"

## Add Activity and Subject Labels
XYTest <- cbind(y_test, x_test)
XYTest <- cbind(subject_test, XYTest)
XYTrain <- cbind(y_train, x_train)
XYTrain <- cbind(subject_train, XYTrain)

## Combine/merge training and test sets
combined <-rbind(XYTest,XYTrain)

## Extract only the measurements on the mean and standard deviation for each measurement. 

meanstd <- combined[,c(1,2, grep("std",colnames(combined)), grep("mean",colnames(combined)))]

## clean up variable/column names
colnames(meanstd) <- tolower(colnames(meanstd))
colnames(meanstd) <- gsub("\\(\\)","", colnames(meanstd))
colnames(meanstd[,3:81]) <- sub("t","time-", colnames(meanstd[,3:81]))
colnames(meanstd[,3:81]) <- sub("f","frequency-", colnames(meanstd[,3:81]))

# Add descriptive activity names
meanstd$activity <- sub("1", "WALKING", meanstd$activity)
meanstd$activity <- sub("2", "WALKING_UPSTAIRS", meanstd$activity)
meanstd$activity <- sub("3", "WALKING_DOWNSTAIRS", meanstd$activity)
meanstd$activity <- sub("4", "SITTING", meanstd$activity)
meanstd$activity <- sub("5", "STANDING", meanstd$activity)
meanstd$activity <- sub("6", "LAYING", meanstd$activity)

##Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(reshape2)
melted = melt(meanstd, id.var = c("subject", "activity"))
tidydata = dcast(melted , subject + activity ~ variable,mean)
write.table(tidydata, file="TidyData.txt", sep = " ")