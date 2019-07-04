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
data$success <- as.logical(data$success)

train.index <- createDataPartition(data$success, p = 0.75, list = FALSE)
train <- data[train.index, ]
test <- data[-train.index, ]

model <- knn3(success ~ age + interest, data = train, k = 5)
print(model)

g <- plot_classifier(model, train, success ~ age + interest, proba = TRUE)
print(g)

g <- plot_classifier(model, test, success ~ age + interest, proba = TRUE)
print(g)

predictions <- predict(model, test)[, 2]
print(confusionMatrix(predictions > 0.5, test$success))