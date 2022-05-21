#' # Getting and Cleaning Data Course Project Assignment
#' 
#' Below are the requirements of the project:
#'
#' The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
#'
#' One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
#'   
#' -  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#' 
#' Here are the data for the project:
#' 
#' - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
#' 
#' You should create one R script called run_analysis.R that does the following. 
#' 
#' Merges the training and the test sets to create one data set.
#' 
#' Extracts only the measurements on the mean and standard deviation for each measurement. 
#' 
#' Uses descriptive activity names to name the activities in the data set
#' 
#' Appropriately labels the data set with descriptive variable names. 
#' 
#' From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#'
#' 
#' # Data source establishment 
#' 
#' 

library("utils")
library("data.table")
library("glue")

filename <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#'
#' The data-set is downloaded from `r filename`
#'

destFilename <- "data.zip"
download.file(filename, destfile = destFilename)
unzip(destFilename)

foldername <- "UCI HAR Dataset"

#'
#' The downloaded zip file is extracted creating the folder `r foldername`.
#' 
#' On its top level, it contains the following files `r list.files(foldername)`
#' 

#' # Meta data processing
#' 
#' ## Features processing
#' 

fileName <- paste0(foldername,"/features.txt")
featuresNames <- fread( fileName )$V2

#'
#' The `r filename` maintains the features definitions in counting to `r length(featuresNames)`
#' The first five are reflected bellow.
#' 

featuresNames %>% head

#'

featuresMeanStdIndexes <- grep("mean|std", tolower(featuresNames) )
featuresMeanStd <- featuresNames[featuresMeanStdIndexes]

#'
#' Features matching the keywords mean and std are maintained resulting to `r length(featuresMeanStd)` items from a total of `r length(featuresNames)`.
#'
#'     
#' In order to convert the names to column names, we replace non alpha characters with an underscore.
#' 

featuresNamesCleaned <- featuresMeanStd %>% gsub("[^a-zA-Z]+","_", .)

#' 
#' Consequently known abbreviations are expanded so they are more userfriendly
#' 

featuresNamesCleaned <- 
  gsub("Acc", "Acceleration", featuresNamesCleaned) %>%
  gsub("Freq", "Frequency", .) %>%
  gsub("Gyro", "Gyroscope", .)  %>%
  gsub("Mag", "Magnitude", .) %>%
  gsub("fBody", "FFTBody", .) %>%
  gsub("^t", "Time", .) %>%
  gsub("_$", "", .) 


#'
#' The updated names are sampled bellow.
#'

sample(featuresNamesCleaned, 5)

#' 
#' ### Activity labels
#' 
#' The activity key to label meta data are loaded
#' 

fileName <- paste0(foldername,"/activity_labels.txt")
activityLabels <- fread(fileName)
names(activityLabels) <-c("activityKey","Activity")

activityLabels

#' 
#' # Data loading
#' 
#' 

mergeDataFiles <- function(i){
  
  # Loads the three related data files, the subject the input variables and the target variables. 
  # from the input variables maintains the mean and std variables 
  # while sanitizes the column names off illegal characters.
  # The Activity values are replaced by their friendly labels
  # Last the dataset are annotated either as training or test sets

  types <- c("train", "test")
  patterns <- c(
    "{foldername}/{type}/subject_{type}.txt", 
    "{foldername}/{type}/X_{type}.txt", 
    "{foldername}/{type}/y_{type}.txt"
  )
  
  type <- types[i]
  A <- fread(glue(patterns[1]), col.names = c("Subject"))
  B <- fread(glue(patterns[2]))
  C <- fread(glue(patterns[3]), col.names = c("activityKey"))
  
  Bupdated <- B[, paste0("V", featuresMeanStdIndexes), with = FALSE]
  names(Bupdated) <- featuresNamesCleaned
  
  Cupdated <- merge(C, activityLabels)[, c("Activity"), with = FALSE]
  
  result <- cbind(A, Bupdated, Cupdated)
  #result[, dataset := type]
  result
}

combinedDataset <- lapply(1:2, mergeDataFiles) %>% rbindlist

#' The resulting combined processed data sets has dimensions of `r dim(combinedDataset)`

fwrite(combinedDataset, file = "delivery_step4.csv")

#'
#' # Convert dataset into a tidy dataset
#'
#'

idVariables <- c("Subject", "Activity")

tidyDataset <- melt(
    combinedDataset, 
    id.vars = idVariables, 
    measure.vars = featuresNamesCleaned,
    variable.name = "Variable", value.name = "Value"
)


#' 
#' The tidy data- set is averaged by the subject and activity and variable
#' 
stepFive <- tidyDataset[, .(Mean = mean(Value)), by = c(idVariables, "Variable")]


fwrite(stepFive, file = "delivery_step5.csv")

stepFive %>% print
