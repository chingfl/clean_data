CodeBook for the tidy dataset
===================================

DATA Source:
---------------
The Original data is coming from this site:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The description of the data set is from this site:
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Set Explanation:
-----------------------
X_test.txt contains the feature test data variables generated by the 30% of the volunteer subjects.
y_test.txt contains the activities carried out for the experiment. Each row is corresponding to a row in the test dataset.
subject_test.txt contains the subjects of the experiment who generate the test data. Each record in the X_test.txt
is corresponding to a subject performing a activity.

X_train.txt contains the feature train data variables generated by the 70% of the volunteer subjects.
y_train.txt contains the activities carried out for the experiment. Each row is corresponding to a row in the X_train dataset.
subject_train.txt contains the subjects of the experiment who generate the train data. Each record in the X_train.txt
is corresponding to a subject performing a activity.

features.txt contains the feature labels(header) for each column of the feature data collected in X_test.txt and X_train.txt.
activity_labels contains the activity labels.

Data Loading:
----------------------

subect_test.txt is read into a table named subject_test
X_test.txt is read into a table named X_test
y_test.txt is read into a table named y_test

subect_train.txt is read into a table named subject_train
X_train.txt is read into a table named X_train
y_train.txt is read into a table named y_train

features.txt is read into table features.
activity_labels.txt is read into table activity_labels.

Data Transformation:
----------------------
The features data was first loaded with their label. 
The subjects are added to both the train and test feature tables respectively as a new column with "subject" as the new header.
The activities are added to both the train and test feature tables respectively as a new column with "activity" as the new header. 
At the same time, the activity would be mapped to the descriptive activity labels.

The two train and test feature tables are now complete with tranformation. 
The train and test feature tables are merged to create "mergedData"
The meanstd_mergedData table is created by filtering with columns containing std or mean. 

The new table metlData is created to stack the data into subject, activity, variable, value. 
Finelly the tidyData table is created with the average values for each subject+activity by feature.
 