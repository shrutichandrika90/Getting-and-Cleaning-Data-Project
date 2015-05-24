#Download the required files
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Project.zip")

#Step 1 
#1.Merge the test and the train data sets
#Read in the train files
x_train<-read.table("train\\X_train.txt")
y_train<-read.table("train\\Y_train.txt")
subject_train<-read.table("train\\subject_train.txt")

#Read in the test files
x_test<-read.table("test\\X_test.txt")
y_test<-read.table("test\\Y_test.txt")
subject_test<-read.table("test\\subject_test.txt")

#Create x data set
x<-rbind(x_train,x_test)

#Create y data set
y<-rbind(y_train,y_test)

#Create the subject data set
subject_data<-rbind(subject_train,subject_test)

#Step2
#2.Extracts only the measurements on the mean and standard deviation for each measurement

features<-read.table("features.txt")

#Extract columns only with mean() or std() in their names
mean_std<-grep("-(mean|std)\\(\\)",features[,2])

#Create a subset of the desired columns
x<-x[,mean_std]

#Correct the column names from the features data frame.
names(x)<-features[mean_std,2]

#Step3
#3.Uses descriptive activity names to name the activities in the data set

#Read in activities
activities<-read.table("activity_labels.txt")

#Modify the y data set to have the correct activity names
y[,1]<-activities[y[,1],2]

#Change column name to Activities
names(y)<-"Activities"

#Step4
#4.Appropriately labels the data set with descriptive variable names.

#Change the column name in subject_data to Subject
names(subject_data)<-"Subject"

#Combine the whole data set
Complete_data<-cbind(x,y,subject_data)

#Create new more readable variable names
Newvars= names(Complete_data)
Newvars <- gsub(pattern="^t",replacement="time",x=Newvars)
Newvars <- gsub(pattern="^f",replacement="freq",x=Newvars)
Newvars <- gsub(pattern="-?mean[(][)]-?",replacement="Mean",x=Newvars)
Newvars <- gsub(pattern="-?std[()][)]-?",replacement="Std",x=Newvars)
Newvars <- gsub(pattern="-?meanFreq[()][)]-?",replacement="MeanFreq",x=Newvars)
Newvars <- gsub(pattern="BodyBody",replacement="Body",x=Newvars)
names(Complete_data) <- Newvars

#Step5
#5.From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject
#Load plyr library for next step
library(plyr)

#Create final data set with mean for coloumns 1 to 66 for each Subject and each Activity
Final_Data<- ddply(Complete_data,.(Subject,Activities),function(x) colMeans(x[,1:66]))

#Write the final data set into a text file.
write.table(Final_Data,"Final_Data.txt",row.name=FALSE)