## This script collects, works with, and cleans a data set.

## Merges the training and the test sets to create one data set.
body_acc_x_test <- read.table("test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table("test/Inertial Signals/body_acc_z_test.txt")
body_gyro_x_test <- read.table("test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table("test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("test/Inertial Signals/body_gyro_z_test.txt")
total_acc_x_test <- read.table("test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table("test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("test/Inertial Signals/total_acc_z_test.txt")
subject_test <- read.table("test/subject_test.txt")
#X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

body_acc_x_train <- read.table("train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("train/Inertial Signals/body_acc_z_train.txt")
body_gyro_x_train <- read.table("train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("train/Inertial Signals/body_gyro_z_train.txt")
total_acc_x_train <- read.table("train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("train/Inertial Signals/total_acc_z_train.txt")
subject_train <- read.table("train/subject_train.txt")
#X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

body_acc_x <- merge(body_acc_x_test,body_acc_x_train,all=TRUE)
body_acc_y <- merge(body_acc_y_test,body_acc_y_train,all=TRUE)
body_acc_z <- merge(body_acc_z_test,body_acc_z_train,all=TRUE)
body_gyro_x <- merge(body_gyro_x_test,body_gyro_x_train,all=TRUE)
body_gyro_y <- merge(body_gyro_y_test,body_gyro_y_train,all=TRUE)
body_gyro_z <- merge(body_gyro_z_test,body_gyro_z_train,all=TRUE)
total_acc_x <- merge(total_acc_x_test,total_acc_x_train,all=TRUE)
total_acc_y <- merge(total_acc_y_test,total_acc_y_train,all=TRUE)
total_acc_z <- merge(total_acc_z_test,total_acc_z_train,all=TRUE)
subject <- merge(subject_test,subject_train,all=TRUE)
#X <- merge(X_test,X_train,all=TRUE)
y <- rbind(y_test,y_train)

## Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_body_acc_x <- rowMeans(body_acc_x)
mean_body_acc_y <- rowMeans(body_acc_y)
mean_body_acc_z <- rowMeans(body_acc_z)
mean_body_gyro_x <- rowMeans(body_gyro_x)
mean_body_gyro_y <- rowMeans(body_gyro_y)
mean_body_gyro_z <- rowMeans(body_gyro_z)
mean_total_acc_x <- rowMeans(total_acc_x)
mean_total_acc_y <- rowMeans(total_acc_y)
mean_total_acc_z <- rowMeans(total_acc_z)

std_body_acc_x <- apply(body_acc_x,1,sd)
std_body_acc_y <- apply(body_acc_y,1,sd)
std_body_acc_z <- apply(body_acc_z,1,sd)
std_body_gyro_x <- apply(body_gyro_x,1,sd)
std_body_gyro_y <- apply(body_gyro_y,1,sd)
std_body_gyro_z <- apply(body_gyro_z,1,sd)
std_total_acc_x <- apply(total_acc_x,1,sd)
std_total_acc_y <- apply(total_acc_y,1,sd)
std_total_acc_z <- apply(total_acc_z,1,sd)

## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 

output <- cbind(
	Subject=subject,
	Activity=y,
	Body.Acceleration.X.Mean=mean_body_acc_x,
	Body.Acceleration.Y.Mean=mean_body_acc_y,
	Body.Acceleration.Z.Mean=mean_body_acc_z,
	Body.Gyroscope.X.Mean=mean_body_gyro_x,
	Body.Gyroscope.Y.Mean=mean_body_gyro_y,
	Body.Gyroscope.Z.Mean=mean_body_gyro_z,
	Total.Acceleration.X.Mean=mean_total_acc_x,
	Total.Acceleration.Y.Mean=mean_total_acc_y,
	Total.Acceleration.Z.Mean=mean_total_acc_z,
	Body.Acceleration.X.Std=std_body_acc_x,
	Body.Acceleration.Y.Std=std_body_acc_y,
	Body.Acceleration.Z.Std=std_body_acc_z,
	Body.Gyroscope.X.Std=std_body_gyro_x,
	Body.Gyroscope.Y.Std=std_body_gyro_y,
	Body.Gyroscope.Z.Std=std_body_gyro_z,
	Total.Acceleration.X.Std=std_total_acc_x,
	Total.Acceleration.Y.Std=std_total_acc_y,
	Total.Acceleration.Z.Std=std_total_acc_z)

names(output)[1] <- "Subject"
names(output)[2] <- "Activity"

outputSort <- aggregate(output[,3:20], list(Subject=output$Subject, Activity=output$Activity), mean)

write.table(outputSort,file="outputSort.txt",row.names=FALSE)