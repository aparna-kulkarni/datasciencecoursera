==================================================================
run_analysis.R script does the following 
==================================================================

1. Read X (Measurements) training and test datasets into dataframes xtrain and xtest
   Read Y (Activity) training and test datasets into dataframes ytrain and ytest
   Read Subject training and test datasets into dataframes

2. Merge training and test datasets to form measurements dataframe xall, 
   Activities dataframe yall, Subject identifier dataframe subject

3. Assign variable name for Activity
   Assign variable name for Subject

4. Read features dataset for obtaining index to subset 
   measurements dataframe xall
   Subsets the columns with "mean()" and "std()" 
   Assign column names to the mean and std dataframes

5. Merge the mean and std dataframes to form a measurements dataframe xall
   Merge this measurements (xall) dataframe wih the subject and Activity (yall) dataframe to form xyall
  
6. Read the Activity labels
   Substitute the actvity numbers with activity labels

7.   Create another dataframe xyavg from xyall to average the measurement variable values by Subject and Activity

8. Write to a text dataset xyavg.txt
   Write to a comma separated dataset xyavg.csv


