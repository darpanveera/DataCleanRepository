# Getting and Cleaning Data Project

## run_analysis.R

The cleanup script (run_analysis.R) does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Running the script

To run the script, source `run_analysis.R`. After running, you will see the following output as the script works:

```
[run_analysis.R] Getting and Cleaning Data Project 
[run_analysis.R] Author: Darpan Veera
[run_analysis.R] --- 
[run_analysis.R] Starting up. 
[run_analysis.R] Set the directory path.
[run_analysis.R] Reading datasets.
[run_analysis.R]   reading features... 
[run_analysis.R]   reading activities... 
[run_analysis.R]   reading subjects... 
[run_analysis.R] Getting dataset: 
[run_analysis.R] Joining datasets and adding Subject and Activity column. 
[run_analysis.R] Extacting mean and Std variables only.
[run_analysis.R] Updating the column names. 
[run_analysis.R] Calculating the mean and Standard Deviation based on Activity and Subject.  
[run_analysis.R] Saving clean data to: https://github.com/darpanveera/DataCleanRepository
```

## Process

1. For both the test and train datasets, produce an interim dataset:
    1. Extract the mean and standard deviation features (listed in CodeBook.md). This is the `values` table.
    2. Get the list of activities.
    3. Put the activity *labels* (not numbers) into the `values` table.
    4. Get the list of subjects.
    5. Put the subject IDs into the `values` table.
2. Join the test and train interim datasets.
3. Join the test and train activity lables datasets.
4. Join the test and train subject lables dataset.
5. Put each variable on its own row.
6. Update the column heading names in a readable format.
7. Rejoin the entire table, keying on subject/acitivity pairs, applying the mean function to each vector of values in each subject/activity pair. This is the clean dataset.
8. Write the clean dataset to disk.

## Cleaned Data

The resulting clean dataset is in this repository at: `Cleaned_DataSet`. It contains one row for each subject/activity pair and columns for subject, activity, and each feature that was a mean or standard deviation from the original dataset.

## Notes

X_* - feature values (one row of 561 features for a single activity)
Y_* - activity identifiers (for each row in X_*)
subject_* - subject identifiers for rows in X_*