import socket
import struct
import time

PROXY_ADDR = ('localhost', 10000)
packer = struct.Struct("4s i")

commands = [
    (b"IN  ", 50),
    (b"INCR", 10),
    (b"DECR", 15)
]

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.connect(PROXY_ADDR)
    
    for cmd, val in commands:
        sock.sendall(packer.pack(cmd, val))
        resp = sock.recv(1024).decode('utf-8')
        print(f"Proxy-nak küldve: {cmd.decode().strip()} {val} --> Válasz: {resp}")
        time.sleep(1)
