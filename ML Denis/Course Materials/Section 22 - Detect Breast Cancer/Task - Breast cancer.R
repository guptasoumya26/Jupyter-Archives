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

# To be added
#   glm(diagnosis ~ ., control = list(maxit = 100))
