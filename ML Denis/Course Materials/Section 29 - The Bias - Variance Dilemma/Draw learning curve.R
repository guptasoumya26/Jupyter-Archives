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

ps <- seq(0.05, 0.95, 0.05)
all.train.acc <- numeric(0)
all.test.acc <- numeric(0)

for (p in ps) {
  now.train.acc <- numeric(0)
  now.test.acc <- numeric(0)
  for (i in 1:100) {
    train.index <- createDataPartition(data$success, p = p, list = FALSE)
    train <- data[train.index, ]
    test <- data[-train.index, ]
    
    model <- glm(success ~ age + interest, 
                 data = train, 
                 family = binomial(),
                 control = list(maxit = 500))
    
    pred.train <- predict(model, train, type = "response") > 0.5
    pred.acc <- confusionMatrix(pred.train, train$success)$overall["Accuracy"]
    now.train.acc <- c(now.train.acc, pred.acc)
    
    pred.test <- predict(model, test, type = "response") > 0.5
    pred.acc <- confusionMatrix(pred.test, test$success)$overall["Accuracy"]
    now.test.acc <- c(now.test.acc, pred.acc)
  }
  all.train.acc <- c(all.train.acc, mean(now.train.acc))
  all.test.acc <- c(all.test.acc, mean(now.test.acc))
}

data <- data.frame(x = ps, train = all.train.acc, test = all.test.acc)
print(data)

# install.packages("tidyr")
library(tidyr)
plot_data <- gather(data, "type", "value", -x)

g <- qplot(x = x, y = value, data = plot_data, color = type, geom = "path")
print(g)

