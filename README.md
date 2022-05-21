
# R Getting and Cleaning Data Course Project - Johns Hopkins University

The current repository maintains the solution submitting for the Peer-graded Assignment: [Getting and Cleaning Data Course Project](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project).

The run_analysis.R performed the requested data transformations. More specifically the following abstract steps are performed :

- The script downloads the assignment's [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extracts it. 
- Consequently the process loads and processes the datasets meta data so the desired features and labels are maintained.
- The desired feature names are processed so non alpha characters, are replaced consistently with an underscore character. 
- Moreover the processed feature names are un-abbreviated based on known keywords and so they are more informative.
- The processed training and test datasets are merged into a unified data-set.
- The combined datasets are transformed into a tidy data
- Last, the average values per Subject, Activity and Variable are computed as the deliverable. 

The repository maintains the following files :
- Readme.md : The file you are currently reading
- The run_analysis.R scipt performing the desired computations
- The delivery_step4.zip containing the un-aggregated merged data-set
- The delivery_step5.csv containing the tidy data submission, asked in step 5
- The delivery_step5.csv containing the tidy data submission, asked in step 5
- The code.book.md Describing the computations details, the variables information

This repository has been developed by Konstantinos Papageorgiou for the purpose of the Peer-graded Assignment of the course :
- Data Science: Foundations using R Specialization - [Getting and Cleaning Data Course of the Johns Hopkins University](https://www.coursera.org/learn/data-cleaning/home/welcome)
 
