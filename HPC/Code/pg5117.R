#!/usr/bin/env Rscript
#HPC Week

#Biological Computing Boot Camp
#R Studio Version 1.1.383 ubuntu 16.04 LTS 64bi
#Author Petra Guy November 2017

rm(list = ls())
graphics.off()

generate_community = function(n){
  sample(x = c(1:10), size = n, replace = TRUE)
}

species_richness = function(x){
  r = length(unique(x))
  return(r)
}

initialise_max = function(x){
  seq(1:x)
}

initialise_min = function(x){
  rep(1,x)
}

choose_two = function(x){
  sample(x,2)
}

neutral_step = function(x){
  index = choose_two(length(x))
  x[index[1]] = x[index[2]]
  print(x)
}


neutral_generation = function(x){
  n = round(length(x)/2)
  for (i in 1:n){
    comm = neutral_step(x)
  }
  print(comm)
}



neutral_time_series = function(x,t){
  rich = c(species_richness(x))
    for (i in 1:t){
    x = neutral_generation(x)
    rich = c(rich, species_richness(x))
    
  }
 print(rich)
}  
  
question_8 = function(){
  rich = neutral_time_series(initialise_max(100), 200)
  plot(rich, main = "Species richness starting with maximal diversity of 100 individuals", 
       ylab = "species richness", sub = "Species richness will tend to 1 as all individuals eventually become the same")
}

# used by neutral generation speciation to create the new community with either death or offspring
neutral_step_speciation = function(x,v){
  p = runif(1)
  if (v<p) {
  index = choose_two(length(x))
  x[index[1]] = x[index[2]]
  }
  else {
  newspecies =  max(x) + 1
  index = sample((length(x)), size = 1, replace = TRUE)
  x[index] = newspecies
  }
  return(x)}

#takes a community and outputs new community after a few generations with speciation
neutral_generation_speciation = function(x,v){
  n =  round(length(x)/2)
  for (i in 1:n){
       x = neutral_step_speciation(x,v)
    } 
  return(x)}

#takes community and outputs new community richness, so has t richnesses after t(n) time steps with speciation
neutral_time_series_speciation = function(x,v,t){
 #browser()
   rich = vector()
    for (i in 1:t){
      x = neutral_generation_speciation(x,v)
      rich[i] = species_richness(x)
      }
    return(rich)
  }  

question_12 = function(){
  t = 200
  v = 0.1
  comm_max = initialise_max(100)
  comm_min = initialise_min(100)
  rich_max = neutral_time_series_speciation(comm_max,v,t)
  rich_min = neutral_time_series_speciation(comm_min,v,t)
 
  x = (1:t)
  titles = c("Max","Min")
  y =  cbind(rich_max,rich_min)
  colnames(y) = titles

  matplot (x, y, pch = 19, col = 1:2)
  legend(1,50,legend = colnames(y),col = 1:2, lty = 1:4)
}

species_abundance = function(x){
  abundance = as.numeric(sort(table(x), decreasing = TRUE))
  return(abundance)
}

octaves = function(x){
  oct= tabulate(floor(log2(x))+1)
  return(oct)
}

sum_vect = function(x,y) {
     if (length(x) < length(y))    {
      short = x
      long =y 
      newshort = c(x, rep(0, length(long)-length(short)))
      sum = newshort + long 
 }   else if (length(x) > length(y)) {
      short = y
      long = x
      newshort = c(y, rep(0, length(long)-length(short)))
      sum = newshort + long 
 }   else  {
    sum = x + y
    }
    return(sum)
  }


question_16 = function(){
  octets = list()
  x = initialise_min(100)
  v = 0.1
  i = 1
  t = 100
  # burn in
  while (i < 20){
    x = neutral_generation_speciation(x,v)
    i = i + 1
  }
  # start of modelling
  for ( j in 1:t){
    #browser()
    #catch richness 20 cycles, rih has 20 elements
    for (k in 1:20) {
        x = neutral_generation_speciation(x,v)
        }
    abundance = species_abundance(x)
    octets[[j]] = octaves(abundance)
  }
  #find the average of the octaves which are list elements of octets
  sum = vector()
  for (l in 1:(t-1)){
    oct_1 = octets[[l]]
    oct_2 = octets[[l+1]]
    tmp = sum_vect(oct_1, oct_2)
    sum =  sum_vect(sum,tmp)
    
  }
  ave = sum/t
  names = names = c("1-3","4-7","8-31","32-63","64-127",">127")
  barplot(ave,names.arg = names, main = "Frequency of abundances in octets", xlab = "abundances")
  return(ave)   
}
 
  



