### run_analysis.R --- 
## 
## Filename: run_analysis.R
## Description: 
## Author: Sergio-Feliciano Mendoza-Barrera
## Maintainer: 
## Created: Sat Jul 26 13:38:25 2014 (-0500)
## Version: 
## Package-Requires: ()
## Last-Updated: Sun Jul 27 14:07:13 2014 (-0500)
##           By: Sergio-Feliciano Mendoza-Barrera
##     Update #: 275
## URL: 
## Doc URL: 
## Keywords: 
## Compatibility: 
## 
######################################################################
## 
### Commentary: 
## 
## The purpose of this project is to demonstrate your ability to
## collect, work with, and clean a data set. The goal is to prepare
## tidy data that can be used for later analysis. You will be graded
## by your peers on a series of yes/no questions related to the
## project. You will be required to submit: 1) a tidy data set as
## described below, 2) a link to a Github repository with your script
## for performing the analysis, and 3) a code book that describes the
## variables, the data, and any transformations or work that you
## performed to clean up the data called CodeBook.md. You should also
## include a README.md in the repo with your scripts. This repo
## explains how all of the scripts work and how they are connected.

## One of the most exciting areas in all of data science right now is
## wearable computing - see for example this article . Companies like
## Fitbit, Nike, and Jawbone Up are racing to develop the most
## advanced algorithms to attract new users. The data linked to from
## the course website represent data collected from the accelerometers
## from the Samsung Galaxy S smartphone. A full description is
## available at the site where the data was obtained:

## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Here are the data for the project:

## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##  You should create one R script called run_analysis.R that does the
##  following.

##     Merges the training and the test sets to create one data set.

##     Extracts only the measurements on the mean and standard
##     deviation for each measurement.

##     Uses descriptive activity names to name the activities in the
##     data set

##     Appropriately labels the data set with descriptive variable
##     names.

##     Creates a second, independent tidy data set with the average of
##     each variable for each activity and each subject.

## Please upload a tidy data set according to the instructions in the
## project description. Please upload your data set as a separate file
## (do not cut and paste a dataset directly into the text box, as this
## may cause errors saving your submission).
## 
######################################################################
## 
### Change Log:
## 
## 
######################################################################
## 
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or (at
## your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
## 
######################################################################
## 
### Code:

library(parallel)

######################################################################
## Download de datasets
rm(list = ls())                         # Remove all workspace data

######################################################################
## Code to download file data sets, use once

## source("dwDataFile.R")                  # Download the dataset

## fileName <- "HumanActivityRecognitionUsingSmartphones.zip"
## source <-
##         "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## dwDataFile(fileName, source)                  # Download the dataset

######################################################################
##                         Training data set
######################################################################
## features.txt file
featuresFile <- "./data/features.txt"
df_features <- read.table(featuresFile, colClasses = "character")

## Subsetting features data frame to obtain a vector of names
features <- df_features[, 2]
features <- gsub("()", "", features, fixed = TRUE)
features <- gsub(",", "_", features, fixed = TRUE)
features <- gsub("(", "-", features, fixed = TRUE)
features <- gsub(")", "", features, fixed = TRUE)

######################################################################
## subject_train.txt file
subjectTrainFile <- "./data/train/subject_train.txt"
df_subjectTrain <- read.table(subjectTrainFile, colClasses = "numeric")

######################################################################
##
## y_train.txt file
yTrainFile <- "./data/train/y_train.txt"
initial <- read.table(yTrainFile, nrows = 100)
classes <- sapply(initial, class)
yTrainData <- read.table(yTrainFile, colClasses = classes)

######################################################################
##
## X_train.txt file
XTrainFile <- "./data/train/X_train.txt"
initial <- read.table(XTrainFile, nrows = 100)
classes <- sapply(initial, class)
XTrainData <- read.table(XTrainFile, colClasses = classes)

######################################################################
## Assambling data training dataframe
trainData <- cbind(yTrainData, df_subjectTrain, XTrainData, rep("train", nrow(yTrainData)))
names(trainData) <- c("ActivityLabel", "SubjectId", features, "setName")

rm(classes); rm(df_features); rm(df_subjectTrain); ## rm(features)
rm(featuresFile); rm(initial); rm(subjectTrainFile)
rm(XTrainData); rm(XTrainFile); rm(yTrainData); rm(yTrainFile)

######################################################################
## Training Inertial Signals analysis
##
## body_acc_x_train.txt data file
fileName <- "./data/train/Inertial Signals/body_acc_x_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyAccXTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyAccXTrainData <- cbind(bodyAccXTrainData, rowMeans(importedData))
bodyAccXTrainData <- bodyAccXTrainData[, c(129, 130)]
names(bodyAccXTrainData) <- c("bodyAccX-SD", "bodyAccX-Mean")

## Assambling trainData w bodyAccXTrainData
trainData <- cbind(trainData, bodyAccXTrainData)
rm(bodyAccXTrainData)

######################################################################
## body_acc_y_train.txt
fileName <- "./data/train/Inertial Signals/body_acc_y_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyAccYTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyAccYTrainData <- cbind(bodyAccYTrainData, rowMeans(importedData))
bodyAccYTrainData <- bodyAccYTrainData[, c(129, 130)]
names(bodyAccYTrainData) <- c("bodyAccY-SD", "bodyAccY-Mean")

## Assambling trainData w bodyAccXTrainData
trainData <- cbind(trainData, bodyAccYTrainData)
rm(bodyAccYTrainData)

######################################################################
## body_acc_z_train.txt file
fileName <- "./data/train/Inertial Signals/body_acc_z_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyAccZTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyAccZTrainData <- cbind(bodyAccZTrainData, rowMeans(importedData))
bodyAccZTrainData <- bodyAccZTrainData[, c(129, 130)]
names(bodyAccZTrainData) <- c("bodyAccZ-SD", "bodyAccZ-Mean")

## Assambling trainData w bodyAccXTrainData
trainData <- cbind(trainData, bodyAccZTrainData)
rm(bodyAccZTrainData)

######################################################################
## body_gyro_x_train.txt file
fileName <- "./data/train/Inertial Signals/body_gyro_x_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyGyroXTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyGyroXTrainData <- cbind(bodyGyroXTrainData, rowMeans(importedData))
bodyGyroXTrainData <- bodyGyroXTrainData[, c(129, 130)]
names(bodyGyroXTrainData) <- c("bodyGyroX-SD", "bodyGyroX-Mean")

## Assambling trainData w bodyAccXTrainData
trainData <- cbind(trainData, bodyGyroXTrainData)
rm(bodyGyroXTrainData)

######################################################################
## body_gyro_y_train.txt file
fileName <- "./data/train/Inertial Signals/body_gyro_y_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyGyroYTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyGyroYTrainData <- cbind(bodyGyroYTrainData, rowMeans(importedData))
bodyGyroYTrainData <- bodyGyroYTrainData[, c(129, 130)]
names(bodyGyroYTrainData) <- c("bodyGyroY-SD", "bodyGyroY-Mean")

## Assambling trainData w bodyAccXTrainData
trainData <- cbind(trainData, bodyGyroYTrainData)
rm(bodyGyroYTrainData)

######################################################################
## body_gyro_z_train.txt file
fileName <- "./data/train/Inertial Signals/body_gyro_z_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyGyroZTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyGyroZTrainData <- cbind(bodyGyroZTrainData, rowMeans(importedData))
bodyGyroZTrainData <- bodyGyroZTrainData[, c(129, 130)]
names(bodyGyroZTrainData) <- c("bodyGyroZ-SD", "bodyGyroZ-Mean")

## Assambling trainData w bodyAccXTrainData
trainData <- cbind(trainData, bodyGyroZTrainData)
rm(bodyGyroZTrainData)

######################################################################
## total_acc_x_train.txt file
fileName <- "./data/train/Inertial Signals/total_acc_x_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
totalAccXTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
totalAccXTrainData <- cbind(totalAccXTrainData, rowMeans(importedData))
totalAccXTrainData <- totalAccXTrainData[, c(129, 130)]
names(totalAccXTrainData) <- c("totalAccX-SD", "totalAccX-Mean")

## Assambling trainData w bodyAccXTrainData
trainData <- cbind(trainData, totalAccXTrainData)
rm(totalAccXTrainData)

######################################################################
## total_acc_y_train.txt file
fileName <- "./data/train/Inertial Signals/total_acc_y_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
totalAccYTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
totalAccYTrainData <- cbind(totalAccYTrainData, rowMeans(importedData))
totalAccYTrainData <- totalAccYTrainData[, c(129, 130)]
names(totalAccYTrainData) <- c("totalAccY-SD", "totalAccY-Mean")

## Assambling trainData w bodyAccXTrainData
trainData <- cbind(trainData, totalAccYTrainData)
rm(totalAccYTrainData)

######################################################################
## total_acc_z_train.txt file
fileName <- "./data/train/Inertial Signals/total_acc_z_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
totalAccZTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
totalAccZTrainData <- cbind(totalAccZTrainData, rowMeans(importedData))
totalAccZTrainData <- totalAccZTrainData[, c(129, 130)]
names(totalAccZTrainData) <- c("totalAccZ-SD", "totalAccZ-Mean")

## Assambling trainData w bodyAccXTrainData
trainData <- cbind(trainData, totalAccZTrainData)
rm(totalAccZTrainData);

######################################################################
######################################################################
##                         Test data set
######################################################################
## subject_test.txt file
subjectTestFile <- "./data/test/subject_test.txt"
df_subjectTest <- read.table(subjectTestFile, colClasses = "numeric")

######################################################################
## y_test.txt file
yTestFile <- "./data/test/y_test.txt"
initial <- read.table(yTestFile, nrows = 100)
classes <- sapply(initial, class)
yTestData <- read.table(yTestFile, colClasses = classes)

######################################################################
## X_test.txt file
XTestFile <- "./data/test/X_test.txt"
initial <- read.table(XTestFile, nrows = 100)
classes <- sapply(initial, class)
XTestData <- read.table(XTestFile, colClasses = classes)

######################################################################
## Assambling data test dataframe
testData <- cbind(yTestData, df_subjectTest, XTestData, rep("test", nrow(yTestData)))
names(testData) <- c("ActivityLabel", "SubjectId", features, "setName")

rm(classes); rm(df_subjectTest); rm(features); rm(fileName)
rm(importedData); rm(initial); rm(subjectTestFile)
rm(XTestData); rm(XTestFile); rm(yTestData); rm(yTestFile)

######################################################################
## Test Inertial Signals analysis
##
## body_acc_x_test.txt data file
fileName <- "./data/test/Inertial Signals/body_acc_x_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyAccXTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyAccXTestData <- cbind(bodyAccXTestData, rowMeans(importedData))
bodyAccXTestData <- bodyAccXTestData[, c(129, 130)]
names(bodyAccXTestData) <- c("bodyAccX-SD", "bodyAccX-Mean")

## Assambling testData w bodyAccXTestData
testData <- cbind(testData, bodyAccXTestData)
rm(bodyAccXTestData)

######################################################################
## body_acc_y_test.txt
fileName <- "./data/test/Inertial Signals/body_acc_y_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyAccYTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyAccYTestData <- cbind(bodyAccYTestData, rowMeans(importedData))
bodyAccYTestData <- bodyAccYTestData[, c(129, 130)]
names(bodyAccYTestData) <- c("bodyAccY-SD", "bodyAccY-Mean")

## Assambling testData w bodyAccXTestData
testData <- cbind(testData, bodyAccYTestData)
rm(bodyAccYTestData)

######################################################################
## body_acc_z_test.txt file
fileName <- "./data/test/Inertial Signals/body_acc_z_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyAccZTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyAccZTestData <- cbind(bodyAccZTestData, rowMeans(importedData))
bodyAccZTestData <- bodyAccZTestData[, c(129, 130)]
names(bodyAccZTestData) <- c("bodyAccZ-SD", "bodyAccZ-Mean")

## Assambling testData w bodyAccXTestData
testData <- cbind(testData, bodyAccZTestData)
rm(bodyAccZTestData)

######################################################################
## body_gyro_x_test.txt file
fileName <- "./data/test/Inertial Signals/body_gyro_x_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyGyroXTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyGyroXTestData <- cbind(bodyGyroXTestData, rowMeans(importedData))
bodyGyroXTestData <- bodyGyroXTestData[, c(129, 130)]
names(bodyGyroXTestData) <- c("bodyGyroX-SD", "bodyGyroX-Mean")

## Assambling testData w bodyAccXTestData
testData <- cbind(testData, bodyGyroXTestData)
rm(bodyGyroXTestData)

######################################################################
## body_gyro_y_test.txt file
fileName <- "./data/test/Inertial Signals/body_gyro_y_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyGyroYTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyGyroYTestData <- cbind(bodyGyroYTestData, rowMeans(importedData))
bodyGyroYTestData <- bodyGyroYTestData[, c(129, 130)]
names(bodyGyroYTestData) <- c("bodyGyroY-SD", "bodyGyroY-Mean")

## Assambling testData w bodyAccXTestData
testData <- cbind(testData, bodyGyroYTestData)
rm(bodyGyroYTestData)

######################################################################
## body_gyro_z_test.txt file
fileName <- "./data/test/Inertial Signals/body_gyro_z_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
bodyGyroZTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
bodyGyroZTestData <- cbind(bodyGyroZTestData, rowMeans(importedData))
bodyGyroZTestData <- bodyGyroZTestData[, c(129, 130)]
names(bodyGyroZTestData) <- c("bodyGyroZ-SD", "bodyGyroZ-Mean")

## Assambling testData w bodyAccXTestData
testData <- cbind(testData, bodyGyroZTestData)
rm(bodyGyroZTestData)

######################################################################
## total_acc_x_test.txt file
fileName <- "./data/test/Inertial Signals/total_acc_x_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
totalAccXTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
totalAccXTestData <- cbind(totalAccXTestData, rowMeans(importedData))
totalAccXTestData <- totalAccXTestData[, c(129, 130)]
names(totalAccXTestData) <- c("totalAccX-SD", "totalAccX-Mean")

## Assambling testData w bodyAccXTestData
testData <- cbind(testData, totalAccXTestData)
rm(totalAccXTestData)

######################################################################
## total_acc_y_test.txt file
fileName <- "./data/test/Inertial Signals/total_acc_y_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
totalAccYTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
totalAccYTestData <- cbind(totalAccYTestData, rowMeans(importedData))
totalAccYTestData <- totalAccYTestData[, c(129, 130)]
names(totalAccYTestData) <- c("totalAccY-SD", "totalAccY-Mean")

## Assambling testData w bodyAccXTestData
testData <- cbind(testData, totalAccYTestData)
rm(totalAccYTestData)

######################################################################
## total_acc_z_test.txt file
fileName <- "./data/test/Inertial Signals/total_acc_z_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
totalAccZTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
totalAccZTestData <- cbind(totalAccZTestData, rowMeans(importedData))
totalAccZTestData <- totalAccZTestData[, c(129, 130)]
names(totalAccZTestData) <- c("totalAccZ-SD", "totalAccZ-Mean")

## Assambling testData w bodyAccXTestData
testData <- cbind(testData, totalAccZTestData)
rm(totalAccZTestData); rm(fileName); rm(importedData)

######################################################################
## Merge data training and test dataframes
######################################################################

UCI_HAR_Data <- rbind(trainData, testData)
rm(testData); rm(trainData)

## Dumping UCI_HAR_Data dataframe
dump("UCI_HAR_Data", file = "./data/UCI_HAR_Data.R")

######################################################################
## Calculating average for each variable and dump in a separated data
## frame file UCI_HAR_Averages.R
######################################################################

tmp <- subset(UCI_HAR_Data, select = -setName ) # Subsetting dataframe
                                        # to eliminate setName factor
                                        # in order to calculate the
                                        # mean of each feature

UCI_HAR_Averages <- aggregate(tmp, by = list(tmp$ActivityLabel,
                                     tmp$SubjectId), FUN = mean, na.rm
                              = TRUE)   # Grouping by Activity and
                                        # Subject and calculate the
                                        # mean of each feature

rm(tmp)                                 # Deleting temporal dataframe

## Dumping UCI_HAR_Averages data frame
dump("UCI_HAR_Averages", file = "./data/UCI_HAR_Averages.R")

print("   ***   run_analysis.R  DONE!   ***")
######################################################################
### run_analysis.R ends here
