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

# install.packages("rpart")
library(rpart)

model <- rpart(success ~ age + interest, 
               data = train, 
               parms = list(split = "information"), 
               method = "class",
               control = rpart.control(minsplit = 1, xval = 1, minbucket = 1, cp = 0.01))
print(model)

# install.packages("rpart.plot")
library(rpart.plot)
print(prp(model))

g <- plot_classifier(model, train, success ~ age + interest, proba = FALSE)
print(g)

g <- plot_classifier(model, test, success ~ age + interest, proba = FALSE)
print(g)

