
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