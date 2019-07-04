m <- matrix(c(1, 2, 3, 4, 5, 6), ncol = 3, byrow = TRUE)
print(m)

print(m[2,])
print(m[,2])

print(m[2, 3])

m[2, 3] <- 7
print(m)

print("Set Column")
m[,2] <- c(8, 9)
print(m)

print("--------------")
n <- matrix(c(1, 2, 3, 4, 5, 6), ncol = 3, byrow = TRUE)
print(n[1:2, 2:3])