# -*- coding: utf-8 -*-
"""
Created on Fri Feb 19 16:21:21 2016

@author: jesse
""" 

import numpy as np
from sklearn.externals import joblib

def predictData(inputtf,outputtf  ,myVar):  
    
    # commands for reading in files on the system

    inputList = []
    outputList = []
    
    
   
    f = open(inputtf)
    data = f.read()
    f.close()
    # identify sections of data
    splitData = data.split("\n[start]")
     
    buildingHeight = splitData[0].split("\n")
    buildingHeight = buildingHeight[1:(len(buildingHeight)-1)]
    
    seedNum = splitData[1].split("\n")
    seedNum = buildingHeight[1:(len(buildingHeight)-1)]
    
    inputData = splitData[2].split("\n")
    inputData = inputData[1:(len(inputData)-1)]
    
    diffData = splitData[3].split("\n")
    diffData = diffData[1:(len(diffData)-2)]

    inputList.extend(inputData)
    outputList.extend(diffData)
    
    #PREPARE DATA FOR ANALYSIS
    
    selectInput = []
    inpList = []
    
    inpVals = ['0.1','25.0', '50.0', '80.0']
    newInpVals = ['1','2','3','4']
    # split up tuples
    for i in range(0, len(inputList)):
        inpList.append(inputList[i].split(",")[2])
    
    for j in range(len(inpVals)):
        for i in range(len(inpList)):
            if (inpList[i] == inpVals[j]):
                inpList[i] = newInpVals[j] 
        
        
    # Break data up into each input chunk
    for i in range(0, len(inpList), 1225):    
        val = inpList[i:i+1225]
        selectInput.append(val)    
    
    # split the data into training and testing sets
    xTest = selectInput
    xTest = np.array(xTest).astype(np.float)
    
    regr = joblib.load(myVar)
    np.savetxt(outputtf ,regr.predict(xTest), delimiter=",")

predictData("C:/Users/jesse/Downloads/Data1B-2B-3B/Data1B3B/160114_H25_R0.txt", "C:/Users/jesse/Dropbox (MIT)/Documents/MIT/UROPs/Cityscope/prediction.txt", "C:/Users/jesse/Dropbox (MIT)/Documents/MIT/UROPs/Cityscope/regr.pkl")