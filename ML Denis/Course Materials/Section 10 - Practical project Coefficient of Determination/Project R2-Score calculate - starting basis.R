# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}


# Load required libraries
library(ggplot2)
library(scales)
library(stats) # Actually not needed, usually loaded automatically
library(data.table)

# Task: Based on our car data.
# mileage, but also the number of horsepower (column: powerPS) in our
# Let the model flow in? 
# Create 2 models, one with the column PS, one with the column 
# a model without the column PS, and compare the coefficient of determination
# Based on the test data. 
# Note: Only if you want to use the coefficient of determination based on the test data. 
# Compare, you get to know which model appreciates better # 
# R^2 based on the training data can be very wrong in some cases
# (but we'll look at why later on)... why)...)

# Import Data
cars <- fread("autos_prepared.csv")

# Adjust the code from here!

# Calculate model
model <- lm(price ~ kilometer, data = cars)
print(model)

# Draw in graphic
g <- qplot(kilometer, price, data = cars) + 
  geom_smooth(method = "lm", se = FALSE, color = I("red"))
print(g)
