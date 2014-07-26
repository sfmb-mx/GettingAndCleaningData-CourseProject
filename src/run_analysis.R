### run_analysis.R --- 
## 
## Filename: run_analysis.R
## Description: 
## Author: Sergio-Feliciano Mendoza-Barrera
## Maintainer: 
## Created: Sat Jul 26 13:38:25 2014 (-0500)
## Version: 
## Package-Requires: ()
## Last-Updated: Sat Jul 26 18:29:59 2014 (-0500)
##           By: Sergio-Feliciano Mendoza-Barrera
##     Update #: 9
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
source("dwDataFile.R")                  # Download the dataset

fileName <- "HumanActivityRecognitionUsingSmartphones.zip"
source <-
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

dwDataFile(fileName, source)                  # Download the dataset

######################################################################
## Summary analysis of each file

## restData <- read.csv("./data/restaurants.csv")
## head(restData, n = 3)
## tail(restData, n = 3)
## summary(restData)
## str(restData)
## quantile(restData$councilDistrict, na.rm = TRUE)
## quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))

## table(restData$zipCode, useNA = "ifany")
## table(restData$councilDistrict, restData$zipCode)

## ## Check for missing values
## sum(is.na(restData$councilDistrict))
## any(is.na(restData$councilDistrict))
## all(restData$zipCode > 0)

######################################################################
### run_analysis.R ends here
