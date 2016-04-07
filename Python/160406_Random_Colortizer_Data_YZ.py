"""
CityMatrix

written by "Ryan" Yan Zhang <ryanz@mit.edu>
for MIT Media Lab, Changing Place Group
April.6th.2016
"""


import time
import random
import socket


count = 0
outputPath = "C:/Users/RYAN/Documents/GitHub/CityMatrix/Data/colortizer_data.txt"

# # writing txt
# while True: 
#     Data = "gridIndex\t0\ngridExtents\t16\t16\nIDMax\t15\ndockID\t-1\ndockRotation\t0\nslider1\t1.0\ntoggle1\t1\ntoggle2\t0\ntoggle3\t0\n"
#     for i in range(16):
#     	for j in range(16):
#             Data += str(random.randint(-1,7))+"\t"+str(i)+"\t"+str(j)+"\t"+str(random.randint(0,3) * 90)+"\n"
#     print "data(count = "+str(count)+"): \n"+Data
#     f = open(outputPath, "w")
#     f.write(Data)
#     f.close()
#     print "writing to text file completed! "
#     count += 1
#     time.sleep(.5) #min sleep 0.3


UDP_IP = "127.0.0.1" #Yoga local
UDP_PORT = 7001

print "UDP target IP:", UDP_IP
print "UDP target port:", UDP_PORT

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP

# via udp
while True: 
    Data = "gridIndex\t0\ngridExtents\t16\t16\nIDMax\t15\ndockID\t-1\ndockRotation\t0\nslider1\t1.0\ntoggle1\t1\ntoggle2\t0\ntoggle3\t0\n"
    for i in range(16):
        for j in range(16):
            Data += str(random.randint(-1,7))+"\t"+str(i)+"\t"+str(j)+"\t"+str(random.randint(0,3) * 90)+"\n"
    print "data(count = "+str(count)+"): \n"+Data
    sock.sendto(Data, (UDP_IP, UDP_PORT))
    count += 1
    time.sleep(.5) #min sleep 0.1