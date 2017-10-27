
#Chapt * extra Credit Mapping

rm(list = ls())
MyData = read.csv("../Data/GPDD.csv")
library(ggplot2)
#library(maps)
library(ggmap)
#library(reshape2)


# getting the map
GPDDMap <- get_map(location = c(lon = mean(MyData$long), lat = mean(MyData$lat)), zoom = 3,
                      maptype = "satellite", scale = 1)

# plotting the map with some points on it
ggmap(GPDDMap) +
  geom_point(data = MyData, aes(x = long, y = lat, fill = "red", alpha = 0.8), size = 5, shape = 21) +
  guides(fill=FALSE, alpha=FALSE, size=FALSE)

# appear to only be northern hemisphere data. 