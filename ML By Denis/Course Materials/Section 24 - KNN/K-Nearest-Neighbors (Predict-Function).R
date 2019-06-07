# Damit setzen wir das Working Directory auf den Ordner dieser Datei
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

train.index <- createDataPartition(data$success, p = 0.75, list = FALSE)
train <- data[train.index, ]
test <- data[-train.index, ]

model <- knn3(success ~ age + interest, data = train, k = 5)
print(model)

predictions <- predict(model, test, type = "prob")
print(predictions)