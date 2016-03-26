from socket import *
import sys
import select

address = ('localhost', 6005)
client_socket = socket(AF_INET, SOCK_DGRAM)

num_retransmits = 0
while(num_retransmits < 60):
    num_retransmits = num_retransmits + 1


    data = "Request 1"
    client_socket.sendto(data, address)
    print "Sending request 1"

    recv_data, addr = client_socket.recvfrom(2048)

    print recv_data, "!!"