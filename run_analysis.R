## Download the dataset
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destFile = "./data/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", method = "curl")

## Unzip the dataset
unzip("./data/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")

## Extracts only the measurements based on the mean and standard deviation
## By filtering limited data first, we may achieve memory efficiency also.
## 'features_info.txt': Shows information about the variables used on the feature vector.
## 'features.txt': List of all features.
## The set of variables that were estimated from these signals are: 
## mean(): Mean value,
## std(): Standard deviation

tempFeatures <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
requiedFeatures <- grep("mean|std", tempFeatures[, 2])
requiedFeaturesLabels <- tempFeatures[requiedFeatures, 2]

## Load the "Train" dataset and keep only those tuples based on 
## required features, mean() and std()
## 'train/X_train.txt': Training set.
## 'train/y_train.txt': Training labels.
trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
trainLabels <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
tempTrainSets <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainSets <- tempTrainSets[requiedFeatures]
dtTrain <- cbind(trainSubjects, trainLabels, trainSets)

## Load the "Test" dataset and keep only those tuples based on 
## required features, mean() and std()
## 'test/X_test.txt': Test set.
## 'test/y_test.txt': Test labels.
testSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
testLabels <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
tempTestSets <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testSets <- tempTestSets[requiedFeatures]
dtTest <- cbind(testSubjects, testLabels, testSets)

## Merge the required "Train" and "Test" datasets filtered in previous steps.
dtTrainAndTest <- rbind(dtTrain, dtTest)

## set the column names
colnames(dtTrainAndTest) <- c("subject", "activity", requiedFeaturesLabels)

## Using proper descriptive activity names and variable names (activity and subject)
## 'activity_labels.txt': Links the class labels with their activity name.
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
dtTrainAndTest$activity <- factor(dtTrainAndTest$activity, levels = activityLabels[, 1], labels = activityLabels[, 2])
dtTrainAndTest$subject <- as.factor(dtTrainAndTest$subject)

## creating an independent tidy data set
## library(reshape2) is required for melt function
library(reshape2)
dtTrainAndTest.melted <- melt(dtTrainAndTest, id = c("subject", "activity"))
dtTrainAndTest.mean <- dcast(dtTrainAndTest.melted, subject + activity ~ variable, mean)
write.table(dtTrainAndTest.mean, "./data/tidy.txt", quote = FALSE, row.names = FALSE)

## View final data
## data <- read.table("./data/tidy.txt", header = TRUE)
## View(data)
