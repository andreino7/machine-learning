__author__ = 'Filippo'

import csv
import random

random.seed("MachineLearning")
print random.random()
testHead = ["Id","Store","DayOfWeek","Date","Open","Promo","StateHoliday","SchoolHoliday"]
trainHead = ["Store","DayOfWeek","Date","Sales","Customers","Open","Promo","StateHoliday","SchoolHoliday"]

cvTrain = [trainHead]
cvTest = [testHead]
cvTestSol = []
i=1
with open('data/train.csv', 'rb') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    spamreader.next()
    for row in spamreader:
        if random.random() < 0.05:
            cvTestSol.append([i,int(row[3])])
            del row[3]
            del row[3]
            res = []
            res.append(i)
            for r in row:
                res.append(r)
            cvTest.append(res)
            i += 1
        else:
            cvTrain.append(row)


with open('data/cvTrain.csv', 'wb') as csvfile:
    writer = csv.writer(csvfile)
    for d in cvTrain:
        writer.writerow(d)

with open('data/cvTest.csv', 'wb') as csvfile:
    writer = csv.writer(csvfile)
    for d in cvTest:
        writer.writerow(d)

with open('data/cvTestSol.csv', 'wb') as csvfile:
    writer = csv.writer(csvfile)
    for d in cvTestSol:
        writer.writerow(d)