
library(ggmap)
library(ggplot2)
woods = read.csv("../Data/LonLat.csv")
colnames(woods) = c("Easting","Northing","GridRef","Lat","Long")
lat_range =c(50,59)
lon_range = c(-7,2)

####### This ggplot thing works

UK <- map_data("world2Hires", region = "UK")
ggplot() + geom_polygon(data = UK, aes(x = long, y = lat, group = group)) +
  coord_map()+
  geom_point(data=woods, aes(x=Long, y=Lat), color="red")
##########

####None of these work
UKmap = (get_map(location = c(lon = 3.4360, lat = 55.3781)))

ggmap(UKmap)+
  geom_point(data = woods, aes(x = Long, y = Lat), maprange = FALSE, color = 'red', size = 3)

##############################

island = get_map(location = c(lon = 53.0, lat = 0.0), zoom = 13, maptype = "satellite")


RL <- read.table(text = "
1 51.962306	-5.0813662
2 55.114221	-4.2043145
3 51.86258	-4.6329521
4 52.048153	-3.9729594
5 52.973092	-2.7326078 , header = F)

RL <- setNames(RL, c("ID", "Latitude", "Longitude"))


ggmap(island, extent = "panel", legend = "bottomright") +
  geom_point(aes(x = Longitude, y = Latitude), data = RL, size = 4, color = "#ff0000") +
  scale_x_continuous(limits = c(-7.0, 1.0), expand = c(0, 0)) +
  scale_y_continuous(limits = c(50.0, 59.0), expand = c(0, 0))


#######################

island = get_map(location = c(lon = 55, lat = 0), zoom = 5, maptype = "satellite")

data = data.frame(cbind(woods$Lat, woods$Long))
colnames(data) = c("Lat","Long")

ggmap(island, extent = "panel", legend = "bottomright") +
  scale_x_continuous(limits = c(-7,1),expand = c(0, 0)) +
  scale_y_continuous(limits = c(50,59), expand = c(0, 0))+
  geom_point(aes(x = Long, y = Lat), data = data, size = 4, color = "#ff0000") 

########################################
+
