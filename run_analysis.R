#Peer-graded Assignment: Getting and Cleaning Data Course Project

# require packages
require("data.table")
require("reshape2")

# download file from given URL

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
he
temp <- tempfile()

download.file(fileUrl,temp)

# unzip and load test data
subject_test <-read.table(unz(temp,"UCI HAR Dataset/test/subject_test.txt"))
X_test <-read.table(unz(temp,"UCI HAR Dataset/test/X_test.txt"))
y_test <-rheadead.table(unz(temp,"UCI HAR Dataset/test/y_test.txt"))

# unzip and load train data
subject_train <-read.table(unz(temp,"UCI HAR Dataset/train/subject_train.txt"))
X_train <-read.table(unz(temp,"UCI HAR Dataset/train/X_train.txt"))
y_train <-read.table(unz(temp,"UCI HAR Dataset/train/y_train.txt"))

# unzip and load features and activity labels
features <-read.table(unz(temp,"UCI HAR Dataset/features.txt"))
activity_labels <- read.table(unz(temp,"UCI HAR Dataset/activity_labels.txt"))

# remove temp file
unlink(temp)

# add column names to test and train table
colnames(X_train) <- t(features[2])
colnames(X_test) <- t(features[2])

# align the subject to the data
X_train$subject <- subject_train[,1]
X_test$subject <- subject_test[,1]

# align the activity to the data and use the descriptive names to name the activity
X_test$activity<- activity_labels[,2][y_test[,1]]
X_train$activity<- activity_labels[,2][y_train[,1]]

# merge the data set
mergedData <- rbind(X_train, X_test)

# extract only mean and standard deviation
meanstd_features <- grepl("mean|std",features[,2])
meanstd_mergedData <- mergedData[,meanstd_features]

# average ofeach variable for each activity and each subject
meltData <- melt(meanstd_mergedData,id=c("subject","activity"))
tidyData <- dcast(meltData, subject+activity ~ variable, mean)

# write data to a text file
write.table(tidyData, file="./tidyData.txt",row.names = FALSE)