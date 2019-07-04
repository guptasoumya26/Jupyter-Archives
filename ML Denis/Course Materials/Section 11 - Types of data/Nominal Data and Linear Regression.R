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
library(caret)
library(miscTools)

# Read data... # The encoding parameter ensures that umlauts from the file
# are always correctly read in.
hotels <- fread("hotels.csv", encoding = "UTF-8")

hotels$Stadt <- as.factor(hotels$Stadt)

train.index <- createDataPartition(hotels$`Price in million`, p = 0.75, list = FALSE)
train <- hotels[train.index, ]
test <- hotels[-train.index, ]

options(scipen = 100)

# Train model
model <- lm(`Price in million` ~ Squaremeters + Profit + City, data = train)
print(model)

# Price in million = 6.117182689 + qm * 0.003946123 + Profit * 0.000008606 + [City Cologne] * -2.693788942 
#  + [City Munich] * 3.344617983 

# predict data
test$`Price in million (Prediction)` <- predict(model, test)
print(rSquared(test$`Price in million`, test$`Price in million` - test$`Price in million (Prediction)`))