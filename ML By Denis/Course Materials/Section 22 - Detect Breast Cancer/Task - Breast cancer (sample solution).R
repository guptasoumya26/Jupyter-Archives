# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

library(data.table)
library(ggplot2)
library(caret)

source("helper.R")

# Ta s k: Read the file "cancer.csv" and predestine the column "diagnosis". 
# Create a model that looks at all columns!
# (The formula is: "diagnosis ~ .").
# 
# Then calculate the "Accuracy" based on the test data!
# 
# You may ignore the following warning message 
# glm.fit: fitted probabilities numerically 0 or 1 occurred 

cancer <- fread("cancer.csv")
cancer$id <- NULL
cancer$diagnosis <- cancer$diagnosis == "M"
print(cancer)

train.index <- createDataPartition(cancer$diagnosis, p = 0.75, list = FALSE)
train <- cancer[train.index, ]
test <- cancer[-train.index, ]

model <- glm(diagnosis ~ ., data = train, family = binomial(), control = list(maxit = 100))

test$diagnosis.pred <- predict(model, test, type = "response")

result <- confusionMatrix(test$diagnosis.pred > 0.5, test$diagnosis)
print(result$overall["Accuracy"])

