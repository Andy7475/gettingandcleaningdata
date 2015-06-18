# For Course Project - Getting and Cleaning Data
# 18 June 2015

#Step 1 - merge training and test data set
X_train <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"") # import training data
X_test <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"") # import test data
y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"") # the activity labels for train set
y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"") # the activity labels for test set
subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt", quote="\"") # subject ID for test data
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt", quote="\"") # subject ID for train data

df.train <- cbind(X_train,y_train,subject_train) # merge the training data together, adding activity labels and subject ID
df.test <- cbind(X_test,y_test,subject_test) # merge the test data together, adding activity labels and subject ID

# the data sets are equivalent (same columns etc.) so we can just add the rows to each other
df <- rbind(df.train,df.test) # the complete data set

#Step 2 - extract mean and standard deviation for each measurement - i.e. name the columns, and extract ones with mean and stdev info in
# read in the features list

features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"")
#reads in the variables names from the features.txt file

#applies names to each column (this is an output for Step 4 also in the course project)
names(df)[1:561] <- as.character(features[,2])
names(df)[562] <- "activityLabel"
names(df)[563] <- "subject"
library(stringr) # load stringr library

char.features <- as.character(features[,2]) # create a character vector of the features
mean.or.std<- str_detect(char.features, ignore.case("mean|std")) # selects all features that have mean or std in the title
df2 <- df[mean.or.std] # creates the data frame of only mean or std values - note activivtyLabel and subject are still passed over in this call

#Step 3 - uses descriptive activity labels (from activity_labels.txt file)
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING

df2$activityLabel <- as.factor(df2$activityLabel) # convert to a factor
levels(df2$activityLabel) <-c("Walking","Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying") # apply descriptive labels, they will match properly as they are written in numerical order

#Step 4 - apply variable names to data frame (data set already labelled using code in Step 3 - code repeated here for convenience)

#names(df)[1:561] <- as.character(features[,2])
#names(df)[562] <- "activityLabel"
#names(df)[563] <- "subject"

#Step 5 - extract tidy data set with mean for each subject and activity combination
library(plyr) # load plyr package
library(reshape2) # load reshape 2 package
df2$subject <- as.factor(df2$subject) # change subject to a factor as it represents a categorical variable
df2.melt <- melt(df2,id.vars=87:88) # melt the dataframe, using subject and activity labels as id variables
tidy.df<- ddply(df2.melt,.(subject,activityLabel,variable),summarise,mean=mean(value)) # get a row for each subject-activity-variable combination and find the mean

#course project output - write a text file
write.table(tidy.df,row.names=FALSE,file="tidy_data.txt")
