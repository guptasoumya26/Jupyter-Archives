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
# Source: https://www.kaggle.com/shivam2503/diamonds
diamonds <- fread("diamonds.csv")

splits = createMultiFolds(diamonds$price, k = 4, times = 10)

r2.carat = numeric()
r2.xyz = numeric()

for (split in splits) {
  train <- diamonds[split, ]
  test <- diamonds[-split, ]
  
  # Part 1: Linear regression based on the column "carat"
  model1 <- lm(price ~ carat, data = train)
  test$model1 <- predict(model1, test)
  r2.carat <- c(r2.carat, rSquared(test$price, test$price - test$model1))
  
  # Part 2: Linear regression based on the columns "x", "y" and "z".
  model2 <- lm(price ~ x + y + z, data = train)
  test$model2 <- predict(model2, test)
  r2.xyz <- c(r2.xyz, rSquared(test$price, test$price - test$model2))
}

print(mean(r2.carat))
print(mean(r2.xyz))


