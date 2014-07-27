### run_analysis.R --- 
## 
## Filename: run_analysis.R
## Description: 
## Author: Sergio-Feliciano Mendoza-Barrera
## Maintainer: 
## Created: Sat Jul 26 13:38:25 2014 (-0500)
## Version: 
## Package-Requires: ()
## Last-Updated: Sun Jul 27 08:16:36 2014 (-0500)
##           By: Sergio-Feliciano Mendoza-Barrera
##     Update #: 203
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

## dim(df_features)
## class(df_features)
## head(df_features, n = 3)
## tail(df_features, n = 3)
## summary(df_features)
## str(df_features)
## ## Check for missing values
## sum(is.na(df_features))
## any(is.na(df_features))

## Subsetting features data frame to obtain a vector of names
features <- df_features[, 2]
features <- gsub("()", "", features, fixed = TRUE)
features <- gsub(",", "_", features, fixed = TRUE)
features <- gsub("(", "-", features, fixed = TRUE)
features <- gsub(")", "", features, fixed = TRUE)

## class(features)
## length(features)
## head(features, n = 10)

######################################################################
## subject_train.txt file
subjectTrainFile <- "./data/train/subject_train.txt"
df_subjectTrain <- read.table(subjectTrainFile, colClasses = "numeric")
## dim(df_subjectTrain)
## class(df_subjectTrain)
## head(df_subjectTrain, n = 3)
## tail(df_subjectTrain, n = 3)
## summary(df_subjectTrain)
## str(df_subjectTrain)
## ## Check for missing values
## sum(is.na(df_subjectTrain))
## any(is.na(df_subjectTrain))

######################################################################
##
## y_train.txt file
yTrainFile <- "./data/train/y_train.txt"
initial <- read.table(yTrainFile, nrows = 100)
classes <- sapply(initial, class)
yTrainData <- read.table(yTrainFile, colClasses = classes)

## dim(yTrainData)
## class(yTrainData)
## head(yTrainData, n = 3)
## tail(yTrainData, n = 3)
## summary(yTrainData)
## str(yTrainData)
## ## Check for missing values
## sum(is.na(yTrainData))
## any(is.na(yTrainData))

######################################################################
##
## X_train.txt file
XTrainFile <- "./data/train/X_train.txt"
initial <- read.table(XTrainFile, nrows = 100)
classes <- sapply(initial, class)
XTrainData <- read.table(XTrainFile, colClasses = classes)

## dim(XTrainData)
## class(XTrainData)
## head(XTrainData, n = 3)
## tail(XTrainData, n = 3)
## summary(XTrainData)
## str(XTrainData)
## ## Check for missing values
## sum(is.na(XTrainData))
## any(is.na(XTrainData))

######################################################################
## Assambling data training dataframe
trainData <- cbind(yTrainData, df_subjectTrain, XTrainData, rep("train", nrow(yTrainData)))
## dim(trainData)
## head(trainData[1:10], 1)
names(trainData) <- c("ActivityLabel", "SubjectId", features, "setName")

## head(trainData[1:ncol(trainData)], 1)                # Sampling result
## head(trainData[1:10], 1)
## tail(trainData[1:ncol(trainData)], 1)
## tail(trainData[1:10], 1)

## ls()
rm(classes); rm(df_features); rm(df_subjectTrain); ## rm(features)
rm(featuresFile); rm(initial); rm(subjectTrainFile)
rm(XTrainData); rm(XTrainFile); rm(yTrainData); rm(yTrainFile)

######################################################################
## Training Inertial Signals analysis
##
## body_acc_x_train.txt data file
fileName <- "./data/train/Inertial Signals/body_acc_x_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyAccXTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTrainData)

bodyAccXTrainData <- cbind(bodyAccXTrainData, rowMeans(importedData))
## dim(bodyAccXTrainData)
## tail(names(bodyAccXTrainData))

bodyAccXTrainData <- bodyAccXTrainData[, c(129, 130)]
names(bodyAccXTrainData) <- c("bodyAccX-SD", "bodyAccX-Mean")
## head(bodyAccXTrainData)
## rm(importedData); rm(fileName)
## ls()

## Assambling trainData w bodyAccXTrainData
## dim(trainData)
trainData <- cbind(trainData, bodyAccXTrainData)
## dim(trainData)
## tail(names(trainData))
rm(bodyAccXTrainData)
## ls()

######################################################################
## body_acc_y_train.txt
fileName <- "./data/train/Inertial Signals/body_acc_y_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyAccYTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTrainData)

bodyAccYTrainData <- cbind(bodyAccYTrainData, rowMeans(importedData))
## dim(bodyAccXTrainData)
## tail(names(bodyAccXTrainData))

bodyAccYTrainData <- bodyAccYTrainData[, c(129, 130)]
names(bodyAccYTrainData) <- c("bodyAccY-SD", "bodyAccY-Mean")
## head(bodyAccXTrainData)
## rm(importedData); rm(fileName)
## ls()

## Assambling trainData w bodyAccXTrainData
## dim(trainData)
trainData <- cbind(trainData, bodyAccYTrainData)
## dim(trainData)
## tail(names(trainData))
rm(bodyAccYTrainData)
## ls()

######################################################################
## body_acc_z_train.txt file
fileName <- "./data/train/Inertial Signals/body_acc_z_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyAccZTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTrainData)

bodyAccZTrainData <- cbind(bodyAccZTrainData, rowMeans(importedData))
## dim(bodyAccXTrainData)
## tail(names(bodyAccXTrainData))

bodyAccZTrainData <- bodyAccZTrainData[, c(129, 130)]
names(bodyAccZTrainData) <- c("bodyAccZ-SD", "bodyAccZ-Mean")
## head(bodyAccXTrainData)
## rm(importedData); rm(fileName)
## ls()

## Assambling trainData w bodyAccXTrainData
## dim(trainData)
trainData <- cbind(trainData, bodyAccZTrainData)
## dim(trainData)
## tail(names(trainData))
rm(bodyAccZTrainData)
## ls()

######################################################################
## body_gyro_x_train.txt file
fileName <- "./data/train/Inertial Signals/body_gyro_x_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyGyroXTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTrainData)

bodyGyroXTrainData <- cbind(bodyGyroXTrainData, rowMeans(importedData))
## dim(bodyAccXTrainData)
## tail(names(bodyAccXTrainData))

bodyGyroXTrainData <- bodyGyroXTrainData[, c(129, 130)]
names(bodyGyroXTrainData) <- c("bodyGyroX-SD", "bodyGyroX-Mean")
## head(bodyAccXTrainData)
## rm(importedData); rm(fileName)
## ls()

## Assambling trainData w bodyAccXTrainData
## dim(trainData)
trainData <- cbind(trainData, bodyGyroXTrainData)
## dim(trainData)
## tail(names(trainData))
rm(bodyGyroXTrainData)
## ls()

######################################################################
## body_gyro_y_train.txt file
fileName <- "./data/train/Inertial Signals/body_gyro_y_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyGyroYTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTrainData)

bodyGyroYTrainData <- cbind(bodyGyroYTrainData, rowMeans(importedData))
## dim(bodyAccXTrainData)
## tail(names(bodyAccXTrainData))

bodyGyroYTrainData <- bodyGyroYTrainData[, c(129, 130)]
names(bodyGyroYTrainData) <- c("bodyGyroY-SD", "bodyGyroY-Mean")
## head(bodyAccXTrainData)
## rm(importedData); rm(fileName)
## ls()

## Assambling trainData w bodyAccXTrainData
## dim(trainData)
trainData <- cbind(trainData, bodyGyroYTrainData)
## dim(trainData)
## tail(names(trainData))
rm(bodyGyroYTrainData)
## ls()

######################################################################
## body_gyro_z_train.txt file
fileName <- "./data/train/Inertial Signals/body_gyro_z_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyGyroZTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTrainData)

bodyGyroZTrainData <- cbind(bodyGyroZTrainData, rowMeans(importedData))
## dim(bodyAccXTrainData)
## tail(names(bodyAccXTrainData))

bodyGyroZTrainData <- bodyGyroZTrainData[, c(129, 130)]
names(bodyGyroZTrainData) <- c("bodyGyroZ-SD", "bodyGyroZ-Mean")
## head(bodyAccXTrainData)
## rm(importedData); rm(fileName)
## ls()

## Assambling trainData w bodyAccXTrainData
## dim(trainData)
trainData <- cbind(trainData, bodyGyroZTrainData)
## dim(trainData)
## tail(names(trainData))
rm(bodyGyroZTrainData)
## ls()

######################################################################
## total_acc_x_train.txt file
fileName <- "./data/train/Inertial Signals/total_acc_x_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

totalAccXTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTrainData)

totalAccXTrainData <- cbind(totalAccXTrainData, rowMeans(importedData))
## dim(bodyAccXTrainData)
## tail(names(bodyAccXTrainData))

totalAccXTrainData <- totalAccXTrainData[, c(129, 130)]
names(totalAccXTrainData) <- c("totalAccX-SD", "totalAccX-Mean")
## head(bodyAccXTrainData)
## rm(importedData); rm(fileName)
## ls()

## Assambling trainData w bodyAccXTrainData
## dim(trainData)
trainData <- cbind(trainData, totalAccXTrainData)
## dim(trainData)
## tail(names(trainData))
rm(totalAccXTrainData)
## ls()

######################################################################
## total_acc_y_train.txt file
fileName <- "./data/train/Inertial Signals/total_acc_y_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

totalAccYTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTrainData)

totalAccYTrainData <- cbind(totalAccYTrainData, rowMeans(importedData))
## dim(bodyAccXTrainData)
## tail(names(bodyAccXTrainData))

totalAccYTrainData <- totalAccYTrainData[, c(129, 130)]
names(totalAccYTrainData) <- c("totalAccY-SD", "totalAccY-Mean")
## head(bodyAccXTrainData)
## rm(importedData); rm(fileName)
## ls()

## Assambling trainData w bodyAccXTrainData
## dim(trainData)
trainData <- cbind(trainData, totalAccYTrainData)
## dim(trainData)
## tail(names(trainData))
rm(totalAccYTrainData)
## ls()

######################################################################
## total_acc_z_train.txt file
fileName <- "./data/train/Inertial Signals/total_acc_z_train.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

totalAccZTrainData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTrainData)

totalAccZTrainData <- cbind(totalAccZTrainData, rowMeans(importedData))
## dim(bodyAccXTrainData)
## tail(names(bodyAccXTrainData))

totalAccZTrainData <- totalAccZTrainData[, c(129, 130)]
names(totalAccZTrainData) <- c("totalAccZ-SD", "totalAccZ-Mean")
## head(bodyAccXTrainData)
## rm(importedData); rm(fileName)
## ls()

## Assambling trainData w bodyAccXTrainData
## dim(trainData)
trainData <- cbind(trainData, totalAccZTrainData)
## dim(trainData)
## tail(names(trainData))
rm(totalAccZTrainData);
## ls()

######################################################################
######################################################################
##                         Test data set
######################################################################
## subject_test.txt file
subjectTestFile <- "./data/test/subject_test.txt"
df_subjectTest <- read.table(subjectTestFile, colClasses = "numeric")
## dim(df_subjectTest)
## class(df_subjectTest)
## head(df_subjectTest, n = 3)
## tail(df_subjectTest, n = 3)
## summary(df_subjectTest)
## str(df_subjectTest)
## ## Check for missing values
## sum(is.na(df_subjectTest))
## any(is.na(df_subjectTest))

######################################################################
## y_test.txt file
yTestFile <- "./data/test/y_test.txt"
initial <- read.table(yTestFile, nrows = 100)
classes <- sapply(initial, class)
yTestData <- read.table(yTestFile, colClasses = classes)

## dim(yTestData)
## class(yTestData)
## head(yTestData, n = 3)
## tail(yTestData, n = 3)
## summary(yTestData)
## str(yTestData)
## ## Check for missing values
## sum(is.na(yTestData))
## any(is.na(yTestData))

######################################################################
## X_test.txt file
XTestFile <- "./data/test/X_test.txt"
initial <- read.table(XTestFile, nrows = 100)
classes <- sapply(initial, class)
XTestData <- read.table(XTestFile, colClasses = classes)

## dim(XTestData)
## class(XTestData)
## head(XTestData, n = 3)
## tail(XTestData, n = 3)
## summary(XTestData)
## str(XTestData)
## ## Check for missing values
## sum(is.na(XTestData))
## any(is.na(XTestData))

######################################################################
## Assambling data test dataframe
testData <- cbind(yTestData, df_subjectTest, XTestData, rep("test", nrow(yTestData)))
## dim(testData)
## head(testData[1:10], 1)
names(testData) <- c("ActivityLabel", "SubjectId", features, "setName")
## head(testData[1:ncol(testData)], 1)                # Sampling result
## head(testData[1:10], 1)
## tail(testData[1:ncol(testData)], 1)
## tail(testData[1:10], 1)

## ls()
rm(classes); rm(df_subjectTest); rm(features); rm(fileName)
rm(importedData); rm(initial); rm(subjectTestFile)
rm(XTestData); rm(XTestFile); rm(yTestData); rm(yTestFile)

######################################################################
## Test Inertial Signals analysis
##
## body_acc_x_test.txt data file
fileName <- "./data/test/Inertial Signals/body_acc_x_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyAccXTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTestData)

bodyAccXTestData <- cbind(bodyAccXTestData, rowMeans(importedData))
## dim(bodyAccXTestData)
## tail(names(bodyAccXTestData))

bodyAccXTestData <- bodyAccXTestData[, c(129, 130)]
names(bodyAccXTestData) <- c("bodyAccX-SD", "bodyAccX-Mean")
## head(bodyAccXTestData)
## rm(importedData); rm(fileName)
## ls()

## Assambling testData w bodyAccXTestData
## dim(testData)
testData <- cbind(testData, bodyAccXTestData)
## dim(testData)
## tail(names(testData))
rm(bodyAccXTestData)
## ls()

######################################################################
## body_acc_y_test.txt
fileName <- "./data/test/Inertial Signals/body_acc_y_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyAccYTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTestData)

bodyAccYTestData <- cbind(bodyAccYTestData, rowMeans(importedData))
## dim(bodyAccXTestData)
## tail(names(bodyAccXTestData))

bodyAccYTestData <- bodyAccYTestData[, c(129, 130)]
names(bodyAccYTestData) <- c("bodyAccY-SD", "bodyAccY-Mean")
## head(bodyAccXTestData)
## rm(importedData); rm(fileName)
## ls()

## Assambling testData w bodyAccXTestData
## dim(testData)
testData <- cbind(testData, bodyAccYTestData)
## dim(testData)
## tail(names(testData))
rm(bodyAccYTestData)
## ls()

######################################################################
## body_acc_z_test.txt file
fileName <- "./data/test/Inertial Signals/body_acc_z_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyAccZTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTestData)

bodyAccZTestData <- cbind(bodyAccZTestData, rowMeans(importedData))
## dim(bodyAccXTestData)
## tail(names(bodyAccXTestData))

bodyAccZTestData <- bodyAccZTestData[, c(129, 130)]
names(bodyAccZTestData) <- c("bodyAccZ-SD", "bodyAccZ-Mean")
## head(bodyAccXTestData)
## rm(importedData); rm(fileName)
## ls()

## Assambling testData w bodyAccXTestData
## dim(testData)
testData <- cbind(testData, bodyAccZTestData)
## dim(testData)
## tail(names(testData))
rm(bodyAccZTestData)
## ls()

######################################################################
## body_gyro_x_test.txt file
fileName <- "./data/test/Inertial Signals/body_gyro_x_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyGyroXTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTestData)

bodyGyroXTestData <- cbind(bodyGyroXTestData, rowMeans(importedData))
## dim(bodyAccXTestData)
## tail(names(bodyAccXTestData))

bodyGyroXTestData <- bodyGyroXTestData[, c(129, 130)]
names(bodyGyroXTestData) <- c("bodyGyroX-SD", "bodyGyroX-Mean")
## head(bodyAccXTestData)
## rm(importedData); rm(fileName)
## ls()

## Assambling testData w bodyAccXTestData
## dim(testData)
testData <- cbind(testData, bodyGyroXTestData)
## dim(testData)
## tail(names(testData))
rm(bodyGyroXTestData)
## ls()

######################################################################
## body_gyro_y_test.txt file
fileName <- "./data/test/Inertial Signals/body_gyro_y_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyGyroYTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTestData)

bodyGyroYTestData <- cbind(bodyGyroYTestData, rowMeans(importedData))
## dim(bodyAccXTestData)
## tail(names(bodyAccXTestData))

bodyGyroYTestData <- bodyGyroYTestData[, c(129, 130)]
names(bodyGyroYTestData) <- c("bodyGyroY-SD", "bodyGyroY-Mean")
## head(bodyAccXTestData)
## rm(importedData); rm(fileName)
## ls()

## Assambling testData w bodyAccXTestData
## dim(testData)
testData <- cbind(testData, bodyGyroYTestData)
## dim(testData)
## tail(names(testData))
rm(bodyGyroYTestData)
## ls()

######################################################################
## body_gyro_z_test.txt file
fileName <- "./data/test/Inertial Signals/body_gyro_z_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

bodyGyroZTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTestData)

bodyGyroZTestData <- cbind(bodyGyroZTestData, rowMeans(importedData))
## dim(bodyAccXTestData)
## tail(names(bodyAccXTestData))

bodyGyroZTestData <- bodyGyroZTestData[, c(129, 130)]
names(bodyGyroZTestData) <- c("bodyGyroZ-SD", "bodyGyroZ-Mean")
## head(bodyAccXTestData)
## rm(importedData); rm(fileName)
## ls()

## Assambling testData w bodyAccXTestData
## dim(testData)
testData <- cbind(testData, bodyGyroZTestData)
## dim(testData)
## tail(names(testData))
rm(bodyGyroZTestData)
## ls()

######################################################################
## total_acc_x_test.txt file
fileName <- "./data/test/Inertial Signals/total_acc_x_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

totalAccXTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTestData)

totalAccXTestData <- cbind(totalAccXTestData, rowMeans(importedData))
## dim(bodyAccXTestData)
## tail(names(bodyAccXTestData))

totalAccXTestData <- totalAccXTestData[, c(129, 130)]
names(totalAccXTestData) <- c("totalAccX-SD", "totalAccX-Mean")
## head(bodyAccXTestData)
## rm(importedData); rm(fileName)
## ls()

## Assambling testData w bodyAccXTestData
## dim(testData)
testData <- cbind(testData, totalAccXTestData)
## dim(testData)
## tail(names(testData))
rm(totalAccXTestData)
## ls()

######################################################################
## total_acc_y_test.txt file
fileName <- "./data/test/Inertial Signals/total_acc_y_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

totalAccYTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTestData)

totalAccYTestData <- cbind(totalAccYTestData, rowMeans(importedData))
## dim(bodyAccXTestData)
## tail(names(bodyAccXTestData))

totalAccYTestData <- totalAccYTestData[, c(129, 130)]
names(totalAccYTestData) <- c("totalAccY-SD", "totalAccY-Mean")
## head(bodyAccXTestData)
## rm(importedData); rm(fileName)
## ls()

## Assambling testData w bodyAccXTestData
## dim(testData)
testData <- cbind(testData, totalAccYTestData)
## dim(testData)
## tail(names(testData))
rm(totalAccYTestData)
## ls()

######################################################################
## total_acc_z_test.txt file
fileName <- "./data/test/Inertial Signals/total_acc_z_test.txt"
importedData <- read.table(fileName, colClasses = "numeric")
## dim(importedData)

totalAccZTestData <- transform(importedData, SD=apply(importedData,1, sd, na.rm = TRUE))
## dim(bodyAccXTestData)

totalAccZTestData <- cbind(totalAccZTestData, rowMeans(importedData))
## dim(bodyAccXTestData)
## tail(names(bodyAccXTestData))

totalAccZTestData <- totalAccZTestData[, c(129, 130)]
names(totalAccZTestData) <- c("totalAccZ-SD", "totalAccZ-Mean")
## head(bodyAccXTestData)
## rm(importedData); rm(fileName)
## ls()

## Assambling testData w bodyAccXTestData
## dim(testData)
testData <- cbind(testData, totalAccZTestData)
## dim(testData)
## tail(names(testData))
rm(totalAccZTestData); rm(fileName); rm(importedData)
## ls()

######################################################################
## Merge data training and test dataframes
## head(names(trainData), n = 10)
## head(trainData$SubjectId, n = 20)

## head(names(testData), n = 10)
## head(testData$SubjectId, n = 20)

UCI_HAR_Data <- rbind(trainData, testData)
rm(testData); rm(trainData)

## Dumping complete dataframe
dump("UCI_HAR_Data", file = "./data/UCI_HAR_Data.R")

## dim(UCI_HAR_Data_1)
## summary(UCI_HAR_Data_1$setName)

######################################################################
### run_analysis.R ends here
