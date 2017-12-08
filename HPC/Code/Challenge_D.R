

#Using coalescence, ChallengeD
rm(list = ls())
sizes  = c(500, 1000, 2500, 5000)
v = 0.002125

initialise_min = function(x) {
  comm = rep(1, x)
  return(comm)
}
octaves = function(x) {
  oct = tabulate(floor(log2(x)) + 1)
  return(oct)
}
 
  Abundances = list()
  
  
  for (i in 1:4) {
    #browser()
    octets = list()
    size = sizes[i]
    theta = 0.002125 * (size - 1) / (1 - v)
    abundance = vector()
    lineages = initialise_min(size)
    N = length(lineages)
    
    while (N > 1) {
      p = theta / (theta + N - 1)
      r = runif(1, 0:1)
      index = sample(N, 2)
      
      if (r < p) {
        abundance = c(abundance, lineages[index[1]])
      }
      else {
        lineages[index[1]] = lineages[index[1]] + lineages[index[2]]
        lineages = lineages[-index[2]]
      }
      N = length(lineages)
    }
    
    abundance = c(abundance, lineages)
    Abundances[[i]] = abundance
    octets[[i]] = octaves(abundance)
    print(length(octets[[i]]))
  }
  
  octets = list()
  for (i in 1:4){
    octets[[i]]= octaves(Abundances[[i]])
    
  }
  par(mfrow = c(2, 2))
  y1 = octets[[1]]
  #names = names = c("1", "2", "3", "4", "5", "6","7","8","9")
  plot1 = barplot(y1,
                  #names.arg = names,
                  main = "Average abundances in octets",
                  xlab = "abundances")
  y2 = octets[[2]]
  #names = names = c("1", "2", "3", "4", "5", "6","7","8","9","10")
  plot2 = barplot(y2,
                  #names.arg = names,
                  main = "Average abundances in octets",
                  xlab = "abundances")
  y3 = octets[[3]]
  #names = names = c("1", "2", "3", "4", "5", "6","7","8","9","10","11","12")
  plot3 = barplot(y3,
                  #names.arg = names,
                  main = "Average abundances in octets",
                  xlab = "abundances")
  y4 = octets[[4]]
  #names = names = c("1", "2", "3", "4", "5", "6","7","8","9","10","11","12","13","14","15")
  barplot(y4,
          #names.arg = names,
          main = "Average abundances in octets",
          xlab = "abundances")

  