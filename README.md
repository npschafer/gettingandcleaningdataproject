This repository contains one script that downloads, organizes and summarizes the UCI HAR Dataset, which can be found at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R begins by downloading the data into a file called data.zip (if a file called data.zip is not already present in the working directory. It then unzips it if there is not already a subdirectory of the working directory called "UCI HAR Dataset".

In this case, we are interested in reading in the features with "mean()" and "std()" in their names, so run\_analysis.R uses the file "features.txt" to get the names of the features and extract the column indices of the desired features. "activity\_labels.txt" is also read so that, later in the analysis, we can give meaningful names to the activities being performed by the subjects while the measurements were occurring.

Two sets of data, "training" and "test" are read in identically. In both cases, the "X\_\*.txt" files contain the bulk of the data. Other files including "y\_\*.txt" and "subject_\*.txt" are also read in so that the final dataset contains the activity as well as the subject identifiers. Meaningful names are then asigned to all columns of the dataset. Finally, the two datasets are merged into a dataframe called simply "data".

A summary of the data is then performed using the dplyr R package. The observations are grouped by both subject and activity and then the mean of all 180 resulting groups are taken and stored in a tbl\_df object called "summarized\_data". This object is then written out to a text file called "summarized_data.txt".
