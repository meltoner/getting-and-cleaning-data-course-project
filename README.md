
# R Getting and Cleaning Data Course Project - Johns Hopkins University

The current repository maintains the solution submitting for the Peer-graded Assignment: [Getting and Cleaning Data Course Project](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project).

The **run_analysis.R** performs the requested data transformations shortly described bellow :

- The script downloads the assignment's [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) zip file and extracts it. 
- Consequently the process loads and processes the data-sets meta-data information so the desired features are identified and maintained.
- The desired feature names are processed so non alpha characters, are replaced consistently with an underscore character. 
- Moreover the processed feature names are un-abbreviated based on known keywords and so they are more informative.
- The Activity meta-data keys are replaced by the respective labels.
- The processed training and test datasets are merged into a unified data-set.
- The combined datasets are transformed into a tidy data-set.
- Last, the average values per Subject, Activity and Variable are computed as the Project's step 5 deliverable.

The repository maintains the following files :
- The [Readme.md](https://github.com/meltoner/getting-and-cleaning-data-course-project/blob/main/README.md) which is the file currently reading.
- The [run_analysis.R](https://github.com/meltoner/getting-and-cleaning-data-course-project/blob/main/run_analysis.R) : The script performs the desired computations. (Included comments have been included following the rmarkdown style).

- The [submission.data.txt](https://github.com/meltoner/getting-and-cleaning-data-course-project/blob/main/submission.data.txt) containing the tidy data submission, delivering the aggregated data providing the average values by Subject, Activity and Variable (step 5).
- The [code.book.md](https://github.com/meltoner/getting-and-cleaning-data-course-project/blob/main/code.book.md) Describing the computations in further details as well as the variables information.

This repository has been developed by Konstantinos Papageorgiou for the purpose of the Peer-graded Assignment of the course :
- Data Science: Foundations using R Specialization - [Getting and Cleaning Data Course of the Johns Hopkins University](https://www.coursera.org/learn/data-cleaning/home/welcome)
 
