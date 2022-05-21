# Code book

This code book provides peripheral information on the origin, processing and delivering dataset of the Getting and Cleaning Data Course Project of Johns Hopkins University.

## Dataset Origin

The address of the original dataset is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

- http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Dataset Processing

On the top level folder of the zip file the :

- 1. features.txt maintains the feature names of the values encoded by the file {foldername}/{type}/X_{type}.txt where foldername = "UCI HAR Dataset" and type being either "training" or "test".
- 2. activity_labels.txt maintains the key/id and the label of the Activity 
	- WALKING
	- WALKING_UPSTAIRS
	- WALKING_DOWNSTAIRS
    - SITTING
	- STANDING
	- LAYING

As an initial step the features.txt is grep-ed to identify which features relate to the Mean or the Standard deviation using the following expression.

	grep("mean|std", tolower(featuresNames) )

Next the selected names are sanitized by replacing potentially invalid characters, non alpha characters with an underscore using the following expression

	featuresMeanStd %>% gsub("[^a-zA-Z]+","_", .)

To make the feature names more readable the following abbreviation are extended to their full word based on the following replacements

	featuresNamesCleaned <- 
	  gsub("Acc", "Acceleration", featuresNamesCleaned) %>%
	  gsub("Freq", "Frequency", .) %>%
	  gsub("Gyro", "Gyroscope", .)  %>%
	  gsub("Mag", "Magnitude", .) %>%
	  gsub("fBody", "FFTBody", .) %>%
	  gsub("^t", "Time", .) %>%
	  gsub("_$", "", .) 


Consequently the dataset is constructed by loading the A) the subject data (subject_{type}.txt), B) the features data (X_{type}.txt") and  C) the Activity data (y_{type}.txt)

The B data are updated so only the desired features are maintained and renamed to the more readable labels.
The C data are replaced as of the Activity labels
The A, B updated and C updated data are combined for the training and the test datasets.

Next the data are converted to a tidy dataset using the following expression

	tidyDataset <- melt(
	    combinedDataset, 
	    id.vars = idVariables, 
	    measure.vars = featuresNamesCleaned,
	    variable.name = "Variable", value.name = "Value"
	)

Last the tidy data are converted to the deliverable using the following expression

	tidyDataset[, .(Mean = mean(Value)), by = c(idVariables, "Variable")]



## Dataset Features information

The result dataset is composed of four columns namely the "Subject"  "Activity" "Variable" and the "Mean".

- The Subject column maintains the person's identified relevant to the data collection.
- The Activity maintains activity the person was performing during the data accumulation 
- The Variable maintains sensory information Relevant to the mean and the standard deviation requested.
- The Mean maintains the aggregated mean of the sensory information calculated by Subject, Activity and Variable

Bellow a quick summary of the data is provided
	

	   Subject                    Activity                          Variable   
	Min.   : 1.00   LAYING            :516   TimeBodyAcceleration_mean_X:  40  
	1st Qu.: 8.75   SITTING           :602   TimeBodyAcceleration_mean_Y:  40  
	Median :15.50   STANDING          :602   TimeBodyAcceleration_mean_Z:  40  
	Mean   :15.38   WALKING           :516   TimeBodyAcceleration_std_X :  40  
	3rd Qu.:22.00   WALKING_DOWNSTAIRS:516   TimeBodyAcceleration_std_Y :  40  
	Max.   :30.00   WALKING_UPSTAIRS  :688   TimeBodyAcceleration_std_Z :  40  
	                                         (Other)                    :3200  
	     Mean         
	Min.   :-0.99568  
	1st Qu.:-0.71069  
	Median :-0.54283  
	Mean   :-0.41229  
	3rd Qu.:-0.03966  
	Max.   : 0.96258 

The resulting data set has 3440 rows and 4 columns.

In total there are 86 Variable namely the following :


	 [1] TimeBodyAcceleration_mean_X                       
	 [2] TimeBodyAcceleration_mean_Y                       
	 [3] TimeBodyAcceleration_mean_Z                       
	 [4] TimeBodyAcceleration_std_X                        
	 [5] TimeBodyAcceleration_std_Y                        
	 [6] TimeBodyAcceleration_std_Z                        
	 [7] TimeGravityAcceleration_mean_X                    
	 [8] TimeGravityAcceleration_mean_Y                    
	 [9] TimeGravityAcceleration_mean_Z                    
	[10] TimeGravityAcceleration_std_X                     
	[11] TimeGravityAcceleration_std_Y                     
	[12] TimeGravityAcceleration_std_Z                     
	[13] TimeBodyAccelerationJerk_mean_X                   
	[14] TimeBodyAccelerationJerk_mean_Y                   
	[15] TimeBodyAccelerationJerk_mean_Z                   
	[16] TimeBodyAccelerationJerk_std_X                    
	[17] TimeBodyAccelerationJerk_std_Y                    
	[18] TimeBodyAccelerationJerk_std_Z                    
	[19] TimeBodyGyroscope_mean_X                          
	[20] TimeBodyGyroscope_mean_Y                          
	[21] TimeBodyGyroscope_mean_Z                          
	[22] TimeBodyGyroscope_std_X                           
	[23] TimeBodyGyroscope_std_Y                           
	[24] TimeBodyGyroscope_std_Z                           
	[25] TimeBodyGyroscopeJerk_mean_X                      
	[26] TimeBodyGyroscopeJerk_mean_Y                      
	[27] TimeBodyGyroscopeJerk_mean_Z                      
	[28] TimeBodyGyroscopeJerk_std_X                       
	[29] TimeBodyGyroscopeJerk_std_Y                       
	[30] TimeBodyGyroscopeJerk_std_Z                       
	[31] TimeBodyAccelerationMagnitude_mean                
	[32] TimeBodyAccelerationMagnitude_std                 
	[33] TimeGravityAccelerationMagnitude_mean             
	[34] TimeGravityAccelerationMagnitude_std              
	[35] TimeBodyAccelerationJerkMagnitude_mean            
	[36] TimeBodyAccelerationJerkMagnitude_std             
	[37] TimeBodyGyroscopeMagnitude_mean                   
	[38] TimeBodyGyroscopeMagnitude_std                    
	[39] TimeBodyGyroscopeJerkMagnitude_mean               
	[40] TimeBodyGyroscopeJerkMagnitude_std                
	[41] FFTBodyAcceleration_mean_X                        
	[42] FFTBodyAcceleration_mean_Y                        
	[43] FFTBodyAcceleration_mean_Z                        
	[44] FFTBodyAcceleration_std_X                         
	[45] FFTBodyAcceleration_std_Y                         
	[46] FFTBodyAcceleration_std_Z                         
	[47] FFTBodyAcceleration_meanFrequency_X               
	[48] FFTBodyAcceleration_meanFrequency_Y               
	[49] FFTBodyAcceleration_meanFrequency_Z               
	[50] FFTBodyAccelerationJerk_mean_X                    
	[51] FFTBodyAccelerationJerk_mean_Y                    
	[52] FFTBodyAccelerationJerk_mean_Z                    
	[53] FFTBodyAccelerationJerk_std_X                     
	[54] FFTBodyAccelerationJerk_std_Y                     
	[55] FFTBodyAccelerationJerk_std_Z                     
	[56] FFTBodyAccelerationJerk_meanFrequency_X           
	[57] FFTBodyAccelerationJerk_meanFrequency_Y           
	[58] FFTBodyAccelerationJerk_meanFrequency_Z           
	[59] FFTBodyGyroscope_mean_X                           
	[60] FFTBodyGyroscope_mean_Y                           
	[61] FFTBodyGyroscope_mean_Z                           
	[62] FFTBodyGyroscope_std_X                            
	[63] FFTBodyGyroscope_std_Y                            
	[64] FFTBodyGyroscope_std_Z                            
	[65] FFTBodyGyroscope_meanFrequency_X                  
	[66] FFTBodyGyroscope_meanFrequency_Y                  
	[67] FFTBodyGyroscope_meanFrequency_Z                  
	[68] FFTBodyAccelerationMagnitude_mean                 
	[69] FFTBodyAccelerationMagnitude_std                  
	[70] FFTBodyAccelerationMagnitude_meanFrequency        
	[71] FFTBodyBodyAccelerationJerkMagnitude_mean         
	[72] FFTBodyBodyAccelerationJerkMagnitude_std          
	[73] FFTBodyBodyAccelerationJerkMagnitude_meanFrequency
	[74] FFTBodyBodyGyroscopeMagnitude_mean                
	[75] FFTBodyBodyGyroscopeMagnitude_std                 
	[76] FFTBodyBodyGyroscopeMagnitude_meanFrequency       
	[77] FFTBodyBodyGyroscopeJerkMagnitude_mean            
	[78] FFTBodyBodyGyroscopeJerkMagnitude_std             
	[79] FFTBodyBodyGyroscopeJerkMagnitude_meanFrequency   
	[80] angle_tBodyAccelerationMean_gravity               
	[81] angle_tBodyAccelerationJerkMean_gravityMean       
	[82] angle_tBodyGyroscopeMean_gravityMean              
	[83] angle_tBodyGyroscopeJerkMean_gravityMean          
	[84] angle_X_gravityMean                               
	[85] angle_Y_gravityMean                               
	[86] angle_Z_gravityMean


To elaborate further and by sourcing the original code book have renamed the features names as of the processing performed, find aditional relevant information on the encoded features.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeAcceleration-XYZ and timeGyroscope-XYZ. These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAcceleration-XYZ and tGravityAcceleration-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccelerationJerk-XYZ and timeBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccelerationMagnitude, timeGravityAccelerationMagntitude, tBodyAccelerationJerkMagnitude, tBodyGyroscopeMagnitude, timeBodyGyroscopeJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FFTBodyAcceleration-XYZ, FFTBodyAccelerationJerk-XYZ, FFTBodyGyroscope-XYZ, FFTBodyAccelerationJerkMag, FFTBodyGyroscopeMagnitude, FFTBodyGyroscopeJerkMagnitude. (Note the 'FFT' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- meanFrequency(): Weighted average of the frequency components to obtain a mean frequency

angle(): Angle between to vectors.

---