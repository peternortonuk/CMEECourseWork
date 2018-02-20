
library(ggmap)
library(ggplot2)
library(dplyr)
rm(list = ls())
cat("\014")

woods = read.csv("../Data/LonLat.csv")
colnames(woods) = c("Easting","Northing","GridRef","Lat","Long")
# just the lon lat columns
data = cbind(woods$Lat, woods$Long)
#might need for extent?
lat_range =c(50,59)
lon_range = c(-7,2)

####### This ggplot thing works###

UK <- map_data("world2Hires", region = "UK")
ggplot() + geom_polygon(data = UK, aes(x = long, y = lat, group = group)) +
  coord_map()+
  geom_point(data=woods, aes(x=Long, y=Lat), color="red")


######ggmap version, could then scale these by diversity ####

map<- get_map(location = c(lon = -1.5, lat = 54),
                         color = "color",
                         source = "google",
                         maptype = "satellite",
                         zoom = 6) 
  
ggmap(map, extent ='device')+
    geom_point(aes(x = Long, y = Lat),data = data, color="red", size=2, alpha=1)

##################################

#select nearby woods

nearby_woods = woods%>%filter(Long> -1.3 & Lat < 51.5  )
nearby_woods

map<- get_map(location = c(lon = 0, lat = 51.25),
              color = "color",
              source = "google",
              maptype = "satellite",
              zoom = 9) 

ggmap(map, extent ='device')+
  geom_point(aes(x = Long, y = Lat),data = nearby_woods, color="red", size=2, alpha=1)
###############################


