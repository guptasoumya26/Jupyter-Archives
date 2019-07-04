# This will set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

# Load required libraries
library(ggplot2)
library(scales)
library(stats) #  Actually not needed, usually loaded automatically
library(data.table)

# Task: Predict the sales price on the basis of mileage

# Task (Part 1): Reading in data
cars <- fread("autos_prepared.csv")

# Task (Part 2): Draw Scatter Plot
g <- qplot(kilometer, price, data = cars)
print(g)

# Task (Part 3): Calculate model
model <- lm(price ~ kilometer, data = cars)
print(model)
# Price = 15990 - 0.08797 * km

# Task (part 4): Draw in graphic
g <- qplot(kilometer, price, data = cars) + 
  geom_smooth(method = "lm", se = FALSE, color = I("red"))

print(g)
