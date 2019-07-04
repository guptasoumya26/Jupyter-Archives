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

set.seed(25)
train.index <- createDataPartition(mushrooms$class, p = 0.75, list = FALSE)
train <- mushrooms[train.index, ]
test <- mushrooms[-train.index, ]

# install.packages("rpart")
library(rpart)

model <- rpart(class ~ ., 
               data = train, 
               parms = list(split = "information"), 
               method = "class",
               control = rpart.control(minsplit = 2, xval = 1, minbucket = 1, cp = 0.001))
print(model)

library(rpart.plot)

rpart.plot(model)

pred <- predict(model, test, type = "class")
print(confusionMatrix(pred, test$class)$overall["Accuracy"])