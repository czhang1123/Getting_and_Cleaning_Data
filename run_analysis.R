
#####################################################################
## Getting and Clearning Data Course Project
## The code run_analysis.R does the following:
## 1.	Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.	Uses descriptive activity names to name the activities in the data set
## 4.	Appropriately labels the data set with descriptive variable names.
## 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#####################################################################

## change work directory to where the data resides

library(dplyr)
library(data.table)

## Read in all data

X_train <- read.table('./train/X_train.txt', header = F) # 7352 x 561
y_train <- read.table('./train/y_train.txt', header = F)
subject_train <- read.table('./train/subject_train.txt', header = F)

X_test <- read.table('./test/X_test.txt', header = F) # 2947 x 561
y_test <- read.table('./test/y_test.txt', header = F)
subject_test <- read.table('./test/subject_test.txt', header = F)


## 1.	Merges the training and the test sets to create one data set.

y <- rbind(y_train, y_test)
y <- rename(y, y = V1)

subject <- rbind(subject_train, subject_test)
subject <- rename(subject, subject = V1)

x<- rbind(X_train, X_test)

alldata <- cbind(subject, y, x)
str(alldata)


## 2.	Extracts only the measurements on the mean and standard deviation for each measurement.

# find the column indices for all variables with mean() or std() in the name, using features.txt
features <- read.table('./features.txt', header = F)
MeanStdColIndices <- features[grep('mean\\(\\)|std\\(\\)', features$V2), 'V1']

# then extract these columns from the dataset
MeanStdCols <- gsub(' ', '', paste('V',as.character(MeanStdColIndices)), fixed = T)
onlyMeanStd <- alldata[, c('subject', 'y', MeanStdCols)]
str(onlyMeanStd)


## 3.	Uses descriptive activity names to name the activities in the data set

# label activities using activity_labels.txt
activity.labels <- read.table('./activity_labels.txt', header = F)

setnames(activity.labels, old = 1:2, new = c('y', 'activity'))

cleandata <- merge(activity.labels, onlyMeanStd, by = 'y')
cleandata <- cleandata[, c(3, 2, 4:ncol(cleandata))]


## 4.	Appropriately labels the data set with descriptive variable names.

# can use the field description in features.txt as column name, but need to remove the special characters
colnames <- features[MeanStdColIndices,]
colnames$V2 <- gsub('\\-', '\\.', gsub('\\(\\)', '', colnames$V2))

# labels the data set with descriptive variable names
setnames(cleandata, old = 3:ncol(cleandata), new = colnames$V2)


## 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata<-
    (cleandata %>%
        group_by(activity, subject) %>%
            summarise_each(funs(mean))
    )

write.table(tidydata, './TidyData.txt')

