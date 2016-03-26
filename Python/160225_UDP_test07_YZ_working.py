"""
Realtime Simulator

written by Yan "Ryan" Zhang <ryanz@mit.edu>
for MIT Media Lab, Changing Place Group, CityScope Project
March.1st.2016
"""

import socket

#UDP_IP = "RYAN_DELL_XPS_WIN8" #Dell desktop @ home
#UDP_PORT = 7002
#UDP_IP = "YANs-iMAC" #iMac @ CP/media lab wifi
#UDP_PORT = 7001
UDP_IP = "RYAN_YOGA_2_PRO" #Yoga @ CP/media lab wifi
UDP_PORT = 7002
#UDP_IP = "18.85.26.132" #iMac @ CP/media lab wifi
#UDP_PORT = 7003
#UDP_IP = "18.85.27.198" #Yoga @ CP/media lab wifi
#UDP_PORT = 7004

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

#while True:
data, addr = sock.recvfrom(9999) # buffer size is 1024 bytes
print "received message:", data