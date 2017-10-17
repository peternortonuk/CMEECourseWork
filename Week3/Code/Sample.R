# Exercise 9.3.1 Random numbers

x = rnorm(50)


doit = function(x) {
  x = sample(x, replace = TRUE)
  if(length(unique(x)) > 30) {
     print(paste("Mean of this sample was:", as.character(mean(x))))
  }
}

#result = lapply(1:100, function(i) doit(x)) eh?

result = lapply(1:100, doit)

result = vector("list", 100)
for (i in 1:100) {
  result[[i]] <-doit(x)
}