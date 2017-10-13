#!usr/bin/python

"""5.8 Practising input/output"""

__author__ = "Petra Guy, pg5117@ic.ac.uk"
__version__ = "2.7"

#imports

#import sys

#constants

#functions

#Practise opening and writing to files
########################################

#1 Open a file for input

f = open("../Sandbox/test.txt", "r")

# using an implicit for loop to print lines in the files

for line in f:
	print line,
f.close()

#######################################
#2 skip lines in a file

f = open('../Sandbox/test.txt', 'r')
for line in f:
		if len(line.strip()) > 0:
			print line,
					
f.close()

########################################

#3 save something to file

list_to_save = range(100)

f = open('../Sandbox/testout.txt', 'w')
for i in list_to_save:
	f.write(str(i) +'\n') # f.write only writes strings, not nums hence str(i)
	
f.close()

##################################

#4 saving a more complicated object to a file

my_dictionary = {"a key" :10, "another key": 11}

import pickle

f = open('../Sandbox/testp.p', 'wb')
pickle.dump(my_dictionary, f)
f.close()

#####################

#5 load a complicated object

f = open('../Sandbox/test.p', 'rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)

