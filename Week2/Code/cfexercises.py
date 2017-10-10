#!usr/bin/python

"""5.9.1 Control flow exercises"""

__author__ = "Petra Guy, pg5117@ic.ac.uk"
__version__ = "2.7"

#imports

import sys

#constants

#functions

for i in range(3, 17):
	print "hello"

for j in range(12):
	if j % 3 == 0:
		print "hello"

for j in range(15):
	if j % 5 == 3:
		print "hello"
	elif j % 4 == 3:
		print "hello"
		
z = 12
while z < 100:
	if z == 31:
		for k in range(7):
			print "hello"
	elif z == 18:
		print "hello"
	z = z + 1
	
def foo1(x):
		return x ** 0.5

def foo2(x,y):
	if x > y:
		return x
	return y
		
if (__name__ == "__main__"):
		status = main(sys.argv)
		sys.exit(status)
