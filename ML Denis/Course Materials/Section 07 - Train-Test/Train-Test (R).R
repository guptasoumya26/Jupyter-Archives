# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

# Load required libraries
library(ggplot2)
library(scales)
library(stats)
library(data.table)

# Read data 
apartments <- fread("flatprices.csv")

# install.packages("caret")
library(caret)

# Train / Test
set.seed(42)
train.index <- createDataPartition(apartments$Price, list = FALSE, p = 0.75)
train <- apartments[train.index, ]
test <- apartments[-train.index, ]

g <- qplot(Squaremeters, Price, data = train) + 
  geom_smooth(method = "lm", se = FALSE, data = train) + 
  geom_point(data = test, color = I("red"))
print(g)

model <- lm(Price ~ Squaremeters, data = train)
print(model)

test$PricePredicted <- predict(model, test)
print(test)
