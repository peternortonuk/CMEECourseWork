import csv

#read a csv file and append stuff to each row

f = open('../Data/testcsv.csv','rb')

csvread = csv.reader(f)
temp = []
for row in csvread:
		temp.append(tuple(row))
		print row
		print "The species row is", row[0]
f.close()

#write only th species to anotehr file

f = open('../Data/testcsv.csv', 'rb')
g = open('../Sandbox/bodymass.csv', 'wb')

csvread = csv.reader(f)
csvwrite = csv.writer(g)
for row in csvread:
		print row
		csvwrite.writerow([row[0], row[4]])
f.close()
g.close()

