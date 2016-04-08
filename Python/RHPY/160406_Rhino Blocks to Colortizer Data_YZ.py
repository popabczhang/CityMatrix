"""
CityMatrix

written by "Ryan" Yan Zhang <ryanz@mit.edu>
for MIT Media Lab, Changing Place Group
April.6th.2016
"""


# imports
import rhinoscriptsyntax as rs
import Rhino
import math


# variables
layerName = "test scene 02"
cellSize = 62.5
outputPath = "C:/Users/RYAN/Documents/GitHub/CityMatrix/Data/colortizer_data_rhino_02_YZ.txt"


# functions
def DecomposeXformRotation(arrXform):
    arrRotate = [0,0,0]
    arrRotate[0] = math.atan2(-arrXform[2,1], arrXform[2,2])/math.pi*180.0
    arrRotate[1] = math.asin(arrXform[2,0])/math.pi*180.0
    arrRotate[2] = math.atan2(arrXform[1,0], arrXform[0,0])/math.pi*180.0
    return arrRotate


# main script
strBlocks = rs.ObjectsByLayer(layerName)
print "number of blocks on layer \""+layerName+"\": "+str(len(strBlocks))

Data = "gridIndex\t0\ngridExtents\t16\t16\nIDMax\t15\ndockID\t-1\ndockRotation\t0\nslider1\t1.0\ntoggle1\t1\ntoggle2\t0\ntoggle3\t0\n"
if not len(strBlocks) == 0:
    for strBlock in strBlocks:
        name = rs.BlockInstanceName(strBlock)
        id = name.strip("module")[0:2]
        pt = rs.BlockInstanceInsertPoint(strBlock)
        x = str(int(pt[0]/cellSize-0.5+0.5))
        y = str(15-int(pt[1]/cellSize-0.5+0.5))
        arrXform = rs.BlockInstanceXform(strBlock)
        arrRotate = DecomposeXformRotation(arrXform)
        r = str(int(arrRotate[2]))
        Data += id+"\t"+x+"\t"+y+"\t"+r+"\n"
    f = open(outputPath, "w")
    f.write(Data)
    f.close()
    print Data
