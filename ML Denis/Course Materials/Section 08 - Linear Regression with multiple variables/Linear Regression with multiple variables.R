Price in Mio# We set the Working Directory to the folder of this file.
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

# Read data
hotels <- fread("hotels.csv")
print(hotels)

train.index <- createDataPartition(hotels$`Price in million`, p = 0.75, list = FALSE)
train <- hotels[train.index, ]
test <- hotels[-train.index, ]

# We're reducing the number of cases where R has exponential notation
# Used
options(scipen = 100)

# Train model
model <- lm(`Price in million` ~ Squaremeters + Profit, data = train)
print(model)

test$`Price in million (Prediction)` <- predict(model, test)
print(test)
