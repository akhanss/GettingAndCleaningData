# Getting and Cleaning Data Course Project

* First of all, download the data (zip format) for the project from the given link.
* Then unzip the zipped data for further processing.
* After that filter only the measurements on the mean and standard deviation for each measurement from the features. According to the original files 'features_info.txt' and 'features.txt', mean() and std() refers to the Mean Value and Standard deviation, respectively.
* Later load the "Train" and "Test" dataset separately and keep only those tuples based on required features, mean() and std().
* Then merge the "Train" and "Test" datasets filtered in the previous step.
* Then set up the column names and performed descriptive activity names and variable names (activity and subject).
* Finally, create an independent tidy data set that consists of the mean value of each row.