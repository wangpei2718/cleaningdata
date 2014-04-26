cleaningdata
============

Project for Getting and Cleaning Data

##run_analysis.R Explanation

This script merges the training and the test sets in one data set. It extracts only the measurements on the mean and standard deviation for each measurement.

Two datasets are created: titydataaverage.txt and AllDataWithActivies.txt. Both files are tab separated.
* titydataaverage.txt - Contains average of each variable for each activity and each subject. Each column is an average.
* AllDataWithActivies.txt - Contains combined test and training data with measurements on the mean and standard deviation. 
Place the script to the folder which contains a subforder "\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset" with provided data.

Input files to the scripts should be named and located in the following manner:

* [SCRIPT LOCATION HERE]\getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt
* [SCRIPT LOCATION HERE]\getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt
* [SCRIPT LOCATION HERE]\getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt
* [SCRIPT LOCATION HERE]\getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt
* [SCRIPT LOCATION HERE]\getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt
* [SCRIPT LOCATION HERE]\getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt
* [SCRIPT LOCATION HERE]\getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt
* [SCRIPT LOCATION HERE]\getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt

Please make sure that PLYR package is installed as this script uses it.

Code and variable explanation can be found in the CodeBook.md. 

