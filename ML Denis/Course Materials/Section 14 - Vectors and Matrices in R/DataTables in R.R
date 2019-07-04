library(data.table)

diamonds <- fread("diamonds.csv")
# print(diamonds[, c("carat", "cut")])
# print(diamonds[, .(carat, cut)])

# print(diamonds[1:10, ])

# diamonds[, "cut"]

# print(diamonds[diamonds$cut == "Premium" | diamonds$cut == "Good",])
# print(diamonds[cut == "Premium" | cut == "Good",])

diamonds[cut == "Premium" | cut == "Good",]$price = 10000
print(diamonds)