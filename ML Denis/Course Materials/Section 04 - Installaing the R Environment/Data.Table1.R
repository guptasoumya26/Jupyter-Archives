# install.packages("data.table")
library(data.table)

df <- data.table(Age = c(20, 21, 22, 23), Height = c(1.80, 1.70, 1.75, 1.85))
print(df$Age)

print(min(df$Age))
print(max(df$Age))
print(mean(df$Age))

# print(df[, min(Age)])
# print(df[, max(Age)])
# print(df[, mean(Age)])