#!usr/bin/python

___author___ = "Petra Guy, pg5117@ic.ac.uk"
___version___ = "2.7"

""" The typical Lotka-Volterra Model simulated using scipy """
import sys
import scipy as sc
import scipy.integrate as integrate
import pylab as p  # Contains matplotlib for plotting
import pandas as pd





columns = ['R','C']
results = pd.DataFrame()

def dR_dt(z0, r,a,z,e):
    """ Returns the growth rate of predator and prey populations at any
    given time step """
    R = z0[0]
    C = z0[1]
    for t in range(1,1000):
        R = R + R*r -R*R*r - a*C
        C = C - C*z+C*e*a*R
        df = pd.DataFrame({'R':R, 'C':C})
        results = results.append(df, ignore_index=True,)
        R = R+t
        C = C+t
    return results

def main(argv):
    x0 = 10
    y0 = 5
    z0 = sc.array([x0, y0])
    r = 1.  # Resource growth rate
    a = 0.1  # Consumer search rate (determines consumption rate)
    z = 1.5  # Consumer mortality rate
    e = 0.75
    dR_dt(z0, r,a,z,e)
    print results[columns].head()

if (__name__ == "__main__"):
	status = main(sys.argv)
	sys.exit(status)