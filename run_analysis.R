## Load relevant libraries
library(dplyr)

## Download zip file into working directory and unzip

data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data_url, "SamsungDataSet.zip", method = "curl")
unzip("SamsungDataSet.zip")

## Load data to data frames

x_test_data <- read.table(file.path(getwd(), "UCI HAR Dataset/test/X_test.txt"))
y_test_data <- read.table(file.path(getwd(), "UCI HAR Dataset/test/Y_test.txt"))
x_train_data <- read.table(file.path(getwd(), "UCI HAR Dataset/train/X_train.txt"))
y_train_data <- read.table(file.path(getwd(), "UCI HAR Dataset/train/Y_train.txt"))
features <- read.table(file.path(getwd(), "UCI HAR Dataset/features.txt"))
subject_test <- read.table(file.path(getwd(), "UCI HAR Dataset/test/subject_test.txt"))
subject_train <- read.table(file.path(getwd(), "UCI HAR Dataset/train/subject_train.txt"))
activity_labels <- read.table(file.path(getwd(), "UCI HAR Dataset/activity_labels.txt"))
  
## Apply label names to columns in x_data from features data
names(x_test_data) <- features[,2]
names(x_train_data) <- features[,2]

## Apply label names to subject & y data
names(subject_test) <- c("Subject_ID")
names(subject_train) <- c("Subject_ID")

names(y_test_data) <- c("Activity_ID")
names(y_train_data) <- c("Activity_ID")

## Merge subject, activity, x data together
test_data <- cbind(subject_test, y_test_data, x_test_data)
train_data <- cbind(subject_train, y_train_data, x_train_data)

## Merge x & y data together
train_test_data <- rbind(test_data, train_data)

## Get indexes with mean & std data
indexes <- grep("std\\(|mean\\(",(names(train_test_data)))

## Extract Subject ID, Activity ID & mean & std data
std_mean_data <- select(train_test_data, 1, 2, indexes)

## Change activity IDs to descriptive names
std_mean_data$Activity_ID <- activity_labels$V2[match(std_mean_data$Activity_ID, activity_labels$V1)]

## Clean variable names
names(std_mean_data) <- gsub("^f", "Frequency_Domain_", names(std_mean_data))
names(std_mean_data) <- gsub("^t", "Time_Domain_", names(std_mean_data))
names(std_mean_data) <- gsub("-([A-Z])", "_\\1_Axis", names(std_mean_data))
names(std_mean_data) <- gsub("-mean\\(\\)", "_Mean", names(std_mean_data))
names(std_mean_data) <- gsub("-std\\(\\)", "_Standard_Deviation", names(std_mean_data))

## Create final data set with summary by mean
summary_data <- std_mean_data %>%
  group_by(Subject_ID, Activity_ID) %>%
  summarise_all(mean)

## Write data frame to txt file
write.table(summary_data, "summary_data.txt", row.name=FALSE)