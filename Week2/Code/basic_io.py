#Practise opening and writing to files

#Open a file for input

f = open("../Sandbox/test.txt", "r")
# using an implicit for loop

for line in f:
	print line,
f.close()

#####################
#skip lines in a file

f = open('../Sandbox/test.txt', 'r')
for line in f:
		if len(line.strip()) > 0:
			print line,
					
f.close()

###############

# save something to file

list_to_save = range(100)

f = open('../Sandbox/testout.txt', 'w')
for i in list_to_save:
	f.write(str(i) +'\n')
	
f.close()

################

#saving a more complicated object to a file

my_dictionary = {"a key" :10, "another key": 11}

import pickle

f = open('../Sandbox/test.p', 'wb')
pickle.dump(my_dictionary, f)
f.close()

##############

#load a complicated object

f = open('../Sandbox/test.p', 'rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)

