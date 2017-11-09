#!usr/bin/python

""" Rewriting pp regress in python because my R attempt was shoddy"""

___author___= "Petra Guy, pg5117@ic.ac.uk"
___version___="2.7"
import math
import pandas as pd
import numpy as np
from pprint import pprint as pp

# convert mg to grams
mydata = pd.read_csv("../Data/EcolArchives-E089-51-D1.csv")
mask = mydata['Prey.mass.unit'] == 'mg'
mydata.loc[mydata['Prey.mass.unit'] == 'mg', 'Prey.mass'] = mydata['Prey.mass']*1e-3

#take logs of prey mass and pred mass
logPreyMass =  np.log(mydata['Prey.mass'])
logPredMass = np.log(mydata['Predator.mass'])

Feeding = mydata.Type.of.Feeding.interaction.values.unique()