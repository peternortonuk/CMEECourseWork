# Practical Chapter 9

# trying loops again, plus output, just put entiire summary in a csv which avoids all the tricky subsetting
#come back to that later

library(ggplot2)


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
#Model = lm(Mydfs_FeedGroups[[i]]$Predator.mass ~ Mydfs_FeedGroups[[i]]$Prey.mass, subset = (Mydfs_FeedGroups[[i]]$Predator.lifestage==St[j]))
get_model = function(x,y){
  datafr = Mydfs_FeedGroups[[x]]
  mod = lm(log(datafr$Predator.mass) ~ log(datafr$Prey.mass), subset = (datafr$Predator.lifestage == keyPredLifeStage[y]))
  return(mod)
}
##test snippet
#dafr = Mydfs_FeedGroups[[2]]
#testmod = lm(log(dafr$Predator.mass) ~ log(dafr$Prey.mass), subset = (dafr$Predator.lifestage == keyPredLifeStage[2]))
##
keyFeedGroups = as.character(unique(Mydf$Type.of.feeding.interaction))
keyPredLifeStage = as.character(unique(Mydf$Predator.lifestage))
numsFeedgroups = as.numeric(unique(Mydf$Type.of.feeding.interaction))
numsPredLifestage = as.numeric(unique(Mydf$Pedator.lifestage))
key_to_Feedlevels = rbind(keyFeedGroups, numsFeedgroups) #so i know what i is!
key_to_Lifestage = rbind(keyPredLifeStage, numsPredLifestage)


Mydfs_FeedGroups =  vector(mode = "list")
for (i in 1:length(keyFeedGroups)){
  Mydfs_FeedGroups[[i]]= subset(Mydf, Mydf$Type.of.feeding.interaction == keyFeedGroups[i])
}

get_LifeStages = function(dataframe){
  LifeStages = as.character(unique(dataframe$Predator.lifestage))
}
get_numberLifeStages = function(dataframe){
  No_Stages = sum(count(unique(dataframe$Predator.lifestage))$freq)
}

convertoutput <-function(x){
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



for (i in 1:length(Mydfs_FeedGroups)){
  browser()
  n = get_numberLifeStages(Mydfs_FeedGroups[[i]])
  St = get_LifeStages(Mydfs_FeedGroups[[i]])
  for (j in 1:n){
    model = get_model(i,j)
    results = convertoutput(model)
    Heading1 = c("Type of Feeding interaction", keyFeedGroups[i])
    Heading2 = c("Predator Life Stage ", keyPredLifeStage[j])
    write.csv(c(Heading1, Heading2),"../Results/PP_Regress.csv", append = TRUE)
    write.csv(results,"../Results/PP_Regress.csv", append = TRUE )
    }}
  

#Above is kind of working - but the indexes are out, so that "get_model" is running on i=2, j=3, 
#for which there arent any variables.
