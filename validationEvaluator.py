__author__ = 'Filippo'

import csv
sol = {}
error = []
sqError = []
percErr = []

with open('data/cvTestSol.csv', 'rb') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    for row in spamreader:
        sol[int(row[0])] = int(row[1])

n=0
with open('data/cvSolution.csv', 'rb') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    spamreader.next()
    for row in spamreader:
        err = abs(int(row[1])-sol[int(row[0])] )
        error.append(err)
        if (int(row[1])!=0):
            errPerc= (float(err)/float(row[1]))*(float(err)/float(row[1]))
            n+=1
            percErr.append(errPerc)
        sqError.append(err*err)


sum = 0
sqSum = 0

for e in error:
    sum+=e
for e in sqError:
    sqSum+=e
ksum = 0
for e in percErr:
    ksum+=e

import math

print "Mean of absolute error: ", sum/len(error)
print "Mean of quadratic error: ", sqSum/len(error)
print "Root Mean Square Percentage Error: ", math.sqrt(float(ksum/n))