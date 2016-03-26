# -*- coding: utf-8 -*-
"""
Created on Wed Feb 17 23:52:38 2016

@author: RYAN
"""

'''
# add ml libraries
from sklearn import linear_model
from sklearn.ensemble import RandomForestClassifier
# add basic data munging
from os import listdir
# Properly represent data
import numpy as np
# commands for reading in files on the system
from os.path import isfile, join
'''
import sys

print("hello world!") # print will not work when it is called by cmd

def hello(a, b):
    sum = a + b
    return sum

sumUp = hello(int(sys.argv[1]), int(sys.argv[2]))

f = open("C:\Users\RYAN\Documents\GitHub\Realtime_Simulator\Python\hello.txt", "w")
f.write("hello world! \n" + "Here's your sum: " + str(sumUp))
f.close()

#np.savetxt("foo.csv", regr., delimiter=",")