#   2. Merging the training and the test sets to create one data set:
# Reading trainings tables:
x_train <- read.table("C:\\Users\\User\\Desktop\\Jobs_2018\\Clinical research\\R programming\\Corsera R programming\\Getting $ cleaning data\\Week 4_project\\X_train.txt")
y_train <- read.table("C:\\Users\\User\\Desktop\\Jobs_2018\\Clinical research\\R programming\\Corsera R programming\\Getting $ cleaning data\\Week 4_project\\y_train.txt")
subject_train <- read.table("C:\\Users\\User\\Desktop\\Jobs_2018\\Clinical research\\R programming\\Corsera R programming\\Getting $ cleaning data\\Week 4_project\\subject_train.txt")

# Reading testing tables:
x_test <- read.table("C:\\Users\\User\\Desktop\\Jobs_2018\\Clinical research\\R programming\\Corsera R programming\\Getting $ cleaning data\\Week 4_project\\X_test.txt")
y_test <- read.table("C:\\Users\\User\\Desktop\\Jobs_2018\\Clinical research\\R programming\\Corsera R programming\\Getting $ cleaning data\\Week 4_project\\y_test.txt")
subject_test <- read.table("C:\\Users\\User\\Desktop\\Jobs_2018\\Clinical research\\R programming\\Corsera R programming\\Getting $ cleaning data\\Week 4_project\\subject_test.txt")

# Reading feature vector:
features <- read.table('C:\\Users\\User\\Desktop\\Jobs_2018\\Clinical research\\R programming\\Corsera R programming\\Getting $ cleaning data\\Week 4_project\\features.txt')

# Reading activity labels:
activityLabels = read.table('C:\\Users\\User\\Desktop\\Jobs_2018\\Clinical research\\R programming\\Corsera R programming\\Getting $ cleaning data\\Week 4_project\\activity_labels.txt')

# column names
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merge
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)

#3. Extracting only the measurements on the mean and standard deviation for each measurement
colNames <- colnames(setAllInOne)

mean_and_std <- (grepl("activityId" , colNames) | 
                         grepl("subjectId" , colNames) | 
                         grepl("mean.." , colNames) | 
                         grepl("std.." , colNames) 
)
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

#4. Using descriptive activity names to name the activities in the data set:
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

#5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
MyTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
MyTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

write.table(MyTidySet, "MyTidySet.txt", row.name=FALSE)







