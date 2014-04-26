##Codebook for run_analysis.R script
This is a codebook for the run_analysis.R script.
##Notes
Please make sure that PLYR package is installed as this script uses it. 
This code assumes all data is located in "getdata-projectfiles-UCI HAR Dataset" folder. The content of this folder should be identical to https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
##Description
This script merges the training and the test sets in one data set. It extracts only the measurements on the mean and standard deviation for each measurement. 
##Output
Two datasets are created: titydataaverage.txt and AllDataWithActivies.txt. Both files are tab separated.
* titydataaverage.txt - Contains average of each variable for each activity and each subject. Each column is an average.
* AllDataWithActivies.txt - Contains combined test and training data with measurements on the mean and standard deviation. 

##Code Explanation

The following steps were followed to create a tidy datasets.  

* Loading list of variable names. It will be used for selecting only standard deviation and mean measurements

```
varnames  <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
```
* Creating a character vector with variable names

```
varnameschar=as.character(varnames$V2)
```
* Creating an empty vector. It will be used for assigning NULL for values which should not be loaded

```
names=character()
```
* Selecting variable which have mean and standard deviation values

```
vector=rep("NULL",nrow(varnames))
for(i in 1:nrow(varnames)){
  names[i]=varnameschar[i]
  if(grepl("mean\\()",varnameschar[i]) | grepl("std\\()",varnameschar[i])){   
    vector[i]="numeric"
  }
}
```
* Loading test data and changing column names for subject and activity data

```
X_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",colClasses=vector,col.names=names,check.names="false")
y_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
colnames(y_test)<-"testtype"
subject_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test)<-"subject"
```
* Bilding test data

```
test<-cbind(subject_test,y_test,X_test)
```
* Loading train data and changing column names for subject and activity data

```
X_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",colClasses=vector,col.names=names,check.names="false") 
y_train  <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt") 
colnames(y_train)<-"testtype" 
subject_train  <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt") 
colnames(subject_train)<-"subject"
```
* Bilding test data
```
train<-cbind(subject_train,y_train,X_train)
```
* Combining all data together

```
all_data<-rbind(test,train)
```
* Adding activity names by mergind activity names using testtype column

```
activities <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt") 
colnames(activities)[1]<-"testtype" 
colnames(activities)[2]<-"activity" 
AllDataWithActivies<-merge(all_data,activities,by="testtype")
```
* Removing the codes of activities

```
myvars <- names(AllDataWithActivies) %in% c("testtype")  
AllDataWithActivies <-  AllDataWithActivies[!myvars]
```
* Creating tidy dataset with averages
```
titydataaverage=ddply(AllDataWithActivies, .(subject,activity), numcolwise(mean))
```

* Exporting data tab separated

```
write.table(AllDataWithActivies, file="./AllDataWithActivies.txt", sep="\t", row.names=FALSE) 
write.table(titydataaverage, file="./titydataaverage.txt", sep="\t", row.names=FALSE)
```


##Variables 
* Subject - Subject ID
* Activity - Activity performed by subject 
* tBodyAcc-mean()-X - mean value of the mean measurement on the X axis 
* tBodyAcc-mean()-Y - mean value of the mean measurement on the Y axis 
* tBodyAcc-mean()-Z - mean value of the mean measurement on the Z axis
* tBodyAcc-std()-X - mean value of the standard deviation of the measurement on the X axis 
* tBodyAcc-std()-Y - mean value of the standard deviation of the measurement on the Y axis 
* tBodyAcc-std()-Z - mean value of the standard deviation of the measurement on the Z axis 
* tGravityAcc-mean()-X - mean value of the mean measurement on the X axis 
* tGravityAcc-mean()-Y - mean value of the mean measurement on the Y axis 
* tGravityAcc-mean()-Z - mean value of the mean measurement on the Z axis
* tGravityAcc-std()-X - mean value of the standard deviation of the measurement on the X axis 
* tGravityAcc-std()-Y - mean value of the standard deviation of the measurement on the Y axis 
* tGravityAcc-std()-Z - mean value of the standard deviation of the measurement on the Z axis
* tBodyAccJerk-mean()-X - mean value of the mean measurement on the X axis 
* tBodyAccJerk-mean()-Y - mean value of the mean measurement on the Y axis 
* tBodyAccJerk-mean()-Z - mean value of the mean measurement on the Z axis 
* tBodyAccJerk-std()-X - mean value of the standard deviation of the measurement on the X axis 
* tBodyAccJerk-std()-Y - mean value of the standard deviation of the measurement on the Y axis 
* tBodyAccJerk-std()-Z - mean value of the standard deviation of the measurement on the Z axis 
* tBodyGyro-mean()-X - mean value of the mean measurement on the X axis 
* tBodyGyro-mean()-Y - mean value of the mean measurement on the Y axis 
* tBodyGyro-mean()-Z - mean value of the mean measurement on the Z axis 
* tBodyGyro-std()-X - mean value of the standard deviation of the measurement on the X axis 
* tBodyGyro-std()-Y - mean value of the standard deviation of the measurement on the Y axis 
* tBodyGyro-std()-Z - mean value of the standard deviation of the measurement on the Z axis 
* tBodyGyroJerk-mean()-X - mean value of the mean measurement on the X axis 
* tBodyGyroJerk-mean()-Y - mean value of the mean measurement on the Y axis 
* tBodyGyroJerk-mean()-Z - mean value of the mean measurement on the Z axis 
* tBodyGyroJerk-std()-X - mean value of the standard deviation of the measurement on the X axis 
* tBodyGyroJerk-std()-Y - mean value of the standard deviation of the measurement on the Y axis 
* tBodyGyroJerk-std()-Z - mean value of the standard deviation of the measurement on the Z axis
* tBodyAccMag-mean() - mean value of the mean measurement 
* tBodyAccMag-std() - mean value of the standard deviation of the measurement 
* tGravityAccMag-mean() - mean value of the mean measurement
* tGravityAccMag-std() - mean value of the standard deviation of the measurement
* tBodyAccJerkMag-mean() - mean value of the mean measurement
* tBodyAccJerkMag-std() - mean value of the standard deviation of the measurement
* tBodyGyroMag-mean() - mean value of the mean measurement
* tBodyGyroMag-std() - mean value of the standard deviation of the measurement
* tBodyGyroJerkMag-mean() - mean value of the mean measurement
* tBodyGyroJerkMag-std() - mean value of the standard deviation of the measurement
* fBodyAcc-mean()-X - mean value of the mean measurement on the X axis
* fBodyAcc-mean()-Y - mean value of the mean measurement on the Y axis 
* fBodyAcc-mean()-Z - mean value of the mean measurement on the Z axis 
* fBodyAcc-std()-X - mean value of the standard deviation of the measurement on the X axis
* fBodyAcc-std()-Y - mean value of the standard deviation of the measurement on the Y axis 
* fBodyAcc-std()-Z - mean value of the standard deviation of the measurement on the Z axis 
* fBodyAccJerk-mean()-X - mean value of the mean measurement on the X axis
* fBodyAccJerk-mean()-Y - mean value of the mean measurement on the Y axis 
* fBodyAccJerk-mean()-Z - mean value of the mean measurement on the Z axis 
* fBodyAccJerk-std()-X - mean value of the standard deviation of the measurement on the X axis
* fBodyAccJerk-std()-Y - mean value of the standard deviation of the measurement on the Y axis
* fBodyAccJerk-std()-Z - mean value of the measurement on the Z axis 
* fBodyGyro-mean()-X - mean value of the mean measurement on the X axis
* fBodyGyro-mean()-Y - mean value of the mean measurement on the Y axis 
* fBodyGyro-mean()-Z - mean value of the mean measurement on the Z axis 
* fBodyGyro-std()-X - mean value of the standard deviation of the measurement on the X axis
* fBodyGyro-std()-Y - mean value of the standard deviation of the measurement on Y axis
* fBodyGyro-std()-Z - mean value of the standard deviation of the measurement on the Z axis
* fBodyAccMag-mean() - mean value of the mean measurement
* fBodyAccMag-std() - standard deviation value of the measurement
* fBodyBodyAccJerkMag-mean() - mean value of the mean measurement
* fBodyBodyAccJerkMag-std() - standard deviation value of the measurement
* fBodyBodyGyroMag-mean() - mean value of the mean measurement
* fBodyBodyGyroMag-std() - standard deviation value of the measurement
* fBodyBodyGyroJerkMag-mean() - mean value of the mean measurement
* fBodyBodyGyroJerkMag-std() - standard deviation value of the measurement
