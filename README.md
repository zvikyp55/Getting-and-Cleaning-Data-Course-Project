# Getting-and-Cleaning-Data-Course-Project

##The script in this repository serves to collate a collection of existing datasets into one tidy dataset along with a summary dataset.

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The raw data processed by the script is data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data :

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


##The R script called run_analysis.R does the following:

- Checks that the dataset "getdata-projectfiles-UCI HAR Dataset.zip" has been downloaded to the working directory
- Extracts the test and train datasets (x_test.txt, x_train.txt) from the ZIP file
- Use the features dataset (features.txt) to apply column names to the datasets
- Keeps only those columns that contain a mean or standard deviation (as denoted in column names by "mean" and "std", respectively)
- Extracts the activity files (y_test.txt, y_train.txt), converts the numeric codes to descriptive using the activity_labels.txt file and attaches the activity to the train and test datasets
- Extracts the subjects files (subject_test.txt, subject_train.txt) and attaches the subjects to the train and test datasets
- Combines the test and train datasets to a new dataset called FullData
- Appropriately labels the FullData data set with descriptive variable names, replacing abbreviated labels wit hfull descriptions
- From the FullData data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject called SummaryData.
