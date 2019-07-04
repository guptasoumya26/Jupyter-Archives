# install.packages("data.table")
library(data.table)

df <- data.table(Age = c(20, 21, 22), Height = c(1.80, 1.70, 1.75))
# print("Hello World")

print(class(df))

# print.data.table <- function(df) {
#   print("Hello World")
# }

print(df)

