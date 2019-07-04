# We set the working directory to the folder of this file.
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# Load required libraries
library(ggplot2)
library(scales)
library(stats)
library(data.table)
library(caret)
library(miscTools)

# Import data 
hotels <- fread("hotels.csv")
splits <- createFolds(hotels$`Price in million`, k = 5, returnTrain = TRUE)

scores <- numeric()

for (split in splits) {
  train <- hotels[split, ]
  test <- hotels[-split, ]
  
  model <- lm(`Price in million` ~ Profit + Squaremeters, data = train)
  r2 <- rSquared(test$`Price in million`, test$`Price in million` - predict(model, test))
  scores <- c(scores, r2)
}

print(mean(scores))
