# 
# Source data for this project:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


# A full description is available at the site where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.

# setwd("../Project")
# projurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# projfile <- file.path(getwd(), "Dataset.zip")
# download.file(projurl, projfile, method = "curl")

# create combined sets and reuse tmp vars to save memory

tmpDS <- read.table("UCI HAR Dataset/train/X_train.txt")
tmpDL <- read.table("UCI HAR Dataset/test/X_test.txt")
X_TestTrain <- rbind(tmpDS, tmpDL)

tmpDS <- read.table("UCI HAR Dataset/train/y_train.txt")
tmpDL <- read.table("UCI HAR Dataset/test/y_test.txt")
Y_TestTrain <- rbind(tmpDS, tmpDL)

tmpDS <- read.table("UCI HAR Dataset/train/subject_train.txt")
tmpDL <- read.table("UCI HAR Dataset/test/subject_test.txt")
S_TestTrain <- rbind(tmpDS, tmpDL)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Read the features.txt containing a list all features
features <- read.table("UCI HAR Dataset/features.txt")
idx_goodFeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

# Add idx_goodFeatures column
X_TestTrain <- X_TestTrain[, idx_goodFeatures]
names(X_TestTrain) <- features[idx_goodFeatures, 2]

# use gSub to remove () and make all lower case
names(X_TestTrain) <- gsub("\\(|\\)", "", names(X_TestTrain))
names(X_TestTrain) <- tolower(names(X_TestTrain))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y_TestTrain[,1] = activities[Y_TestTrain[,1], 2]
names(Y_TestTrain) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S_TestTrain) <- "subject"
cleanDataset <- cbind(S_TestTrain, Y_TestTrain, X_TestTrain)
write.table(cleanDataset, "clean_merged_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects <- unique(S_TestTrain)[,1]
numSubjects <- length(unique(S_TestTrain)[,1])
numActivities <- length(activities[,1])
numCols <- dim(cleanDataset)[2]
result <- cleanDataset[1:(numSubjects*numActivities), ]

row <- 1
for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
                result[row, 1] = uniqueSubjects[s]
                result[row, 2] = activities[a, 2]
                tmp <- cleanDataset[cleanDataset$subject==s & cleanDataset$activity==activities[a, 2], ]
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}
write.table(result, "dataset_averages_means.txt", row.name=FALSE)
