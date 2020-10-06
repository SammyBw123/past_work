import sys
from sys import argv
import math
from collections import Counter
import numpy as np
# read each text file (con*.txt or lib*.txt) into array from split.train and split.test files
splitTrain = []
with open(sys.argv[1],'r') as file:
    splitTrain = file.read().splitlines()

splitTest = []
with open(sys.argv[2],'r') as file:
    splitTest = file.read().splitlines()

q = float(sys.argv[3])

###################################TRAINING###################################
vocab = []
conBlog = []
libBlog = []
blogsNum = len(splitTrain)+0.0
vocabCon = []
vocabLib = []

#create array of conservative and liberal blogs
for word in splitTrain:
    if word.startswith('con'):
        conBlog.append(word)
    if word.startswith('lib'):
        libBlog.append(word)
conBlogNum = len(conBlog)
libBlogNum = len(libBlog)

#Prior
conProb = conBlogNum / blogsNum
libProb = libBlogNum / blogsNum

#Vocab list (unique)
for i in range(0,len(splitTrain)):
    file = open(splitTrain[i],'r').read().split()
    file = [item.lower() for item in file]
    vocab.extend(file)
vocab = list(set(vocab))

#Conservative blogs (not unique)
vocabConList = []
holder = []
for i in range(0,len(conBlog)):
    file = open(conBlog[i],'r').read().split()
    holder.append(file)
for sublist in holder:
    for item in sublist:
        item = item.lower()
        vocabConList.append(item)
vocabCon = Counter(vocabConList)

#Liberal blogs (not unique)
vocabLibList = []
holder = []
for i in range(0,len(libBlog)):
    file = open(libBlog[i],'r').read().split()
    holder.append(file)
for sublist in holder:
    for item in sublist:
        item = item.lower()
        vocabLibList.append(item)
vocabLib = Counter(vocabLibList)

###################################TESTING###################################
vocabTest = []
nk_con = 0.0
nk_lib = 0.0
correct = 0.0

list = []
#Create vocab for test files
for i in range(0,len(splitTest)):
    file = open(splitTest[i],'r').read().split()
    vocabTest = [item.lower() for item in file]
    condProbCon = 0.0
    condProbLib = 0.0
    for key in vocabTest:
        if key in vocabCon or key in vocabLib:
            if key in vocabCon:
                nk_con = vocabCon[key]
                condProbCon = condProbCon + math.log(nk_con+q) - math.log(len(vocabConList) + q*len(vocab))
            else:
                nk_con = 0
                condProbCon = condProbCon + math.log(nk_con+q) - math.log(len(vocabConList) + q*len(vocab))
            if key in vocabLib:
                nk_lib = vocabLib[key]
                condProbLib = condProbLib + math.log(nk_lib+q) - math.log(len(vocabLibList) + q*len(vocab))
            else:
                nk_lib = 0
                condProbLib = condProbLib + math.log(nk_lib+q) - math.log(len(vocabLibList) + q*len(vocab))

    p_con = math.log(conProb) + condProbCon
    p_lib = math.log(libProb) + condProbLib
    if p_con > p_lib:
        print('C')
        list.append('C')
    if p_con < p_lib:
        print('L')
        list.append('L')

#For Accuracy calculations
for i in range(0,len(splitTest)):
    if splitTest[i].startswith('con') and list[i] == 'C':
        correct+=1
    if splitTest[i].startswith('lib') and list[i] == 'L':
        correct+=1

total = len(splitTest)+0.0
accuracy = correct / (total)
print('Accuracy: %.04f' % accuracy)
