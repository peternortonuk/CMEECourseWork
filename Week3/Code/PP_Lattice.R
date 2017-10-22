#Chapter 9, 9.1.2


rm(list = ls())

Mydf = read.csv("../Data/EcolArchives-E089-51-D1.csv")

library(lattice)
# plot graphs and output to pdfs
pdf("../Results/Prey_Lattice.pdf", # Open blank pdf page
    11.7, 8.3)
densityplot(~log(Prey.mass)| Type.of.feeding.interaction, data = Mydf)
dev.off()

pdf("../Results/Predator_Lattice.pdf", # Open blank pdf page
    11.7, 8.3)
densityplot(~log(Predator.mass)| Type.of.feeding.interaction, data = Mydf)
dev.off()
pdf("../Results/SizeRatio_Lattice.pdf", # Open blank pdf page
    11.7, 8.3)

densityplot(~log(Prey.mass/Predator.mass)| Type.of.feeding.interaction, data = Mydf)
dev.off()

#tapplys to get means and medians across feeding interaction
groups = as.factor(Mydf$Type.of.feeding.interaction)

Prey.mass.means = tapply(log(Mydf$Prey.mass), groups, mean)

Predator.mass.means = tapply(log(Mydf$Predator.mass), groups, mean)

PreyPred.mass.means = tapply(log(Mydf$Prey.mass/Mydf$Predator.mass), groups, mean)

Prey.mass.median = tapply(log(Mydf$Prey.mass), groups, median)

Predator.mass.median = tapply(log(Mydf$Prey.mass), groups, median)

PreyPred.mass.median = tapply(log(Mydf$Predator.mass/Mydf$Prey.mass), groups, mean)
  
stats = rbind(Prey.mass.means, Predator.mass.means, PreyPred.mass.means, Prey.mass.median, Predator.mass.median, PreyPred.mass.median)

write.csv(stats, "../Results/PP_Results.csv")




