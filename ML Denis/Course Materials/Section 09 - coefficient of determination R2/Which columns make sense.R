# We set the working directory to the folder of this file.
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# Load required libraries
library(ggplot2)
library(scales)
library(stats)
library(data.table)
library(caret)
require(miscTools)

# Read data
hotels <- fread("hotels.csv")
print(hotels)

# Hereby we reduce the cases where R the exponential notation is used
options(scipen = 100)

for (i in 1:10) {
  train.index <- createDataPartition(hotels$`Price in million`, p = 0.75, list = FALSE)
  train <- hotels[train.index, ]
  test <- hotels[-train.index, ]
  
  # Train model
  model.profit <- lm(`Price in million` ~ Squaremeters + Profit, data = train)
  model.noprofit <- lm(`Price in million` ~ Squaremeters, data = train)
  
  test$`Price in million (Prediction, with Profit)` <- predict(model.profit, test)
  test$`Price in million (Prediction, without Profit)` <- predict(model.noprofit, test)
  
  # Calculate coefficient of determination
  # print(summary(model.profit)$r.squared)
  r2.profit <- rSquared(test$`Price in million`, test$`Price in million` - test$`Price in million (Prediction, with Profit)`)
  r2.noprofit <- rSquared(test$`Price in million`, test$`Price in million` - test$`Price in million (Prediction, without Profit)`)
  
  print(paste(r2.profit, "-", r2.noprofit))
}