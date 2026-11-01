import socket
import struct
import sys

packer = struct.Struct("12s i")  # egyelore csak a 'Hello server' uzenet
server_addr = (sys.argv[1], int(sys.argv[2]))  # pl. python client.py localhost 10000

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client:
    client.connect(server_addr)
    values = ("Hello server".encode(), int(sys.argv[3]))
    client.sendall(packer.pack(*values))
    data = client.recv(64)
    print("Received:", data.decode())
