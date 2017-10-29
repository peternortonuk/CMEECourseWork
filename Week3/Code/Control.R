# Ex 7.15

a = TRUE
if (a ==TRUE){
  print("a is TRUE")
} else {
  print(" a is FALSE")
}

z =  runif(1)
if (z <= 0.5){
  print("less than half")
}

for (i in 1:100){
  j = i*i
  print(paste(i,"squared is", j))
}

v = c("frog", "dog","mog", "hog")
 for (animals in v){
   print(paste("the animal is ", animal))
}

i = 0
while ( i < 100){
  i = i+1
  print(i^2)
}

