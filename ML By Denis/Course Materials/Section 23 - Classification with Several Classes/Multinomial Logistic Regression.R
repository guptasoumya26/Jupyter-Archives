# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

library(data.table)
library(ggplot2)
library(caret)

# import data
foods <- fread("foods.csv")
foods$clss <- as.factor(foods$clss)

# Train / Test
train.index <- createDataPartition(foods$clss, p = 0.75, list = FALSE)
train <- foods[train.index, ]
test <- foods[-train.index, ]

# install.packages("nnet")
library(nnet)

model <- multinom(clss ~ energy_100g + fat_100g + carbohydrates_100g + sugars_100g + proteins_100g,
                  data = train)

pred <- predict(model, test)

print(confusionMatrix(pred, test$clss)$overall["Accuracy"])