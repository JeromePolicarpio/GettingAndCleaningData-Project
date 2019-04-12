The run_analysis.R script performs the data downloading and cleaning process of the UCI HAR Dataset as described in the project instruction.

# Data Wrangling Steps
## 1. Download the dataset
* Dataset were downloaded and extracted from UCI HAR Dataset which is available on this site http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## 2. Assign each data to variables
  * subject_test <- Extracted from UCI HAR Dataset/test/subject_test.txt 
      - with 2947 rows and 1 column; these are test data of 9/30 volunteer test subjects being observed
  * x_test <- Extracted from UCI HAR Dataset/test/X_test.txt
      - with 2947 rows and 561 columns; these are recorded data of different features from test data samples
  * y_test <- Extracted from UCI HAR Dataset/test/y_test.txt 
      - with 2947 rows and 1 column; these are activities code labels from test data samples
      
  * subject_train <- Extracted from UCI HAR Dataset/test/subject_train.txt
      - with 7352 rows and 1 column; these are train data of 21/30 volunteer subjects being observed
  * x_train <- Extracted from UCI HAR Dataset/test/X_train.txt
      - with 7352 rows and 561 column; these are recorded data of features from the train data samples
  * y_train <- Extracted from UCI HAR Dataset/test/y_train.txt
      - with 7352 rows and 1 column; these are activities code labels from train data samples
  
  * features <- features.txt : 561 rows, 2 columns 
      The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
  * activities <- activity_labels.txt : 6 rows, 2 columns 
      List of activities performed when the corresponding measurements were taken and its codes (labels)

## 3. Merge the test and the train data sets to create one data set
  * xDataset (10299 rows, 561 columns)-created by merging x_train and x_test using rbind() function
  * yDataset (10299 rows, 1 column) - created by merging y_train and y_test using rbind() function
  * subjectDataset (10299 rows, 1 column) - created by merging subject_train and subject_test using rbind() function

## 4 Extract only the mean and standard deviation only for each measurement
  * select_mean_std (10299 rows, 66 columns) - created by subsetting xDataset, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

## 5 Use descriptive activity names to name the activities in the data set
  * allData (10299 rows, 68 columns) - created by merging yDataset, subjectDataset and select_mean_std using cbind() function
  * yDataset column was named with "Activity" and subjectDataset was named with "Subject"

## 6 Appropriately labels the data set with descriptive variable names
  * Entire column names of the select_mean_std (common to the allData) were placed with corresponding features name. 
      - All mean in column’s name replaced by Mean
      - All std in column’s name replaced by StandardDeviation
      - All t in column’s name replaced by TimeDomain
      - All f in column’s name replaced by FrequencyDomain      
      - All Freq in column’s name replaced by Frequency
      - All Acc in column’s name replaced by Acceleration
      - All Mag in column’s name replaced by Magnitude   
      - All Gyro in column’s name replaced by AngularSpeed
      - All GyroJerk in column’s name replaced by AngularAcceleration        

## 7 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  * tidydata (180 rows, 68 columns) was created by sumarizing allData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
  * Export tidydata into tidydata.txt file.
  
  
