# GettingAndCleaningData Readme

## This repository contains the following files:
- run_analysis.R (contains script (see below) that gathers and organises data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- summary_data.txt (contains a tidy table with summarised data from the run_analysis.R script with the variables described in CodeBook.MD)
- CodeBook.MD (contains a list of the variables in summary_data.txt

### The run_analysis.R does the following
- Downloads zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into working directory and unzip into working directory
- Loads data to R data frame variables
- Applys label names to each data frame
- Merges subject, activity, x data together
- Merges x & y data together
- Extracts Subject ID, Activity ID along with mean & std data
- Changes Activity IDs to descriptive names
- Cleans variable names
- Create final data set with summary by mean
- Write data frame to txt file
