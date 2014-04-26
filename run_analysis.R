#Loading list of variable names. It will be used for selecting only standard deviation and mean measurements
varnames  <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

#Creating a character vector with variable names
varnameschar=as.character(varnames$V2)

#Creating an empty vector. It will be used for assigning NULL for values which should not be loaded
names=character()

#Selecting variable wich have mean and standard deviation values
vector=rep("NULL",nrow(varnames))
for(i in 1:nrow(varnames)){
  names[i]=varnameschar[i]
  if(grepl("mean\\()",varnameschar[i]) | grepl("std\\()",varnameschar[i])){   
    vector[i]="numeric"
  }
}

#Loading test data and changing column names for subject and activity data
X_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",colClasses=vector,col.names=names,check.names="false")
y_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
colnames(y_test)<-"testtype"
subject_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test)<-"subject"
#Bilding test data
test<-cbind(subject_test,y_test,X_test)
#Loading train data and changing column names for subject and activity data
X_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",colClasses=vector,col.names=names,check.names="false")
y_train  <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
colnames(y_train)<-"testtype"
subject_train  <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train)<-"subject"
#Bilding test data
train<-cbind(subject_train,y_train,X_train)
#Combining all data together
all_data<-rbind(test,train)
#Adding activity names by mergind activity names using testtype column
activities <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
colnames(activities)[1]<-"testtype"
colnames(activities)[2]<-"activity"
AllDataWithActivies<-merge(all_data,activities,by="testtype")
#Removing the codes of activities
myvars <- names(AllDataWithActivies) %in% c("testtype") 
AllDataWithActivies <-  AllDataWithActivies[!myvars]
#Creating tidy dataset with averages
titydataaverage=ddply(AllDataWithActivies, .(subject,activity), numcolwise(mean))
#Exporting data tab separated
write.table(AllDataWithActivies, file="./AllDataWithActivies.txt", sep="\t", row.names=FALSE)
write.table(titydataaverage, file="./titydataaverage.txt", sep="\t", row.names=FALSE)