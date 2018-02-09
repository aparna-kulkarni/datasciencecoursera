## Read X (Measurements) training and test datasets into dataframes xtrain and xtest
xtest <- read.table("./Data/X_test.txt")
xtrain <- read.table("./Data/X_train.txt")

## Read Y (Activity) training and test datasets into dataframes ytrain and ytest
ytest <- read.table("./Data/Y_test.txt")
ytrain <- read.table("./Data/Y_train.txt")

## Read Subject training and test datasets into dataframes
subject_test <- read.table("./Data/subject_test.txt")
subject_train <- read.table("./Data/subject_train.txt")

## Merge training and test datasets xall, yall, subject
xall <- rbind(xtrain, xtest)
yall <- rbind(ytrain, ytest)
subject <- rbind(subject_train, subject_test)

## Assign variable name for Activity
colnames(yall)[1] <- "Activity"

## Assign variable name for Subject
colnames(subject)[1] <- "Subject"

## Read features dataset for obtaining index to subset 
## measurements dataframe xall
features <- read.table("./Data/features.txt")

## subset the columns with "mean()" and "std()" 
xall_mean <- xall[grepl("[m][e][a][n][(][)]",features$V2)]
xall_std <- xall[grepl("[s][t][d][(][)]",features$V2)]

## Form column names for the above data frames
mean_colnames <- grep("[m][e][a][n][(][)]",features$V2,value = TRUE)                 
std_colnames  <- grep("[s][t][d][(][)]",features$V2,value = TRUE)

## Assign column names to the mean and std dataframes
colnames(xall_mean) <- mean_colnames
colnames(xall_std) <- std_colnames

## Merge the mean and std dataframes to form a measurements dataframe
xall <- cbind(xall_mean,xall_std)

## Merge this measurements (xall) dataframe wih the subject and Activity (yall)dataframe
xyall <- cbind(yall, xall)
xyall <- cbind(subject, xyall)

## Read the labels
activity_labels <- read.table("./Data/activity_labels.txt")
print(activity_labels)

## Substitute the actvity numbers with activity labels 
xyall$Activity <- gsub(1,"WALKING",xyall$Activity)
xyall$Activity <- gsub(2,"WALKING_UPSTAIRS",xyall$Activity)
xyall$Activity <- gsub(3,"WALKING_DOWNSTAIRS",xyall$Activity) 
xyall$Activity <- gsub(4,"SITTING",xyall$Activity)
xyall$Activity <- gsub(5,"STANDING",xyall$Activity)
xyall$Activity <- gsub(6,"LAYING",xyall$Activity)

## Create another dataframe xyavg from xyall to 
## average the measurement variable values by Subject and Activity
xyavg <- xyall %>% group_by(Subject,Activity) %>% summarise_at(.vars = names(.)[3:69],.funs = c(mean="mean"))

## Write to a text dataset and a comma separated dataset
write.table(xyavg,file='./Data/xyavg.txt',row.names = FALSE)
write.table(xyavg,file='./Data/xyavg.csv',sep=',',row.names = FALSE)