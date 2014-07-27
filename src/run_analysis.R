### run_analysis.R --- 
## 
## Filename: run_analysis.R
## Description: 
## Author: Sergio-Feliciano Mendoza-Barrera
## Maintainer: 
## Created: Sat Jul 26 13:38:25 2014 (-0500)
## Version: 
## Package-Requires: ()
## Last-Updated: Sat Jul 26 22:39:27 2014 (-0500)
##           By: Sergio-Feliciano Mendoza-Barrera
##     Update #: 109
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
## Summary analysis of each file

######################################################################
##                         Training data set
######################################################################
## features.txt file
featuresFile <- "./data/features.txt"
df_features <- read.table(featuresFile, colClasses = "character")

dim(df_features)
class(df_features)
head(df_features, n = 3)
tail(df_features, n = 3)
summary(df_features)
str(df_features)
## Check for missing values
sum(is.na(df_features))
any(is.na(df_features))

## Subsetting features data frame to obtain a vector of names
features <- df_features[, 2]
features <- gsub("()", "", features, fixed = TRUE)
features <- gsub(",", "_", features, fixed = TRUE)
features <- gsub("(", "-", features, fixed = TRUE)
features <- gsub(")", "", features, fixed = TRUE)

class(features)
length(features)
head(features, n = 10)

######################################################################
## subject_train.txt file
subjectTrainFile <- "./data/train/subject_train.txt"
df_subjectTrain <- read.table(subjectTrainFile, colClasses = "numeric")
dim(df_subjectTrain)
class(df_subjectTrain)
head(df_subjectTrain, n = 3)
tail(df_subjectTrain, n = 3)
summary(df_subjectTrain)
str(df_subjectTrain)
## Check for missing values
sum(is.na(df_subjectTrain))
any(is.na(df_subjectTrain))

######################################################################
##
## y_train.txt file
yTrainFile <- "./data/train/y_train.txt"
initial <- read.table(yTrainFile, nrows = 100)
classes <- sapply(initial, class)
yTrainData <- read.table(yTrainFile, colClasses = classes)

dim(yTrainData)
class(yTrainData)
head(yTrainData, n = 3)
tail(yTrainData, n = 3)
summary(yTrainData)
str(yTrainData)
## Check for missing values
sum(is.na(yTrainData))
any(is.na(yTrainData))

######################################################################
##
## X_train.txt file
XTrainFile <- "./data/train/X_train.txt"
initial <- read.table(XTrainFile, nrows = 100)
classes <- sapply(initial, class)
XTrainData <- read.table(XTrainFile, colClasses = classes)

dim(XTrainData)
class(XTrainData)
head(XTrainData, n = 3)
tail(XTrainData, n = 3)
summary(XTrainData)
str(XTrainData)
## Check for missing values
sum(is.na(XTrainData))
any(is.na(XTrainData))

######################################################################
## Assambling data training dataframe
trainData <- cbind(yTrainData, df_subjectTrain, XTrainData, rep("train", nrow(yTrainData)))
dim(trainData)
head(trainData[1:10], 1)
names(trainData) <- c("Training-Labels", "Subject", features, "set-Name")

head(trainData[1:ncol(trainData)], 1)                # Sampling result
head(trainData[1:10], 1)
tail(trainData[1:ncol(trainData)], 1)
tail(trainData[1:10], 1)

######################################################################
##                         Test data set
######################################################################
## subject_test.txt file
subjectTestFile <- "./data/test/subject_test.txt"
df_subjectTest <- read.table(subjectTestFile, colClasses = "numeric")
dim(df_subjectTest)
class(df_subjectTest)
head(df_subjectTest, n = 3)
tail(df_subjectTest, n = 3)
summary(df_subjectTest)
str(df_subjectTest)
## Check for missing values
sum(is.na(df_subjectTest))
any(is.na(df_subjectTest))

######################################################################
## y_test.txt file
yTestFile <- "./data/test/y_test.txt"
initial <- read.table(yTestFile, nrows = 100)
classes <- sapply(initial, class)
yTestData <- read.table(yTestFile, colClasses = classes)

dim(yTestData)
class(yTestData)
head(yTestData, n = 3)
tail(yTestData, n = 3)
summary(yTestData)
str(yTestData)
## Check for missing values
sum(is.na(yTestData))
any(is.na(yTestData))

######################################################################
## X_test.txt file
XTestFile <- "./data/test/X_test.txt"
initial <- read.table(XTestFile, nrows = 100)
classes <- sapply(initial, class)
XTestData <- read.table(XTestFile, colClasses = classes)

dim(XTestData)
class(XTestData)
head(XTestData, n = 3)
tail(XTestData, n = 3)
summary(XTestData)
str(XTestData)
## Check for missing values
sum(is.na(XTestData))
any(is.na(XTestData))

######################################################################
## Assambling data test dataframe
testData <- cbind(yTestData, df_subjectTest, XTestData, rep("test", nrow(yTestData)))
dim(testData)
head(testData[1:10], 1)
names(testData) <- c("Test-Labels", "Subject", features, "set-Name")
head(testData[1:ncol(testData)], 1)                # Sampling result
head(testData[1:10], 1)
tail(testData[1:ncol(testData)], 1)
tail(testData[1:10], 1)

######################################################################
## Merge data training and test dataframes
head(names(trainData), n = 10)
head(trainData$Subject, n = 20)

names(testData)
head(testData$Subject, n = 20)

UCI_HAR_Data_1 <- merge(trainData, testData, by = "Subject", all = TRUE)
dim(UCI_HAR_Data_1)
summary(UCI_HAR_Data_1$"set-Name.x")
summary(UCI_HAR_Data_1$"set-Name.y")

######################################################################
### run_analysis.R ends here
