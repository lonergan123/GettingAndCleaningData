#Codebook

The following files were used in the script:
* features.txt - List of all features.
* train/X_train.txt - Training set.
* train/y_train.txt - Training labels.
* test/X_test.txt - Test set.
* test/y_test.txt - Test labels.
* train/subject_train.txt - Each row identifies the subject who performed the activity for each window sample.
* test/subject_test.txt- Each row identifies the subject who performed the activity for each window sample.

#Assumptions
* meanfreq variables were included as it wasn't explicity clear if these variables were needed or not.  It is much easier to remove variables then add them.  

#Information about Variables 
* Subject: contains the identifier of the subject or person
* activity: the activity / what the person was doing when the measurements were taken
* Others: the other variables represent the average of the all statistical measures for that subject / activity.  This is based on the calculation indicated in the column name (mean or standard deviation).

#Steps to Transform Data
The script:
* Loads data from UCI folder
* Cleans up column names 
* Uses cbind to add student and activity data
* Merge the training and test sets using rbind.
* Extract only the measurements on the mean and standard deviation for each measurement using grep.
* Replaces activity numbers in Activity column with descriptive activity names.
* use melt and dcast from reshape2 library to create a second, independent tidy data set with the average of each variable for each activity and each subject. 
* Writes tidy data to space separated text file called tidydata.txt.