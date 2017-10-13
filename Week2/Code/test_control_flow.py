#!usr/bin/python

"""Doctest example"""

#NB, import doctest. put >>> function, after the def and before the 
#function calcs. doctest will cf your output strings to output from
#function. put the doctest.testmod() at the end.

__author__ = "Petra Guy, pg5117@ic.ac.uk"
__version__ = "2.7"

#imports

import sys
import doctest

#constants

#functions

def even_or_odd(x=0): 
	"""Find whether a number x is even or odd
	>>> even_or_odd(10)
	'10 is Even'
	
	>>> even_or_odd(5)
	'5 is Odd'
	
	what happens when float is provided
	>>> even_or_odd(3.2)
	'3 is Odd'
	
	what happens with -ve
	>>> even_or_odd(-2)
	'-2 is Even'
	
	"""
	#Define function to be tested
	if x % 2 == 0:
		return "%d is Even" % x
	return "%d is Odd" % x


#Supress this block


#def main(argv):
#	print even_or_odd(22)
#	print even_or_odd(33)
#	print largest_divisor_five(120)
#	print largest_divisor_five(121)
#	print is_prime(60)
#	print is_prime(59)
#	print find_all_primes(100)
#	return 0

#if (__name__ == "__main__"):
#	satus = main(sys.argv)
#	sys.exit(status)


doctest.testmod() # runs the test
