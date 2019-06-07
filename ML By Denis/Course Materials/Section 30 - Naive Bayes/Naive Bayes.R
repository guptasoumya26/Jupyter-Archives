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

set.seed(42)
train.index <- createDataPartition(data$success, p = 0.75, list = FALSE)
train <- data[train.index, ]
test <- data[-train.index, ]

# e1071: Institut für Statistik und Wahrscheinlichkeitstheorie, TU Wien
# install.packages("e1071")
library(e1071)

model <- naiveBayes(success ~ age + interest, train)
print(model)

g <- plot_classifier(model, train, success ~ age + interest, proba = TRUE)
print(g)

pred <- predict(model, test, type = "class")
print(confusionMatrix(pred, test$success)$overall["Accuracy"])