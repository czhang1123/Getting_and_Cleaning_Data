# Getting and Cleaning Data Course Project

The objective of this course project is to prepare tidy data that can be used for later analysis.

## Background

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
<a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">

Here are the data for the project:
<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">

## Steps Taken to Tidy the Data

run_analysis.R has been created to do the following.

<ol>
<li>Merges the training and the test sets to create one data set. </li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement. </li>
<li>Uses descriptive activity names to name the activities in the data set </li>
<li>Appropriately labels the data set with descriptive variable names. </li>
<li>From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. </li>
</ol>

## Imprementation of the Steps to Tidy the Data

* Install and load R packages dplyr and data.table if not already.
* Change work directory to where the data resides.
* Read in both train and test data, combine all columns and all rows into a single data frame.
* Extract the indices associated with columns with mean() or std() in the name, using features.txt file, then extract these columns from the data frame.
* Label activities using activity_labels.txt.
* To appropriately labels the data set with descriptive variable names, remove special characters in field description in features.txt to use as column name.
* Get the average of each variable for each activity and each subject, and save in another data frame.








