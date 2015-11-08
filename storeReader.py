__author__ = 'Filippo'
import csv
store = {}

for i in range(1500):
    store[i]=[]

with open('data/store.csv', 'rb') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    spamreader.next()
    for row in spamreader:
        store[int(row[0])]=row

print store