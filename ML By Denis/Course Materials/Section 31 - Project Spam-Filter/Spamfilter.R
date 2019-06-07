# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

library(data.table)
library(ggplot2)
library(caret)

data <- fread("spam.csv")
data$type <- as.factor(data$type)

# install.packages("naivebayes")
library(naivebayes)

# install.packages("tm")
library(tm)

set.seed(42)
train.index <- createDataPartition(data$type, p = 0.75, list = FALSE)
train <- data[train.index, ]
test <- data[-train.index, ]

corpus.train <- Corpus(VectorSource(train$message))
corpus.test <- Corpus(VectorSource(test$message))

freq <- findFreqTerms(DocumentTermMatrix(corpus.train), lowfreq = 10, highfreq = 200)

dtm.train <- DocumentTermMatrix(corpus.train, control = list(dictionary = freq))
dtm.test <- DocumentTermMatrix(corpus.test, control = list(dictionary = freq))

dtm.train.prepared <- as.matrix(dtm.train > 0)
dtm.test.prepared <- as.matrix(dtm.test > 0)

model <- naive_bayes(dtm.train.prepared, train$type)

pred <- predict(model, dtm.test.prepared, type = "class")
print(confusionMatrix(pred, test$type)$overall["Accuracy"])

