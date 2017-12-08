#!/usr/bin/env Rscript
#HPC Week

#Biological Computing Boot Camp
#R Studio Version 1.1.383 ubuntu 16.04 LTS 64bi
#Author Petra Guy November 2017

rm(list = ls())
graphics.off()

## generate a random community of size n, varies due to input of seed
generate_community = function(n,seed) {
  set.seed(seed)
  comm = sample(x = c(1:10),
                size = n,
                replace = TRUE)
  return(comm)
}

############# QUESTION 1#########################
#Q1 get species richness
species_richness = function(x) {
  r = length(unique(x))
  return(r)
}
##################### QUESTION 2 ###############
#Q2 Get a maximally diverse community
initialise_max = function(x) {
  comm = seq(1:x)
  return(comm)
}
################### QUESTION 3 ##################
#Q3 get a minimally diverse community - everything is the same
initialise_min = function(x) {
  comm = rep(1, x)
  return(comm)
}

################# QUESTION 4 #################
#Q4 Need for neutral_step functions, just select two numbers from within the length of
#input vector which can then be used as indices for speciation or death replacement
choose_two = function(x) {
  two = sample(x, 2)
  return(two)
}
############### QUESTION 5 ######################
#Q5 Uses choose two and then replaces species at index 1 with that at index 2
#Simulates a species dieing and being repalced by another within community
neutral_step = function(x) {
  index = choose_two(length(x))
  x[index[1]] = x[index[2]]
  return(x)
}
############## QUESTION 6 ###################
#Q6 Simulates n steps of neutral step
neutral_generation = function(x) {
  n = round(length(x) / 2)
  for (i in 1:n) {
    comm = neutral_step(x)
  }
  return(comm)
}

################### QUESTION 7 ################
#Q7 Runs several generations and returns species richness a each step
neutral_time_series = function(x, t) {
  rich = c(species_richness(x))
  for (i in 1:t) {
    x = neutral_generation(x)
    rich = c(rich, species_richness(x))
    
  }
  return(rich)
}
############## QUESTION 8 #######################
#Q8 Uses neutral time series over 200 steps on a maximally diverse community and plots the richness
question_8 = function() {
  rich = neutral_time_series(initialise_max(100), 200)
  plot(rich,
       main = "Species richness starting with maximal diversity of 100 individuals",
       ylab = "species richness",
       sub = "Species richness will tend to 1 as all individuals eventually become the same")
}
############ QUESTION 9########################
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
############### QUESTION 10 #############################
#Q10 Takes a community and outputs new community after a few generations with speciation or replacement
neutral_generation_speciation = function(x, v) {
  n =  round(length(x) / 2)
  for (i in 1:n) {
    x = neutral_step_speciation(x, v)
  }
  return(x)
}
################ QUESTION 11 #########################
#Q11 Returns community richness at each generation
neutral_time_series_speciation = function(x, v, t) {
  rich = vector()
  for (i in 1:t) {
    x = neutral_generation_speciation(x, v)
    rich[i] = species_richness(x)
  }
  return(rich)
}
################ QUESTION 12 ########################
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
################ QUESTION 13 ########################
#Q13 calcualte species abundance using table - which gives frequencies
species_abundance = function(x) {
  abundance = as.numeric(sort(table(x), decreasing = TRUE))
  return(abundance)
}

############ QUESTION 14 #######################
#Q14 Arrange the abundances into octets
octaves = function(x) {
  oct = tabulate(floor(log2(x)) + 1)
  return(oct)
}

########### QUESTION 15 ########################
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

####################### QUESTION 16 ###########################
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

######################  Challenge A #######################################

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

################ CHALLENGE B #############################

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
################# QUESTION 17 AND 18 ####################################
# THIS IS THE FULL PROGRAMME AS IT WAS LOADED ONTO THE HPC - SO SOME OF THESE FUNCTIONS ARE REPEATS

iter = as.numeric(Sys.getenv(("PBS_ARRAY_INDEX")))



initialise_min = function(x) {
  comm = rep(1, x)
  return(comm)
}

choose_two = function(x) {
  two = sample(x, 2)
  return(two)
}


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

species_richness = function(x) {
  r = length(unique(x))
  return(r)
}

neutral_generation_speciation = function(x, v) {
  n =  round(length(x) / 2)
  for (i in 1:n) {
    x = neutral_step_speciation(x, v)
  }
  return(x)
}


species_abundance = function(x) {
  abundance = as.numeric(sort(table(x), decreasing = TRUE))
  return(abundance)
}

octaves = function(x) {
  oct = tabulate(floor(log2(x)) + 1)
  return(oct)
}

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




cluster_run = function(speciation_rate,
                       size,
                       wall_time,
                       interval_rich,
                       interval_oct,
                       burn_in_generation,
                       output_file_name) {
  # Organise times
  wall_time = wall_time*60
  start = as.numeric(proc.time()[3])
  
  # initialise community
  comm = initialise_min(size)
  rich = vector()
  n = 1
  index = 1
  octets = list()
  
  while (as.numeric(proc.time()[3]) - start < wall_time) {
    # update community
    comm = neutral_generation_speciation(comm, speciation_rate)
    # burn-in phase
    if (n < burn_in_generation) {
      # sample
      if (n %% interval_rich == 0) {
        # calculate richness and append
        rich = c(rich, species_richness(comm))
      }
    }
    # after burn-in
    else {
      abundance = species_abundance(comm)
      # sample
      if (n %% interval_oct == 0) {
        octets[[index]] = octaves(abundance)
        index = index + 1
      }
    }
    n = n + 1
    
  }
  run_time = (as.numeric(proc.time()[3]) - start)/60
  
  #find the average of the octaves which are list elements of octets
  len = length(octets)
  sum = vector()
  for (a in 1:len) {
    sum = sum_vect(sum, octets[[a]])
  }
  state = sum / len
  
  save(
    speciation_rate,
    size,
    interval_rich,
    interval_oct,
    burn_in_generation,
    run_time,
    rich,
    octets,
    state,
    file = output_file_name
  )
  
}



set.seed(iter)
outfile = paste("pg5117_cluster_", iter, ".rda", sep = "")

if (iter < 25) {
  cluster_run(
    speciation_rate = 0.002125,
    size = 500,
    wall_time = 690,
    interval_rich = 1,
    interval_oct = 50,
    burn_in_generation = 4500,
    output_file_name = outfile
  )
}

if ((26 < iter)  &&  (iter < 50)) {
  cluster_run(
    speciation_rate = 0.002125,
    size = 1000,
    wall_time = 690,
    interval_rich = 1,
    interval_oct = 100,
    burn_in_generation = 8000,
    output_file_name = outfile
  )
}

if ((51 < iter) && (iter < 75)) {
  cluster_run(
    speciation_rate = 0.002125,
    size = 2500,
    wall_time = 690,
    interval_rich = 1,
    interval_oct = 250,
    burn_in_generation = 20000,
    output_file_name = outfile
  )
}
if ((76 < iter) && (iter < 101)) {
  cluster_run(
    speciation_rate = 0.002125,
    size = 5000,
    wall_time = 690,
    interval_rich = 1,
    interval_oct = 500,
    burn_in_generation = 40000,
    output_file_name = outfile
  )
}
################ QUESTION 19 #######################################
#BASH SCRIPT, 
#R CODE
#OUTPUT FILES
# ALL IN ZIP

# SEE /RESULTS/Cluster_1207 for zip and /RESULTS/Cluster_1207/pg5117 for files


############# Question 20 ##########################################
# Read in the files from the HPC
#couldnt work out easy wy of specifying files in each batch, so this first function
get_quartile = function(i) {
  if (i == 1) {
    quartile = c(1:24)
  }
  else if (i == 2) {
    quartile = c(27:49)
  }
  else if (i == 3) {
    quartile = c(52:74)
  }
  else {
    quartile = c(77:100)
  }
  return(quartile)
}

# This function returns the sum and number of the octets in single file, to be found in path specified
get_sum_and_length_of_octet = function(i) {
  #browser()
  infile = paste("../Results/Cluster_1207/pg5117/pg5117_cluster_", i, ".rda", sep = "")
  load(infile)
  len = length(octets)
  sum = vector()
  sum_and_length = list()
  for (a in 1:len) {
    sum = sum_vect(sum, octets[[a]])
  }
  sum_and_length[[1]] = sum
  sum_and_length[[2]] = len
  return(sum_and_length)
  
}


get_results = function() {
  #browser()
  ave_for_file_batch = list()
  for (i in 1:4) {
    j = get_quartile(i)    # this return vector of file numbers in each batch, eg if i = 2, 26:50
    cum_sum = vector()
    cum_len = 0
    results = list()
    for (counts in j) {
      results =  get_sum_and_length_of_octet(counts)
      cum_sum = sum_vect(cum_sum, results[[1]])
      cum_len =  results[[2]] + cum_len
    }
    ave_for_file_batch[[i]] = cum_sum / cum_len
    
  }
  return(ave_for_file_batch)
}

plot_results = function(results) {
  par(mfrow = c(2, 2))
  ave1 = results[[1]]
  names = names = c("1", "2", "3", "4", "5", "6","7","8","9")
  plot1 = barplot(ave1,
                  names.arg = names,
                  main = "Average abundances in octets",
                  xlab = "abundances")
  ave2 = results[[2]]
  names = names = c("1", "2", "3", "4", "5", "6","7","8","9","10")
  plot2 = barplot(ave2,
                  names.arg = names,
                  main = "Average abundances in octets",
                  xlab = "abundances")
  ave3 = results[[3]]
  names = names = c("1", "2", "3", "4", "5", "6","7","8","9","10","11","12")
  plot3 = barplot(ave3,
                  names.arg = names,
                  main = "Average abundances in octets",
                  xlab = "abundances")
  ave4 = results[[4]]
  names = names = c("1", "2", "3", "4", "5", "6","7","8","9","10","11","12")
  barplot(ave4,
          names.arg = names,
          main = "Average abundances in octets",
          xlab = "abundances")
}

######################## CHALLENGE D #################


Challengne_D = function() {
  sizes  = c(500, 1000, 2500, 5000)
  v = 0.002125
  
  Abundances = list()
  
  for (i in 1:4) {
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
  }
}

##################### FRACTALS SECTION ###############################


