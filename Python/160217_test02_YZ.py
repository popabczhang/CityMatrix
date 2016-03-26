# -*- coding: utf-8 -*-
"""
Created on Thu Feb 18 00:04:53 2016

@author: RYAN
"""

#import os
#import subprocess
#import sys

#subprocess.call("mycmd" + " myarg", shell=True)
#subprocess.call("python" + " C:\\Users\\RYAN\\Documents\\GitHub\\Realtime_Simulator\\Python\\160217_test01_YZ.py", shell=True)
#subprocess.call("python" + " C:\\Users\\RYAN\\Documents\\GitHub\\Realtime_Simulator\\Python\\160217_test01_YZ.py")
#subprocess.call("python" + " C:\Users\RYAN\Documents\GitHub\Realtime_Simulator\Python\160217_test01_YZ.py")
#subprocess.call("python C:\Users\RYAN\Documents\GitHub\Realtime_Simulator\Python\160217_test01_YZ.py")

from subprocess import call
call(["python", "C:\\Users\\RYAN\\Documents\\GitHub\\Realtime_Simulator\\Python\\160217_test01_YZ.py", "1", "2"])
# the print in called python script will not work

"""
call os in gh, and pass input parameters, 
and use subprocess to call a python script with arguement, 
output to a file and have gh read csv. 
"""