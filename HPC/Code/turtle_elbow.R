
plot(NA, xlim=c(0,5), ylim=c(0,5), xlab="X", ylab="Y")

turtle = function(start, distance, direction){
  x1 = start[1]
  y1 = start[2]
  x2 = x1 + distance*cos(direction)
  y2 = y1 + distance*sin(direction)
  segments(x1,y1,x2,y2)
  coords = c(x2,y2)
  return(coords)
}


elbow = function(start, distance, direction){
    #browser()
  coords = turtle(start, distance, direction)
  direction = -1* (pi - direction - pi/4)
  distance = 0.95*distance
  coords = turtle(coords, distance, direction)
  
}

spiral = function(start, distance, direction){
  coords = turtle(start, distance, direction)
  direction = -1* (pi - direction - pi/4)
  distance = 0.95*distance
  #coords = turtle(coords, distance, direction)
  if (distance > 0.1)
  spiral(coords,distance,direction)
  
}
graphics.off()
plot(NA, xlim=c(0,1), ylim=c(0,1), xlab="X", ylab="Y")

spiral_2 = function(start, distance, direction){
  coords = turtle(start, distance, direction)
  
  if (distance > 0.1){
    #direction = -1* (pi - direction - pi/4)
    distance = 0.95*distance
    spiral(coords,distance = 0.95*distance, direction = (-1* (pi - direction - pi/4)))
  
}
}
graphics.off()

plot(NA, xlim=c(0,50), ylim=c(0,50), xlab="X", ylab="Y")

tree = function(start, distance, direction) {
  coords = turtle(start, distance, direction)
  #coords = turtle(start, distance, direction)
    if (distance > 0.1){
    distance = 0.65*distance
    tree(coords, distance= 0.65*distance, direction = (pi/4) ) 
    tree(coords, distance= 0.65*distance, direction = (3*pi/4) ) 
    }
}

graphics.off()

plot(NA, xlim=c(0,2), ylim=c(0,10), xlab="X", ylab="Y")

fern = function(start, distance, direction) {
  coords = turtle(start, distance, direction)
  distance1 = distance
  distance2 = distance
  #coords = turtle(start, distance, direction)
  if (distance > 0.01){
    distance = 0.9*distance
    fern(coords, distance = 0.38*distance1, direction = 3*pi/4 ) 
    fern(coords, distance= 0.87*distance2, direction = (pi/2) ) 
  }
}

fern2 = function(start, distance, direction) {
  coords = turtle(start, distance, direction)
  distance1 = distance
  distance2 = distance
  #coords = turtle(start, distance, direction)
  if (distance > 0.01){
    distance = 0.9*distance
    fern(coords, distance = 0.38*distance1, direction = 3*pi/4 ) 
    fern(coords, distance= 0.75*distance2, direction = (pi/2) ) 
  }
}
