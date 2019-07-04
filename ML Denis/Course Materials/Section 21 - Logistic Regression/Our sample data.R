# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

library(data.table)
library(ggplot2)

data <- fread("classification.csv")
data$success <- as.logical(data$success)

print(data)

g <- qplot(x = scale(age), scale(interest), color = success, data = data)
print(g)
