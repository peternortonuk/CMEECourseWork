#!usr/bin/python

"""Practising with matplot.lib"""

__author__ = "Petra Guy, pg5117@ic.ac.uk"
__version__ = "2.7"
import os
import sys
import matplotlib.pyplot as plt
import pandas as pd
import pylab

def getdata(f):
	"""This function sticks the filename to the path for the data directory"""
	df = pd.read_csv(f)
	plt.plot(Year,Temp)
	plt.show()
	return df



def main(argv):
	data = getdata("../../Week3/Data/KeyWest.CSV")
	
	print(data)




if (__name__ == "__main__"):
		status = main(sys.argv)
		sys.exit(status)
