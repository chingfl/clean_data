Getting and Clean Data Project

Ching Lai
April 28th, 2018

First, I downloaded the zipfile from the given URL and save it as a temporary file.

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(fileUrl,temp)

I then unzipped with the specified file name from the temporary zipped file I loaded earlier and 
the files into tables for both set of "test" and "train" files.

e.g.
subject_test <-read.table(unz(temp,"UCI HAR Dataset/test/subject_test.txt"))

I used the same method to load "features" and "activity labels"

After that is done, I removed temp file
unlink(temp)

Next, I added the column labels listed in the feature list to both the "test" and "train" tables

I added a new column named "subject" to align the subjects to the data for both "test" and "train".

I also added a new column for activity and loaded the descripted label name at the same time by mapping the y numeric labels
with the activity description in the activity table:

X_test$activity<- activity_labels[,2][y_test[,1]]
X_train$activity<- activity_labels[,2][y_train[,1]]

Finally, I merge the "test" and "train" table with rbind.

Now, I need to extract the mean and standard deviation measurements by searching for words "mean" or "std". 
This is accomplished by using the "grepl" to get a logical vector which can then be used to return the subset
of the list with only the mean and standard deviation.

meanstd_features <- grepl("mean|std",features[,2])
meanstd_mergedData <- mergedData[,meanstd_features]

To get the average of each variable for each activity and each subject, I use melt aand dcast. "melt" funciton is 
from reshape2 package and it take a set of columns into a single column as such:
  subject activity          variable     value
1       1 STANDING tBodyAcc-mean()-X 0.2885845
2       1 STANDING tBodyAcc-mean()-X 0.2784188
3       1 STANDING tBodyAcc-mean()-X 0.2796531
4       1 STANDING tBodyAcc-mean()-X 0.2791739
5       1 STANDING tBodyAcc-mean()-X 0.2766288
6       1 STANDING tBodyAcc-mean()-X 0.2771988

Now, I can use "dcast" to get the average for subject+activity with formula "subject+activity ~ variable".

I have output the result to file named "fityData.txt"
