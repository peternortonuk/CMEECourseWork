#!usr/bin/python

"""5.10 Loop exercises"""

__author__ = "Petra Guy, pg5117@ic.ac.uk"
__version__ = "2.7"

#imports

import sys

#constants

#functions

taxa = ["Quercus robur",
		"Fraxinus excelsior",
		"Pinus sylvestris",
		"Quercus cerris",
		"Quercus petrea", ]

def is_an_oak(name):
	return name.lower().startswith("quercus")
	
oaks_loops = set()

for species in taxa:
	if is_an_oak(species):
		oaks_loops.add(species)
print oaks_loops

oaks_lc = set([species for species in taxa if is_an_oak(species)])

print oaks_lc

oaks_loops = set()
for species in taxa:
	if is_an_oak(species):
		oaks_loops.add(species.upper())
print oaks_loops

oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print oaks_lc

#if (__name__ == "__main__"):
#		status = main(sys.argv)
#		sys.exit(status)
