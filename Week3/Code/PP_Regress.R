# Practical Chapter 9
library(ggplot2)
library(dplyr)
library(magrittr)
library(tidyr)

rm(list = ls())

Mydf = as.data.frame(read.csv("../Data/EcolArchives-E089-51-D1.csv"))


plot = ggplot(Mydf, aes(x = log(Prey.mass), y = log(Predator.mass) ) )+
     geom_point(aes(col = Predator.lifestage), shape = 3)+
    stat_smooth(method = "lm", aes(col = Predator.lifestage), fullrange = TRUE) +
    facet_grid(Type.of.feeding.interaction ~ .)



#models = Mydf %>%  filter(Type.of.feeding.interaction == "insectivorous") %>%  group_by(Predator.lifestage) %>%  do(lm(log(Predator.mass) ~ log(Prey.mass)))

Mydf = cbind(Mydf$Predator.lifestage, Mydf$Type.of.feeding.interaction, Mydf$Predator.mass, Mydf$Prey.mass)
colnames(Mydf) = c("Predator.lifestage", "Type.of.feeding.interaction", "Predator.mass", "Prey.mass")
means = Mydf %>% group_by(Type.of.feeding.interaction) %>% group_by(Predator.lifestage, add = TRUE) %>%   summarize(m = mean(Predator.mass)) #%>%  assign("bar", .)
Models = Mydf %>% group_by(Type.of.feeding.interaction) %>% group_by(Predator.lifestage, add = TRUE) %>%  do(fits = lm(log(Predator.mass) ~ log(Prey.mass), data = . ))