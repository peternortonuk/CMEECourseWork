#7.12 Practising readin 
# inputs trees.csv
# outputs MyData.csv, Mydatacsv.csv, Mydatatable.csv

MyData = read.csv("../Data/trees.csv")
MyDataHeader = read.csv("../Data/trees.csv", header = TRUE)
MyDataTable = read.table("../Data/trees.csv", sep = ",")
MydataSkip = read.csv("../Data/trees.csv", skip = 5)
write.csv(MyData,"../Results/Mydata.csv")
write.table(MyData[1,], file = "../Results/MyData.csv", append = TRUE)
write.csv(MyData, "../Results/MyDatacsv.csv", row.names = TRUE)
write.table(MyData, "../Results/MyDataTable.csv", col.names = FALSE)
