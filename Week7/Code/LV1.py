""" The typical Lotka-Volterra Model simulated using scipy """

import scipy as sc 
import scipy.integrate as integrate
import pylab as p #Contains matplotlib for plotting

# import matplotlip.pylab as p #Some people might need to do this

def dR_dt(z0, t=0):
    """ Returns the growth rate of predator and prey populations at any 
    given time step """
    R = z0[0]
    C = z0[1]
    dRdt = r*R - a*R*C 
    dydt = -z*C + e*a*R*C
    return sc.array([dRdt, dydt])

# Define parameters:
r = 1. # Resource growth rate
a = 0.1 # Consumer search rate (determines consumption rate) 
z = 1.5 # Consumer mortality rate
e = 0.75 # Consumer production efficiency

# Now define time -- integrate from 0 to 15, using 1000 points:
t = sc.linspace(0, 15,  1000)

x0 = 10
y0 = 5 
z0 = sc.array([x0, y0]) # initials conditions: 10 prey and 5 predators per unit area

pops, infodict = integrate.odeint(dR_dt, z0,t, full_output=True)

infodict['message']     # >>> 'Integration successful.'

prey, predators = pops.T # What's this for? - transpose
f1 = p.figure() #Open empty figure object
p.plot(t, prey, 'g-', label='Resource density') # Plot
p.plot(t, predators  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population')
p.title('Consumer-Resource population dynamics')
p.show()
f1.savefig('prey_and_predators_1.pdf') #Save figure
