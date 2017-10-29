#InputFileName = "test.csv"
#output trees_gettree height, ish
args <- commandArgs(TRUE)
InputFileName <- as.character(args[1])

#paste the input filename onto the relative path
pathname = paste("../Data",InputFileName, sep = "/")
MyData = read.csv(pathname)

#This is the heights calcultion
TreeHeight = function(distance, angle) {
  radians =  angle*pi/180
  height = distance * tan(radians)
  print(height)
}


#strip ,csv off input file and create output fileneme
tmp = strsplit(InputFileName, "\\.")[[1]]
tmpout = paste(tmp[[1]],"treeheights", sep = "_")
tmpout2 = paste(tmpout,".csv")
outfile = paste("../Results",tmpout2, sep = "/")



Tree.Heights.m = mapply(TreeHeight, MyData[2], MyData[3])
tempdata = cbind(MyData,Tree.Heights.m)
write.csv(tempdata, outfile)