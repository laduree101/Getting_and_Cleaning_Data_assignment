library(data.table)
library(dplyr)
library(plyr)
library(reshape2)

# Read in the subject files
test_subject <- read.table("subject_test.txt", col.names=c("Subject"))
train_subject <- read.table("subject_train.txt", col.names=c("Subject"))

# Read in the data
x_test <- read.table("X_test.txt")
x_train <- read.table("X_train.txt")

# Read in the numerical feature list
y_test <- read.table("Y_test.txt", col.names=c("activity_Index"))
y_train <- read.table("Y_train.txt", col.names=c("activity_Index"))

# Concatenate the files
subject_concat <- rbind(train_subject, test_subject) #concatenates the subject files
data_concat <- rbind(x_train, x_test)                # concatenates the data files
numerical_activity_concat <- rbind(y_train, y_test)  # concatenates the numerical activity files

# Read in the list of activities
activities_list <- read.table("activity_labels.txt", sep =" ", col.names=c("activity_Index", "activity_Name"))

# Read in features list
feature_list <- read.table("features.txt", col.names=c("feature_Index", "feature_Name"))
feature_labels <- feature_list$feature_Name          # create a vector with the feature list 
# Find the columns with "mean" or "stdev" in the feature name; this gives a vector with TRUE/FALSE
feature_T_F_mean_stdev <- grepl('mean\\(\\)|std\\(\\)', feature_labels)
# Create a character vector of only the columns with "mean" or "stdev" in the name (by only taking the TRUE values)
feature_subset <- as.character(feature_labels[feature_T_F_mean_stdev])

# Now add the column names to the dataset
colnames(data_concat) <- feature_labels
# Only keep the columns in the data that have "mean" or "std" in the column name
# This completes "2. Extracts only the measurements on the mean and stdev for each measurement"
data_concat_mean_std_col <- data_concat[,feature_T_F_mean_stdev]

# Join the activity decoder with the activity numerical list
activity_join <- join(numerical_activity_concat, activities_list)


# Merge everything into one dataset.  
# This compeltes "1. Merges the training and test sets to  create one data set."
final_dt <- cbind(data_concat, activity_join, subject_concat)

# Melt the data (ie stack it)  by subject and activity
stacked_dt <- melt(final_dt, id=c("Subject", "activity_Name"))

# Split the data into subject and activity name while taking the mean; put it into the tidy data frame
# Use the reshape package
split_dt <- dcast(stacked_dt, Subject + activity_Name ~ variable, mean)

#Output file
write.table(split_dt,file="tidy_data.txt") 
