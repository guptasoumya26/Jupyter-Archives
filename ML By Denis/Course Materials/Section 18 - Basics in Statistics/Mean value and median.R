# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

# Load required libraries
library(ggplot2)
library(data.table)

# Import Data
# Source: https://www.kaggle.com/shivam2503/diamonds
diamonds <- fread("diamonds.csv")

print(mean(diamonds$price))
print(median(diamonds$price))

print(summary(diamonds))