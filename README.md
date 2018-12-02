# Activity data merging and cleaning

## Data
In this repo a quick run analysis is performed for an smart phone activity dataset. The data is UCI HAR dataset, which is explained in more detail in this 
link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 
The detailed explanations for features and activity labels are in ./UCI HAR Dataset folder files. That same folder contains folders train and test.

## Result datasets
Both folders train and test contain feature variables and label variable (activity type). In the code file run_analysis.R training and testing sets are combined. Only mean and standard deviation measurements are extracted from the data for the analysis. This dataset is also in this repo named "combined_mean_std_data.csv".

## Grouped average for all features
Also averages are calculated from the previously mentioned dataset group by each subject and activity type. This dataset is in file "subject_activityName_averages.csv"