# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

library(data.table)
library(ggplot2)

salaries <- fread("sf_salaries.csv")

print(mean(salaries[Year == 2012, TotalPay]))
print(mean(salaries[Year == 2013, TotalPay]))
print(mean(salaries[Year == 2014, TotalPay]))

print(mean(salaries$TotalPay))
print(median(salaries$TotalPay))

g <- qplot(salaries$TotalPay, binwidth = 5000)
print(g)