import socket
import struct
import time

SERVER_ADDR = ('localhost', 10000)
packer = struct.Struct("4s i")

commands = [
    (b"IN  ", 20),
    (b"INCR", 4),
    (b"DECR", 5)
]

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.connect(SERVER_ADDR)
    
    for cmd, val in commands:
        sock.sendall(packer.pack(cmd, val))
        resp = sock.recv(1024).decode('utf-8')
        print(f"Küldve: {cmd.decode().strip()} {val} --> Szerver válasza: {resp}")
        time.sleep(1)
