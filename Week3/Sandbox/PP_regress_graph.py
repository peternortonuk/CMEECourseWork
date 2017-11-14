#!usr/bin/python
# The data consists of predator and prey mass by type of feeding interaction
# and predator lifestage. We need to subset the data first by type of
# feeding interation, then by predator lifestage.
# linear models are required for ln(Predmass) ~ ln(Preymass) for predator
# lifestage, for type of feeding interation.

""" Trying out graphing in python with matplotlib """

___author___ = "Petra Guy, pg5117@ic.ac.uk"
___version___ = "2.7"

import pdb
from scipy import stats
import pandas as pd
import numpy as np
from pprint import pprint as pp

# convert mg to grams
mydata = pd.read_csv("../Data/EcolArchives-E089-51-D1.csv")
mask = mydata['Prey.mass.unit'] == 'mg'
mydata.loc[mydata['Prey.mass.unit'] == 'mg', 'Prey.mass'] = mydata['Prey.mass'] * 1e-3

# take logs of prey mass and pred mass
mydata['logPreyMass'] = np.log(mydata['Prey.mass'])
mydata['logPredMass'] = np.log(mydata['Predator.mass'])

# Create an array of the type of feeding interactions
Feeding = mydata[u'Type.of.feeding.interaction'].unique()
# Create an array of the predator lifestages
life_stages = mydata[u'Predator.lifestage'].unique()

# Subset the database by each feeding interaction
feeding_dict = {elem: pd.DataFrame for elem in Feeding}

for key in feeding_dict.keys():
    mask = mydata[u'Type.of.feeding.interaction'] == key
    feeding_dict[key] = mydata[mask]

###### graphing to be adapted from iris practice ###

# create dataframe from numpy arrays
df_data = pd.DataFrame(data=iris.data, columns=iris.feature_names)
df_target = pd.DataFrame(data=iris.target, columns=['target'])
df = pd.concat([df_data, df_target], axis=1)

# create one figure
fig = Figure(figsize=(8, 6))
FigureCanvas(fig)
ax = fig.add_subplot(111)

# find all unique values of target
levels = df.groupby(['target']).all().index

for target in levels:
    # select the data
    mask = df['target'] == target
    x, y = df[mask]['petal length (cm)'], df[mask]['petal width (cm)']
    # add scatter to the axes
    ax.scatter(x, y, edgecolor='k')
    # fit and plot regression
    fit = np.polyfit(x, y, deg=1)
    ax.plot(x, fit[0] * x + fit[1])

fig.savefig('../Results/test_regression_group')