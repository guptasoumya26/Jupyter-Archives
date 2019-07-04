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

# Read data
fields <- fread("fields.csv")
print(fields)

set.seed(42)
train.index <- createDataPartition(fields$profit, p = 0.75, list = FALSE)
train <- fields[train.index, ]
test <- fields[-train.index, ]

# Train model
model <- lm(profit ~ poly(width, 2) + poly(length, 2), data = train)
print(summary(model))

test$profit.pred <- predict(model, test)
print(rSquared(test$profit, test$profit - test$profit.pred))