import socket
import struct

SERVER_ADDR = ('', 10001)
packer = struct.Struct("20s i")

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as server:
    server.bind(SERVER_ADDR)
    print("UDP Szerver (1/d. feladat) fut a 10001 porton...")

    while True:
        data, client_addr = server.recvfrom(1024)
        if len(data) >= packer.size:
            text_bytes, x = packer.unpack(data[:packer.size])
            text = text_bytes.rstrip(b'\x00').decode('utf-8')
            
            sliced_and_reversed = text[:x][::-1]
            response = sliced_and_reversed.encode('utf-8')[:x]
            
            server.sendto(response, client_addr)
