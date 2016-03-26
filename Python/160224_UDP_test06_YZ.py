"""
Realtime Simulator

For MIT Media Lab, Changing Place Group, CityScope Project

Written by Yan "Ryan" Zhang <ryanz@mit.edu>

March.1st.2016
"""

import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
sock.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_TTL, 2)
sock.sendto("robot", ("239.192.0.100", 1000))