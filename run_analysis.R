#set up the filenames
dataDir <- "UCI HAR Dataset"
featuresFilename <- paste(dataDir, "features.txt", sep="/")
activityLabelsFilename <- paste(dataDir, "activity_labels.txt", sep="/")
subjectTestDataFilename <- paste(dataDir, "test", "subject_test.txt", sep="/")
dataXTestDataFilename <- paste(dataDir, "test", "x_test.txt", sep="/")
dataYTestDataFilename <- paste(dataDir, "test", "y_test.txt", sep="/")
subjectTrainDataFilename <- paste(dataDir, "train", "subject_train.txt", sep="/")
dataXTrainDataFilename <- paste(dataDir, "train", "x_train.txt", sep="/")
dataYTrainDataFilename <- paste(dataDir, "train", "y_train.txt", sep="/")

#output filenames
tidyDataFilename <- "TidyData.txt"
tidyAverageDataFilename <- "AverageData.txt"

#get the list of meaningful variable names for the measurements
varNames <- read.table(featuresFilename)
varNames <- varNames[,2]

#get the list of meaningful activity labels
activityLabels <- read.table(activityLabelsFilename, 
                            col.names=c("activityId", "activityName"))

#Load the subject test data
dataSubjectTest <-read.table(subjectTestDataFilename, col.names="subjectId")
dataXTest <-read.table(dataXTestDataFilename, col.names=varNames)
dataYTest <-read.table(dataYTestDataFilename, col.names="activityId")

#Load the subject training data
dataSubjectTrain <- read.table(subjectTrainDataFilename, col.names="subjectId")
dataXTrain <-read.table(dataXTrainDataFilename, col.names=varNames)
dataYTrain <-read.table(dataYTrainDataFilename, col.names="activityId")

#merge the test and training data
dataTest <- cbind(dataSubjectTest, dataYTest, dataXTest)
dataTrain <- cbind(dataSubjectTrain, dataYTrain, dataXTrain)
dataAll <- rbind(dataTest, dataTrain)
dataMerged <- merge(activityLabels, dataAll, 
                    by.x="activityId", by.y="activityId", all=TRUE)

#now, get the required variables(only mean and standard deviation variables)
namesMean <- grep("mean()", varNames, fixed=TRUE)
namesStd <- grep("std()", varNames, fixed=TRUE)

columnsTidy <- c(-1, 0, namesMean, namesStd)
dataTidy <- dataMerged[, columnsTidy + 2]

#write the new data to a file
write.table(dataTidy, file=tidyDataFilename, sep=" ", row.names=FALSE, append=FALSE)

#aggregate data and find average of each measurement, group by activityId, activityName, subjectId
dt <- as.data.table(dataTidy)
dataAverage <- dt[, lapply(.SD, mean), by=list(activityId, activityName, subjectId)]

#write the new average data to a file
write.table(dataAverage, file=tidyAverageDataFilename, sep=" ", row.names=FALSE, append=FALSE)
