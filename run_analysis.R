########################## GETTING AND CLEANING DATA ##############################
###################################################################################

                      #  CLASS PROJECT  #  

###################################################################################
rm(list=ls())
#if (!file.info("HARUS Dataset")$isdir) {
  dataFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  dir.create("HAR")
  download.file(dataFile, "HAR/UCI-HAR-dataset.zip", method="curl")
  unzip("HAR/UCI-HAR-dataset.zip")
#}

# 1. Merges the training and the test sets 
features <- read.table("./UCI HAR Dataset/features.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
X <- rbind(X_test, X_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features_12 <- features[grep("(mean|std)\\(", features[,2]),]
mean_std <- X[,features_12[,1]]

# 3. Uses descriptive activity names to name the activities in the data set
act_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
act_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
y <- rbind(act_test, act_train)
str(y)

labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
for (i in 1:nrow(labels)) {
  code_num <- as.numeric(labels[i, 1])
  name_num <- as.character(labels[i, 2])
  y[y$activity == code_num, ] <- name_num
}

# 4. descriptive activity names. 
X_labels <- cbind(y, X)
mean_std_labels <- cbind(y, mean_std)

# 5. independent tidy data set with the average of each variable 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))
subject <- rbind(subject_test, subject_train)
averages <- aggregate(X, by = list(activity = y[,1], subject = subject[,1]), mean)

write.csv(averages, file='GCD_Results.txt', row.names=FALSE)