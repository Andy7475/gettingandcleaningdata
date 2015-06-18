##Code Book 
For the dataset created with run_analysis.R that goes into tidy_data.txt

Data came from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#
and information on the source of the data and how it was collected can be found there.

The tidy_data.txt file contains 4 columns

* "subject" - the ID of the person performing the activity (between 1 and 30)
* "activityLabel" - a description of the activity being performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* "variable" - the description of the measurement being made. This is either the mean or standard deviation of a collection of results on acceleration or angular velocity that have been normalised and bounded between -1 and +1. A full description of the variable names can be found in the readme file and feature_info file at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#.
* "mean" - the mean value of each of the variables

