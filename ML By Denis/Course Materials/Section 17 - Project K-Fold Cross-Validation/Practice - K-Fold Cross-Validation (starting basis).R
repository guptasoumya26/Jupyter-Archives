# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

# Load required libraries
library(ggplot2)
library(scales)
library(stats)
library(data.table)
library(caret)
library(miscTools)

# Import Data
# Quelle: https://www.kaggle.com/shivam2503/diamonds
diamonds <- fread("diamonds.csv")

train.index <- createDataPartition(diamonds$price, list = FALSE, p = 0.75)
train <- diamonds[train.index, ]
test <- diamonds[-train.index, ]

# Part 1: Linear regression based on the column "carat"
model1 <- lm(price ~ carat, data = train)
test$model1 <- predict(model1, test)
print(rSquared(test$price, test$price - test$model1))

# Part 2: Linear regression based on the columns "x", "y" and "z".
model2 <- lm(price ~ x + y + z, data = train)
test$model2 <- predict(model2, test)
print(rSquared(test$price, test$price - test$model2))

