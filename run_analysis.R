# Download the data as a zip file if you don't already have it downloaded
if(!file.exists("data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip", method = "curl")  
}
# Unzip the data if it isn't already unzipped
if(!file.exists("UCI HAR Dataset")) {
  unzip("data.zip")
}

# read in the features and find the indices for the relevant features
features <- read.table("UCI HAR Dataset/features.txt")
means <- grep("mean\\(\\)", features$V2)
stds <- grep("std\\(\\)", features$V2)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# read in training data and combine into a single table
all_training_data <- read.table("UCI HAR Dataset/train/X_train.txt")
all_training_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
training_activities <- sapply(all_training_labels[[1]], function(i) { activity_labels$V2[i == activity_labels$V1] })
training_data <- cbind(training_activities, all_training_data[,c(means,stds)])
training_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
training_data <- cbind(training_subjects, training_data)
# give the columns descriptive names
names(training_data)[1:2] <- list("subject", "activity")
names(training_data)[3:length(names(training_data))] <- as.list(as.character(features$V2[c(means,stds)]))

# read in test data and combine into a single table
all_test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
all_test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_activities <- sapply(all_test_labels[[1]], function(i) { activity_labels$V2[i == activity_labels$V1] })
test_data <- cbind(test_activities, all_test_data[,c(means,stds)])
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_data <- cbind(test_subjects, test_data)
# give the columns descriptive names
names(test_data)[1:2] <- list("subject", "activity")
names(test_data)[3:length(names(test_data))] <- as.list(as.character(features$V2[c(means,stds)]))

# combine the two datasets
data <- rbind(training_data, test_data)

# summarize the data data
library(dplyr)
data_tbl_df <- tbl_df(data)
summarized_data <- group_by(data_tbl_df, subject, activity) %>% summarize_each(funs(mean))
write.table(summarized_data, "summarized_data.txt", row.names = FALSE)
