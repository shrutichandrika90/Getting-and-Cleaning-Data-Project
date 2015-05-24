# Introduction to the Data

The script 'run_analysis.R' performs the 5 steps described in the course project's definition.

* First, all the those files having same number of coloumns and same number of entities are merged using the 'rbind()' function to create two data sets, 'x' and 'y'. 
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
* Then we use the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
* On the whole dataset, those columns with vague column names are corrected to have better and meaning ful names.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows).
* The output file is called 'Final_Data.txt', and uploaded to the course project submission page.

# Variables in the script 

* 'x_train','y_train','subject_train' -: These are the files downloaded and read into R from the train folder.
* 'x_test','y_test','subject_test'-: These are the files downloaded and read into R from the test folder.
* 'x'- This variables represents the x data set created.(with 'rbind()' on merging train and test)
* 'y' - This represents the y data set created.(After merging the train and the test data sets)
* 'subject_data'- The subject data set.
* 'features' contains the correct names for the x dataset, which are applied to the column names stored in 'mean_std', a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the 'activities' variable.
* 'Complete_data' merges 'x', 'y' and 'subject_data' in a big dataset.
* 'Final_Data'contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
