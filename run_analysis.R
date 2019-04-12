### Requirement 1 -  Merges the training and the test sets to create one data set.
library(data.table)
# Downloading the datasets
# Checking if archieve already exists.
if (!file.exists("./UCI HAR Dataset.zip")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, "./UCI HAR Dataset.zip", method="curl")
        }  

# Checking if directory exists and file unzipping
if (!file.exists("./UCI HAR Dataset")) {unzip("./UCI HAR Dataset.zip")}

# Reading the data from test data set
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

# Reading data from train data set
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

# Combining the test and train data sets
subjectDataset <- rbind(subject_test, subject_train)
xDataset <- rbind(x_test, x_train)
yDataset <- rbind(y_test, y_train)

### Requirement 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

select_mean_std <- xDataset[, grep("-(mean|std)\\(\\)", read.table("./UCI HAR Dataset/features.txt")[, 2])]
names(select_mean_std) <- read.table("./UCI HAR Dataset/features.txt")[grep("-(mean|std)\\(\\)", 
                                        read.table("./UCI HAR Dataset/features.txt")[, 2]), 2] 

### Requirement 3 - Uses descriptive activity names to name the activities in the data set
yDataset[, 1] <- read.table("./UCI HAR Dataset/activity_labels.txt")[yDataset[, 1], 2]
names(yDataset) <- "Activity"

### Requirement 4 - Appropriately labels the data set with descriptive variable names.
names(subjectDataset) <- "Subject"
summary(subjectDataset)

# Organizing and combining all data sets (mean & std, y, subject)
allData <- cbind(yDataset, subjectDataset, select_mean_std)

# Replacing the names in the "alldata" dataset with names from the activity labels
names(allData) <- make.names(names(allData))
names(allData) <- gsub('\\.mean',".Mean",names(allData))
names(allData) <- gsub('\\.std',".StandardDeviation",names(allData))
names(allData) <- gsub('^t',"TimeDomain.",names(allData))
names(allData) <- gsub('^f',"FrequencyDomain.",names(allData))
names(allData) <- gsub('Freq\\.',"Frequency.",names(allData))
names(allData) <- gsub('Freq$',"Frequency",names(allData))
names(allData) <- gsub('Acc',"Acceleration",names(allData))
names(allData) <- gsub('Mag',"Magnitude",names(allData))
names(allData) <- gsub('Gyro',"AngularSpeed",names(allData))
names(allData) <- gsub('GyroJerk',"AngularAcceleration",names(allData))

### Requirement #5 - From the data set in step 4, creates a second, independent tidy 
# data set with the average of each variable for each activity and each subject.
tidydata<-aggregate(. ~Subject + Activity, allData, mean)
tidydata<-tidydata[order(tidydata$Subject,tidydata$Activity),]
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)
