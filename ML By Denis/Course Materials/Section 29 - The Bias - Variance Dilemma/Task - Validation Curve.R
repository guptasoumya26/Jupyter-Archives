# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

library(data.table)
library(ggplot2)
library(caret)

source("helper.R")

data <- fread("classification.csv")
data$success <- as.factor(data$success)

set.seed(42)
train.index <- createDataPartition(data$success, p = 0.75, list = FALSE)
train <- data[train.index, ]
test <- data[-train.index, ]

# Task: Create a validation curve for a randomForest, and determine
# So the ideal size for the individual trees!
# Tip: See the documentation for the randomForest() function,
# And look at the parameter maxnodes. 
#
# --------------------------------->
# [General] -----> [Specific]

library(randomForest)

