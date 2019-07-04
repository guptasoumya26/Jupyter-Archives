f <- function(a) {
  print(a)
}
f("Hello World")

#### Example 2 ####
f2 <- function(a) {
  print(a)
}
f2()

#### Example 3 ####
f3 <- function(a) {
  print("---")
  print(a)
  print("...")
}
f3()

#### Example 4 ####
f4 <- function(a) {
  print("---")
  if (!missing(a)) {
    print(a)
  }
  print("...")
}
f4(123)

#### Example 5 ####
f5 <- function(a) {
  print(substitute(a))
}
f5(2 + 3)

#### Example 6 ####
f6 <- function(a) {
  print(substitute(a))
}
f6(Age + Interest)

#### Example 7 ####

# install.packages("ggplot2")
library(ggplot2)

# install.packages("data.table")
library(data.table)

df <- data.table(Age = c(20, 21, 22), Height = c(1.80, 1.70, 1.75))
print(df)

qplot(Age, Height, data = df)