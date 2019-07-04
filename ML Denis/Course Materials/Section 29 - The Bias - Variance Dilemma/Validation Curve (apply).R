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
data$success <- as.factor(data$success)

set.seed(42)
train.index <- createDataPartition(data$success, p = 0.75, list = FALSE)
train <- data[train.index, ]
test <- data[-train.index, ]

#-------------------------------->
# [General] -----> [Specific]
# k = 40      -----> k = 1

xs <- 40:1

acc <- sapply(xs, function(x) {
  model <- knn3(success ~ age + interest, data = train, k = x)
  
  pred.test <- predict(model, test, type = "class")
  pred.test.acc <- confusionMatrix(pred.test, test$success)$overall["Accuracy"]

  pred.train <- predict(model, train, type = "class")
  pred.train.acc <- confusionMatrix(pred.train, train$success)$overall["Accuracy"]
  
  return(c(pred.train.acc, pred.test.acc))
})

data <- data.frame(x = xs, train = acc[1, ], test = acc[2, ])
print(data)

# install.packages("tidyr")
library(tidyr)
plot_data <- gather(data, "type", "value", -x)

g <- qplot(x = x, y = value, data = plot_data, color = type, geom = "path", xlim = c(40, 1))
print(g)