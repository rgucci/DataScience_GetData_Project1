# DataScience_GetData_Project1

The original data for this project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data.table package is required to run this script
The data should be unzipped in the current working directory

The R script run_analysis.R will do the following:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- Write the combined tidy data set into a file "TidyCombined.txt" 
- From the combined data set in the previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Write the average tidy data set into a file "TidyAverage.txt"

See Codebook.MD for more details on the data set produced