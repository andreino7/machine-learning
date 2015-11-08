__author__ = 'Filippo'
import csv

data = []
with open('data/trainPreProc.csv', 'rb') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    spamreader.next()
    for row in spamreader:
        devPerc = float(row[3])/float(row[-1])
        row.append(devPerc)
        data.append(row)

with open('data/trainPreProc2.csv', 'wb') as csvfile:
    writer = csv.writer(csvfile)
    for d in data:
        writer.writerow(d)