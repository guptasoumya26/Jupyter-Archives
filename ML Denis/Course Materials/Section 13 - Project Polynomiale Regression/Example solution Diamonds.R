# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}


# Load required libraries
library(scales)
library(stats)
library(data.table)
library(caret)
library(miscTools)

# Import data 
# Quelle: https://www.kaggle.com/shivam2503/diamonds
diamonds <- fread("diamonds.csv")
print(diamonds)

train.index <- createDataPartition(diamonds$price, list = FALSE, p = 0.75)
train <- diamonds[train.index, ]
test <- diamonds[-train.index, ]
  
# Task 1: Linear regression based on the "carat" column
model1 <- lm(price ~ carat, data = train)
test$model1 <- predict(model1, test)
print(rSquared(test$price, test$price - test$model1))
  
# Task 2: Linear regression based on columns "x", "y", and "z
model2 <- lm(price ~ x + y + z, data = train)
test$model2 <- predict(model2, test)
print(rSquared(test$price, test$price - test$model2))

# Task 3: Polynomial regression based on columns "x", "y", and "z
model3 <- lm(price ~ x + y + z + I(x * y * z), data = train)
test$model3 <- predict(model3, test)
print(rSquared(test$price, test$price - test$model3))

model4 <- lm(price ~ x * y * z, data = train)
test$model4 <- predict(model4, test)
print(rSquared(test$price, test$price - test$model4))








