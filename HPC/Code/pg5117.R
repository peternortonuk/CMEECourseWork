#!/usr/bin/env Rscript
#HPC Week

#Biological Computing Boot Camp
#R Studio Version 1.1.383 ubuntu 16.04 LTS 64bi
#Author Petra Guy November 2017

rm(list = ls())
graphics.off()

# I wanted a test community to try the functions out on, not part of coursework
generate_community = function(n,seed) {
  set.seed(seed)
  comm = sample(x = c(1:10),
                size = n,
                replace = TRUE)
  return(comm)
}

#Q1 get species richness
species_richness = function(x) {
  r = length(unique(x))
  return(r)
}

#Q2 Get a maximally diverse community
initialise_max = function(x) {
  comm = seq(1:x)
  return(comm)
}

#Q3 get a minimally diverse community - everything is the same
initialise_min = function(x) {
  comm = rep(1, x)
  return(comm)
}


#Q4 Need for neutral_step functions, just select two numbers from within the length of
#input vector which can then be used as indices for speciation or death replacement
choose_two = function(x) {
  two = sample(x, 2)
  return(two)
}

#Q5 Uses choose two and then replaces species at index 1 with that at index 2
#Simulates a species dieing and being repalced by another within community
neutral_step = function(x) {
  index = choose_two(length(x))
  x[index[1]] = x[index[2]]
  return(x)
}

#Q6 Su=imulates n steps of neutral step
neutral_generation = function(x) {
  n = round(length(x) / 2)
  for (i in 1:n) {
    comm = neutral_step(x)
  }
  return(comm)
}


#Q7 Runs several generations and returns species richness a each step
neutral_time_series = function(x, t) {
  rich = c(species_richness(x))
  for (i in 1:t) {
    x = neutral_generation(x)
    rich = c(rich, species_richness(x))
    
  }
  return(rich)
}

#Q8 Uses neutral time series over 200 steps on a maximally diverse community and plots the richness
question_8 = function() {
  rich = neutral_time_series(initialise_max(100), 200)
  plot(rich,
       main = "Species richness starting with maximal diversity of 100 individuals",
       ylab = "species richness",
       sub = "Species richness will tend to 1 as all individuals eventually become the same")
}

#Q9 creates a neutral step with either a speciation or a replacement, depending on value of v
neutral_step_speciation = function(x, v) {
  p = runif(1)
  if (v < p) {
    index = choose_two(length(x))
    x[index[1]] = x[index[2]]
  }
  else {
    newspecies =  max(x) + 1
    index = sample((length(x)), size = 1, replace = TRUE)
    x[index] = newspecies
  }
  return(x)
}

#Q10 Takes a community and outputs new community after a few generations with speciation or replacement
neutral_generation_speciation = function(x, v) {
  n =  round(length(x) / 2)
  for (i in 1:n) {
    x = neutral_step_speciation(x, v)
  }
  return(x)
}

#Q11 Returns community richness at each generation
neutral_time_series_speciation = function(x, v, t) {
  rich = vector()
  for (i in 1:t) {
    x = neutral_generation_speciation(x, v)
    rich[i] = species_richness(x)
  }
  return(rich)
}

#Q12 Output graph for species richness over 200 generations for maximally and minimally diverse communites
question_12 = function() {
  t = 200
  v = 0.1
  comm_max = initialise_max(100)
  comm_min = initialise_min(100)
  rich_max = neutral_time_series_speciation(comm_max, v, t)
  rich_min = neutral_time_series_speciation(comm_min, v, t)
  
  x = (1:t)
  titles = c("Max", "Min")
  y =  cbind(rich_max, rich_min)
  colnames(y) = titles
  
  matplot (x, y, pch = 19, col = 1:2)
  legend(1,
         50,
         legend = colnames(y),
         col = 1:2,
         lty = 1:4)
}

#Q13 calcualte species abundance using table - which gives frequencies
species_abundance = function(x) {
  abundance = as.numeric(sort(table(x), decreasing = TRUE))
  return(abundance)
}
#Q14 Arrange the abundances into octets
octaves = function(x) {
  oct = tabulate(floor(log2(x)) + 1)
  return(oct)
}
#Q15 Need to add the octets produced by octaves() and average them, but each octet can be a different
#length, this function pads the shorter octet with zeros
sum_vect = function(x, y) {
  if (length(x) < length(y))    {
    short = x
    long = y
    newshort = c(x, rep(0, length(long) - length(short)))
    sum = newshort + long
  }   else if (length(x) > length(y)) {
    short = y
    long = x
    newshort = c(y, rep(0, length(long) - length(short)))
    sum = newshort + long
  }   else  {
    sum = x + y
  }
  return(sum)
}

#Q16, produce a barchart of octets after 200 generations burn-in, using another 2000 generations
#using v = 0.1, size = 100

question_16 = function() {
  #browser()
  octets = list()
  x = initialise_min(100)
  v = 0.1
  rich = vector()
  i = 1
  index = 1
  # burn in
  while (i < 2200) {
    if (i < 200) {
      x = neutral_generation_speciation(x, v)
      
    } else {
      # continue for 2000 cycles
      x = neutral_generation_speciation(x, v)
      if (i %% 20 == 0) {
        abundance = species_abundance(x)
        octets[[index]] = octaves(abundance)
        index = index + 1
      }
      
    }
    i = i + 1
  }
  
  #find the average of the octaves which are list elements of octets
  l = length(octets)
  sum = vector()
  for (a in 1:(l)) {
    sum = sum_vect(sum, octets[[a]])
    
    
  }

  ave = sum / l
  names = names = c("1-3", "4-7", "8-31", "32-63", "64-127", ">127")
  barplot(ave,
          names.arg = names,
          main = "Average abundances in octets",
          xlab = "abundances")
  print(ave)
}
get_series_average = function(richness_vector){
  avg = vector()
  avg = c(avg,richness_vector[1])
  for ( i in 1:(length(richness_vector)-1)){
    i = i + 1
    tmpvect = richness_vector[1:i]
    total = sum(tmpvect)
    avgerage = total/length(tmpvect)
    avg= c(avg, avgerage)
  }
  return(avg)
}
  
challenge_A = function() {
  t = 200
  v = 0.1
  #get two starting communities
  comm_max = initialise_max(100)
  comm_min = initialise_min(100)
  #get times series of richness for them both
  rich_max = neutral_time_series_speciation(comm_max, v, t)
  rich_min = neutral_time_series_speciation(comm_min, v, t)
  #get two sets of averages for the two richness vectors, then the for loop takes the average
  #as you increment along the richness vector
  avg_min = get_series_average(rich_min)
  avg_max = get_series_average(rich_max)
  
  #put averages in a dataframe
  x = (1:t)
  df = data.frame(max = avg_max, min = avg_min, time = x)
  #create confidence intervals from variance, only using values after the burn-in
  
  sd_max = sqrt(var(df$max[50:200]))
  sd_min = sqrt(var(df$min[50:200]))
  #for 97.2% CI we need 98.6th percentile = z of 2.2
  CI_upper_max = df$max + 2.2*sd_max
  CI_lower_max = df$max - 2.2*sd_max
  
  CI_upper_min = df$min + 2.2*sd_max
  CI_lower_min = df$min - 2.2*sd_max
  
  #plot the graphs
  titles = c("Max", "Min")
  y =  cbind(avg_max, avg_min)
  colnames(y) = titles
  matplot (x, y, pch = 16, col = 1:2,
           xlab = "generations", ylab = "average richness", main = "Average Species Richness")
  legend(1,
         50,
         legend = colnames(y),
         col = 1:2,
         lty = 1:4)
  
  #add the CIs
  lines(CI_upper_max)
  lines(CI_lower_max)
  lines(CI_upper_min, col = "red")
  lines(CI_lower_min, col = "red")
  
}

challenge_B = function(){
  #browser()
  v = 0.1
  t = 200
  size = 100
  richness_matrix = matrix(nrow = 200)
  for (i in 1:10){
    seed = i
    community = generate_community(size,seed)
    richness = neutral_time_series_speciation(community,v,t)
    average_richness = get_series_average(richness)
    richness_matrix = cbind(richness_matrix,average_richness)
  }
  
  # plot the series
  x = (1:t)
  matplot (x, richness_matrix, pch = 16,
           xlab = "generations", ylab = "average richness", main = "Average Species Richness")
}
