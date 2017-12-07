
t = 200
v = 0.1
#get two starting communities
comm_max = initialise_max(100)
comm_min = initialise_min(100)
#get times series of richness for them both
rich_max = neutral_time_series_speciation(comm_max, v, t)
rich_min = neutral_time_series_speciation(comm_min, v, t)
#get two sets of averages for the two richness vectors
avg_min = vector()
avg_min = c(avg_min,rich_min[1])
for ( i in 1:(length(rich_min)-1)){
  i = i + 1
  tmpvect = rich_min[1:i]
  total = sum(tmpvect)
  avg = total/length(tmpvect)
  avg_min= c(avg_min, avg)
}
avg_max = vector()
avg_max = c(avg_max, rich_max[1])
for ( i in 1:(length(rich_max)-1)){
  i = i + 1
  tmpvect = rich_max[1:i]
  total = sum(tmpvect)
  avg = total/length(tmpvect)
  avg_max= c(avg_max, avg)
}
                
#put averages in a dataframe
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
x = (1:t)
titles = c("Max", "Min")
y =  cbind(avg_max, avg_min)
colnames(y) = titles

matplot (x, y, pch = 20, col = 1:2)
legend(1,
       50,
       legend = colnames(y),
       col = 1:2,
       lty = 1:4)
lines(CI_upper_max)
lines(CI_lower_max)
lines(CI_upper_min, col = "red")
lines(CI_lower_min, col = "red")


                      