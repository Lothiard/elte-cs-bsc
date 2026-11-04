import socket
import struct
import random

SERVER_ADDR = ('localhost', 10000)
packer = struct.Struct("20s i")

# 1. input.txt beolvasása
lines = []
with open('input.txt', 'r', encoding='utf-8') as f:
    for line in f:
        if line.strip():
            parts = line.strip().split()
            lines.append((parts[0], int(parts[1])))

# 2. Véletlen sor kiválasztása (1 és 3 között)
rand_idx = random.randint(1, len(lines))
text, x = lines[rand_idx - 1]
print(f"Kiválasztott sor ({rand_idx}.): szöveg='{text}', X={x}")

# 3. Küldés és fogadás
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.connect(SERVER_ADDR)
    sock.sendall(packer.pack(text.encode('utf-8')[:20], x))
    
    response = sock.recv(x).decode('utf-8')
    print(f"Válasz a szervertől: {response}")
