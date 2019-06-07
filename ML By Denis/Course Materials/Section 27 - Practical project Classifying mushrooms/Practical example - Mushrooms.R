# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

library(data.table)
library(ggplot2)
library(caret)

mushrooms <- fread("mushrooms.csv")
mushrooms$class <- as.factor(mushrooms$class)

print(summary(mushrooms))

set.seed(42)
train.index <- createDataPartition(mushrooms$class, p = 0.75, list = FALSE)
train <- mushrooms[train.index, ]
test <- mushrooms[-train.index, ]

# install.packages("rpart")
library(rpart)

rpart(class ~ .)
