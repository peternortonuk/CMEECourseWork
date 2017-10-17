# Exercise 9.1.1, The apply family
rm(list=ls())
M = matrix(rnorm(100),10,10)

R1 = rowMeans(M)
R2 = apply(M,1,mean) # this two functions are the same, dont need apply for this
print(R2)

C1 = colMeans(M)
C2 = apply(M,2,mean)
print(C2)

