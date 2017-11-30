#!/usr/bin/env Rscript
#HPC Week

#Biological Computing Boot Camp
#R Studio Version 1.1.383 ubuntu 16.04 LTS 64bi
#Author Petra Guy November 2017

#Cluster run uses speciation rate, wall time, interval rich, interval oct, burn in generations, output file names.
rm(list = ls())

initialise_min = function(x){
  comm = rep(1,x)
  return(comm)
}

choose_two = function(x){
  two = sample(x,2)
  return(two)
}


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

species_richness = function(x){
  r = length(unique(x))
  return(r)
}

neutral_generation_speciation = function(x,v){
  n =  round(length(x)/2)
  for (i in 1:n){
    x = neutral_step_speciation(x,v)
  } 
  return(x)}


cluster_run = function(speciation_rate = 0.002125,
                       size = 100,
                       wall_time = 10,
                       interval_rich = 10,
                       interval_oct = 0,
                       burn_in_generation = 21) {
  
  start = proc.time()[3]
  comm = initialise_min(size)
  rich = vector()
  n = 0
  
  while (proc.time()[3] - start < wall_time) {
    if (n < burn_in_generation) {
      comm = neutral_generation_speciation(comm, speciation_rate)
      
      if (n %% interval_rich == 0) {
        rich = c(rich, species_richness(comm))
      }
    }
    n = n + 1
    
  }
  return(rich)
}


