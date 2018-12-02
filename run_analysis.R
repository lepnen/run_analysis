### Load libraries
libraries <- c("dplyr")
lapply(libraries, require, character.only = TRUE)

### Load feature names and activity labels
feature_names <- read.table("./UCI HAR Dataset/features.txt", header = F)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = F,
                              col.names = c("activity_id", "activity_name"))

### Load training data
train_X <- read.table("./UCI HAR Dataset/train/X_train.txt", header = F)
train_y <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = F, col.names = c("activity_id")) %>%
                left_join(activity_labels, by = "activity_id")
train_subject <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header = F, col.names = "subject")

test_X <- read.table("./UCI HAR Dataset/test/X_test.txt", header = F)
test_y <- read.csv("./UCI HAR Dataset/test/y_test.txt", header = F, col.names = c("activity_id")) %>%
                left_join(activity_labels, by = "activity_id")
test_subject <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header = F, col.names = "subject")

### Extract only mean and std for each measurement
mean_std_vars <- grepl("mean|std", feature_names$V2)
mean_std_vars_names <- feature_names$V2[mean_std_vars]

# For training set
train_X_mean_std <- train_X[, mean_std_vars]
names(train_X_mean_std) <- mean_std_vars_names

# For testing set
test_X_mean_std <- test_X[, mean_std_vars]
names(test_X_mean_std) <- mean_std_vars_names

### merge training and testing data
## merge training
train <- cbind(train_subject, train_y, train_X_mean_std)

## merge testing
test <- cbind(test_subject, test_y, test_X_mean_std)

## row bind train and test sets together
data_all <- rbind(train, test)

write.csv(data_all, "./combined_mean_std_data.csv",row.names = F)

### calculate mean for all numeric variables grouped by subject and activity
all_avgs <- data_all %>% group_by(subject, activity_name) %>% summarise_all(mean)

write.csv(all_avgs, "./subject_activityName_averages.csv", row.names = F)
