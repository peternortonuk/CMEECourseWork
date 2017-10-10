#!usr/bin/python

"""Chapter 5 Practicals, modify lc1.py"""

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# (2) Now do the same using conventional loops (you can shoose to do this 
# before 1 !). 

# ANNOTATE WHAT EVERY BLOCK OR, IF NECESSARY, LINE IS DOING! 

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT 
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS

__author__ = "Petra Guy, pg5117@ic.ac.uk"
__version__ = "2.7"

#imports

import sys

#constants

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )
#functions



#This is a for loop for extracting the informatio
#latin_birds = list()
#for bird in birds:
#	latin_birds.append(bird[0])
#print latin_birds

#here are the list comprehension ways of doing the above for loop
#NB the x in birds selects each element of the bids list (lapply), which 
#is a list of 3)

birds_latin = [x[0] for x in birds]
print birds_latin

birds_common = [x[1] for x in birds]
print birds_common

bmi = [x[2] for x in birds]
print bmi


if (__name__ == "__main__"):
		status = main(sys.argv)
		sys.exit(status)
