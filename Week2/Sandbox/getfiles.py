#!usr/bin/python


data = [line.strip() for line in open("../Data/seq.csv", "r")]

seq1 = data[0]
seq2 = data[1]

l2 = list(seq2)
l1 = list(seq1)

del l2[0]
del l1[0]
del l1[16]
del l2[10]

print l1
print l2

diff = len(l1) - len(l2)
print diff
l1 = l1[:len(l1)-diff]
print l1
print l2

import numpy as np
l1np = np.array(l1)
l2np = np.array(l2)

print l1np == l2np
print np.array_equal(l1np,l2np)

print sum(l1np == l2np)


