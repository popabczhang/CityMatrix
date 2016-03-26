# -*- coding: utf-8 -*-
"""
Realtime Simulator

written by Yan "Ryan" Zhang <ryanz@mit.edu>
for MIT Media Lab, Changing Place Group, CityScope Project
March.1st.2016
"""

import sys

filePath = "C:\Users\RYAN\Documents\GitHub\Realtime_Simulator\Python\hello" + sys.argv[2] + ".txt"
print(filePath) # print will not work when it is called by cmd


f = open(filePath, "w")
f.write("hello world! \n" + "Here's your sum: " + sys.argv[1])
f.close()