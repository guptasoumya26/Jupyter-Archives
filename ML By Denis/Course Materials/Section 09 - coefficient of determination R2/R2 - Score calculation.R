# We set the working directory to the folder of this file.
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# Load required libraries
library(ggplot2)
library(scales)
library(stats)
library(data.table)
library(caret)

# Read data
hotels <- fread("hotels.csv")
print(hotels)

train.index <- createDataPartition(hotels$`Price in million`, p = 0.75, list = FALSE)
train <- hotels[train.index, ]
test <- hotels[-train.index, ]

# Hereby we reduce the cases where R is used the exponential notation
options(scipen = 100)

# Train model
model <- lm(`Price in million` ~ Squaremeters + Profit, data = train)
print(model)

test$`Price in million (Prediction)` <- predict(model, test)
print(test)

# Calculate coefficient of determination
print(summary(model))
print(summary(model)$r.squared)

# install.packages("miscTools")
require(miscTools)

print(rSquared(test$`Price in million`, test$`Price in million` - test$`Price in million (Prediction)`))
print(rSquared(test$`Price in million`, test$`Price in million (Prediction)` - test$`Price in million`))