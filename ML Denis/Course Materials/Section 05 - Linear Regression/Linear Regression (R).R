# We set the working directory to the folder of this file.
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

# install.packages("data.table")
library(data.table)

dt <- fread("flatprices.csv")
print(dt)

# So we can visualize the data
# install.packages("ggplot2")
library(ggplot2)

# install.packages("scales")
library(scales)

# Create and configure graphics
qplot(Squaremeters, Price, data = dt) + 
  scale_y_continuous(labels = format_format(scientific = FALSE, big.mark = ".", decimal.mark = ","))

library(stats)
model <- lm(Price ~ Squaremeters, data = dt)
print(model)

# Price = 3143 + Squaremeters * 5071
# 3143 + 60 * 5071

qplot(Squaremeters, Price, data = dt) + 
  geom_smooth(method = "lm", se = FALSE, color = I("red")) + 
  scale_y_continuous(labels = format_format(scientific = FALSE, big.mark = ".", decimal.mark = ","))

# 
dt.pred <- data.table(Squaremeters = c(31, 91))
dt.pred$Price <- predict(model, dt.pred)
print(dt.pred)
