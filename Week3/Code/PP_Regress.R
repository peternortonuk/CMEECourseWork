# Practical Chapter 9
#Using dplyr, but cant get dplyr to load anymore. hace removed and reinstalled Rcpp, changed file acces for Rcpp and reinstalled dplyr
#several times. 
# so cant check this script anymore.
library(dplyr) # need for filter
library(ggplot2)
library(plyr) # need for count
#library(magrittr)
#library(tidyr)
#library(sqldf)
rm(list = ls())

Mydf = as.data.frame(read.csv("../Data/EcolArchives-E089-51-D1.csv"))

pdf("../Results/PP_Regress.pdf",  11.7, 8.3)
plot = ggplot(Mydf, aes(x = log(Prey.mass), y = log(Predator.mass) ) )+
  geom_point(aes(col = Predator.lifestage), shape = 3)+
  stat_smooth(method = "lm", aes(col = Predator.lifestage), fullrange = TRUE) +
  facet_grid(Type.of.feeding.interaction ~ .)
print(plot)
dev.off()

# convert to g and log everything 
l = length(Mydf$Prey.mass)
for (i in 1:l){
  if (Mydf$Prey.mass.unit[i] == "mg") {
    Mydf$Prey.mass[i] = Mydf$Prey.mass[i] * 1e-3
  }
}


#models = Mydf %>%  filter(Type.of.feeding.interaction == "insectivorous") %>%  group_by(Predator.lifestage) %>%  do(lm(log(Predator.mass) ~ log(Prey.mass)))



#dplyr not loading - trouble with Rcpp, says need 2.17 - but can only install 2.13. they keep going to temp directory and cant unzip them. not sure its worth the bother
#redownlaoded again. dplyr working today
#means = Mydf %>% group_by(Type.of.feeding.interaction) %>% group_by(Predator.lifestage, add = TRUE) %>%   summarize(m = mean(Predator.mass)) #%>%  assign("bar", .)
#Modelspiped = Mydf %>% group_by(Type.of.feeding.interaction) %>% group_by(Predator.lifestage, add = TRUE) %>%  do(fits = lm(log(Predator.mass) ~ log(Prey.mass), data = . ))
# above pipe is fine - but need summary of data, and need to know what the model is fitting

#Start again using filters etc. Part of the issue is that I am trying to automate everything, as if I dont know what each grpup will throw out. To make
#program generic. Difficulty is that I then need to introduce separate functions to assess each subset created. For how many Lifestages for example.
#Wont continue with that for this exercise, but in future, I'd need to address that. Using key below to attach labesl to subsets etc.

convertoutput <-function(x){ # this makes output of summary look ok, otherwise nonsense when written to csv
  res<-c(paste(as.character(summary(x)$call),collapse=" "),
         x$coefficients[1],
         x$coefficients[2],
         length(x$model),
         summary(x)$coefficients[2,2],
         summary(x)$r.squared,
         summary(x)$adj.r.squared,
         summary(x)$fstatistic,
         pf(summary(x)$fstatistic[1],summary(x)$fstatistic[2],summary(x)$fstatistic[3],lower.tail=FALSE))
  names(res)<-c("call","intercept","slope","n","slope.SE","r.squared","Adj. r.squared",
                "F-statistic","numdf","dendf","p.value")
  return(res)} 


keyFeedGroups = as.character(unique(Mydf$Type.of.feeding.interaction))
keyPredLifeStage = as.character(unique(Mydf$Predator.lifestage))


insectivors = filter(Mydf, Type.of.feeding.interaction == "insectivorous")
pred_pisc = filter(Mydf, Type.of.feeding.interaction ==  "predacious/piscivorous")
piscivorous =  filter(Mydf, Type.of.feeding.interaction ==  "piscivorous")
planktivorous = filter(Mydf, Type.of.feeding.interaction ==  "planktivorous")
predacious = filter(Mydf, Type.of.feeding.interaction ==  "predacious")

##how many lifestages in each subset above and what are they

get_LifeStages = function(dataframe){
  LifeStages = as.character(unique(dataframe$Predator.lifestage))
}
get_numberLifeStages = function(dataframe){
  No_Stages = sum(count(unique(dataframe$Predator.lifestage))$freq)
}
### how many predator life stages in each feed interaction
insectivorstages = get_LifeStages(insectivors)
pred_piscstages = get_LifeStages(pred_pisc)
piscivorousstages =  get_LifeStages(piscivorous)
planktivorousstages = get_LifeStages(planktivorous)
predaciousstages = get_LifeStages(predacious)
# need to loop for the number of stages times, over the stages to get the required models.


n = length(piscivorousstages)
for (i in 1:n){
  #browser()
    model = lm(piscivorous$Predator.mass ~ piscivorous$Prey.mass, 
            subset = (piscivorous$Predator.lifestage == piscivorousstages[i]))
    title = c("predator life stage ", piscivorousstages[i], "piscivorous")
    output = convertoutput(model)
    fullout = rbind(title, output)
    write.table( fullout,  
                 file="../Results/PP_Regress.csv", 
                 append = T, 
                 sep=',', 
                 row.names=T, 
                 col.names=T )
  
}
#this gives an output, but its nasty to read. Spent 3 days on these. Need to move on fopr now. Going to try in python
print(insectivors)
n = length(insectivors)
for (i in 1:n){
  #browser()
  model = lm(insectivors$Predator.mass ~ insectivors$Prey.mass, 
             subset = (insectivors$Predator.lifestage == insectivorstages[i]))
  title = c("predator life stage ", insectivorstages[i], "insectivorous")
  output = convertoutput(model)
  fullout = rbind(title, output)
  write.table( fullout,  
               file="../Results/PP_Regress.csv", 
               append = T, 
               sep=',', 
               row.names=T, 
               col.names=T )
  
}

### next group### this should be a loop###

n = length(pred_piscstages)
for (i in 1:n){
  #browser()
  model = lm(pred_pisc$Predator.mass ~ pred_pisc$Prey.mass, 
             subset = (pred_pisc$Predator.lifestage == pred_piscstages[i]))
  title = c("predator life stage ", pred_piscstages[i], "pred_piscivorous")
  output = convertoutput(model)
  fullout = rbind(title, output)
  write.table( fullout,  
               file="../Results/PP_Regress.csv", 
               append = T, 
               sep=',', 
               row.names=T, 
               col.names=T )

}

n = length(predaciousstages)
for (i in 1:n){
  #browser()
  model = lm(predacious$Predator.mass ~ predacious$Prey.mass, 
             subset = (predacious$Predator.lifestage == predaciousstages[i]))
  title = c("predator life stage ", predaciousstages[i], "pred_piscivorous")
  output = convertoutput(model)
  fullout = rbind(title, output)
  write.table( fullout,  
               file="../Results/PP_Regress.csv", 
               append = T, 
               sep=',', 
               row.names=T, 
               col.names=T )
  
}

