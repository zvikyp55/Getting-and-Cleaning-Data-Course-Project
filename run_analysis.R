##run_analysis.R - Script for Assignment: Getting and Cleaning Data Course Project

## This script collates several datasets into one tidy dataset along with a summary dataset and returns the two datasets to the user as a list
run_analysis<-function(){
    
    ## Verify that data file exists in the working directory
    strZipFile <- "getdata-projectfiles-UCI HAR Dataset.zip"
    if (!file.exists(as.character(strZipFile))) {
        return(paste(c("Sorry that file " , as.character(strZipFile), " could not be found."),sep= " ",collapse="" ))
    }
    
    ## get the test and train datasets from the ZIP file
    datatest<-read.table(unz(strZipFile,"UCI HAR Dataset/test/X_test.txt"))
    datatrain<-read.table(unz(strZipFile,"UCI HAR Dataset/train/X_train.txt"))
    
    ## use the features dataset to apply column names
    features<-read.table(unz(strZipFile,"UCI HAR Dataset/features.txt"))
    featureslist<-features[,2]  ##extract just the variable names as a list
    colnames(datatest)<-featureslist
    colnames(datatrain)<-featureslist
    
    ## Keep only columns with mean or std, use sort to mantain original column order
    datatest<-datatest[,sort(c(grep("mean",featureslist),grep("std",featureslist)))]
    datatrain<-datatrain[,sort(c(grep("mean",featureslist),grep("std",featureslist)))]
    
    ##read in activity files, convert to descriptive and attach to train,test
    testy<-read.table(unz(strZipFile,"UCI HAR Dataset/test/y_test.txt"))
    trainy<-read.table(unz(strZipFile,"UCI HAR Dataset/train/y_train.txt"))
    
    activitynames<-read.table(unz(strZipFile,"UCI HAR Dataset/activity_labels.txt"))
    testy$Activity<-activitynames[match(testy[,1] , activitynames[,1]),2]
    trainy$Activity<-activitynames[match(trainy[,1] , activitynames[,1]),2]
    
    datatest<-cbind(Activity=testy[,2],datatest)
    datatrain<-cbind(Activity=trainy[,2],datatrain)
    
    ## read in the subjects and attach to train , test
    testsub<-read.table(unz(strZipFile,"UCI HAR Dataset/test/subject_test.txt"))
    trainsub<-read.table(unz(strZipFile,"UCI HAR Dataset/train/subject_train.txt"))
    colnames(testsub)<-"Subject"
    colnames(trainsub)<-"Subject"
    
    datatest<-cbind(testsub,datatest)
    datatrain<-cbind(trainsub,datatrain)
    
    ## combine the test and train
    
    FullData<-rbind(datatrain,datatest)
    
    ##rename labels with descriptive labels
    ## t = time, f=frequency 
    ## acc = acceleration , gyro = gyroscope
    ## mag = magnitude
    
    ##Using sub function so only first instance is replaced
    colnames(FullData)[-(1:2)]<-sub("t","time",colnames(FullData)[-(1:2)])  ## Excluding first two columns Subject  and Activity
    colnames(FullData)[-(1:2)]<-sub("f","freq",colnames(FullData)[-(1:2)]) 
    colnames(FullData)[-(1:2)]<-sub("Acc","Acceleration",colnames(FullData)[-(1:2)]) 
    colnames(FullData)[-(1:2)]<-sub("gyro","GyroScope",colnames(FullData)[-(1:2)]) 
    colnames(FullData)[-(1:2)]<-sub("Mag","Magnitude",colnames(FullData)[-(1:2)]) 
    
    ##install.packages("dplyr")
    require("dplyr")
    
    ##create second summary dataset, with the mean for each varaible
    SummaryData<-group_by(FullData,Subject,Activity)%>%summarise_each(funs(mean),-(Subject:Activity))
    
    ##Return the two datasets to the user as a list
    return(list(FullData,SummaryData))
    

}
