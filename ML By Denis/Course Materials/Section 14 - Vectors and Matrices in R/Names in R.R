v <- c(30, 120000, 1)
names(v) <- c("Squaremeters", "Price", "Count rooms")

print(v[1])
print(v["Squaremeters"])


print(v[c("Squaremeters", "Price")])

print(v[1])

print(names(v))