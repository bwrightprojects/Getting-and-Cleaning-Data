Getting and Cleaning Data Course Project Code Book
===================================================

This file outlines the data, variables and transformations performed to clean the data and produce a tidy data set.

**Source of the original data** 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**Original description** 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

****************

**The _run_analysis.R_ script performs the following steps to clean up the data**

* Merge Training and Test data sets
   * Merges the training (**_./UCI HAR Dataset/train/X_train.txt_**) and test (**_./UCI HAR Dataset/test/X_test.txt_**) sets to create one data set resulting in a 10299X561 data frame.
   * Merges the training (**_./UCI HAR Dataset/train/Y_train.txt_**) and test(**_./UCI HAR Dataset/test/Y_test.txt_**) sets to create one data set resulting in a 10299X1 data frame.
   * Merges the subjects (**_./UCI HAR Dataset/train/subject_train.txt_**) and test (**_./UCI HAR Dataset/test/subject_text.txt_**) sets to create one data set resulting in a 10299X1 data frame.

* Read the features.txt file from the **_./UCI HAR Dataset_** folder and stores the data in a variable called *features*. Then extracts only the mean and standard deviation. The result is a 10299x66 data frame. Finally subsets the dataset with the 66 corresponding columns.


* Reads **_./UCI HAR Dataset/activity_labels.txt_** and applies descriptive activity names to name the activities in the data set:

       > walking
        
       > walkingupstairs
        
       > walkingdownstairs
        
       > sitting
        
       > standing
        
       > laying

* Clean the activity names in the second column of activity. Make all names lower case for readabilty. Remove the underscore and brackets ().  Merge the 10299X66 data frame containing features with the 10299X1 data frames containing the activity labels and the subject Id’s.  The result is saved to disk as *cleaned_merged_data.txt*. first column contains the Subject Id’s, next the activity names and the remaining 66 columns are the measurements.  Attribute will look like the following:


       > tbodyacc-mean-x 
        
       > tbodyacc-mean-y 
        
       > tbodyacc-mean-z 
        
       > tbodyacc-std-x 
        
       > tbodyacc-std-y 
        
       > tbodyacc-std-z 
        
       > tgravityacc-mean-x 
        
       > tgravityacc-mean-y
       
       > Etc ....


*  The final step of the script creates a new independent tidy data set with the average of each measurement for each activity and each subject. The results are saved to disk as *dataset_averages_means.txt*.  The size of the data frome is 180x68.  The first column is the Subject Id’s, the next column contains activity names and then the averages for each of the 66 attributes are in remaining 66 columns as stated above.

