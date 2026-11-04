import socket
import struct

SERVER_ADDR = ('localhost', 10001)
packer = struct.Struct("20s i")

text = "barackfa"
x = 5

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
    sock.settimeout(2.0)
    packed_data = packer.pack(text.encode('utf-8')[:20], x)
    
    sock.sendto(packed_data, SERVER_ADDR)
    try:
        response, _ = sock.recvfrom(1024)
        print(f"Válasz UDP-n: {response.decode('utf-8')}")
    except socket.timeout:
        print("Hiba: Az UDP szerver nem válaszolt időben.")
