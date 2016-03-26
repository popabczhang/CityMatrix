# -*- coding: utf-8 -*-
"""
Realtime Simulator

For MIT Media Lab, Changing Place Group, CityScope Project

Written by Yan "Ryan" Zhang <ryanz@mit.edu>

March.1st.2016
"""

import sys

def hello(a, b):
    print "hello and that's your sum:"
    sum=a+b
    print sum

print "hello"
print str(sys.argv)
print "world"

hello(int(sys.argv[1]), int(sys.argv[2]))

f = open("C:\Users\RYAN\Documents\GitHub\Realtime_Simulator\Python\hello.txt", "w")
f.write("hello world! \n")
f.close()