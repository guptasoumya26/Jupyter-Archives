# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

library(data.table)
library(ggplot2)
library(caret)

# Task: What kind of plant is it?
# Say the column `Species` beforehand. Divide the data first 
# in training and test data. Then compare the following models:
# 
# - Logistic regression (multinom via the nnet module)
# - KNN (with different values for k, e.g. k = 1, k = 3, k = 5)
#
# Note that you have to scale the data for the KNN model. 
#
# Which model has the best accuracy on the test data?
#
# Hint: 
# - The column Id is not needed for the model, this column
# should not be included in the calculation of the model with
# Flow in... #
- You want to predict the column `Species` here. This column contains
# three different values - so you want them before calculating them
# Convert to factor: iris$Species <- as.factor(iris$Species) 

iris <- fread("iris.csv")
iris$Species <- as.factor(iris$Species)
print(iris)

