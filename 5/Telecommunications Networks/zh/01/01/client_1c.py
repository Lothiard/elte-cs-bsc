import socket
import struct
import json
import random

SERVER_ADDR = ('localhost', 10000)
packer = struct.Struct("20s i")

# 1. input.json betöltése
with open('input.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# 2. Véletlen kulcs választása ("1", "2" vagy "3")
key = str(random.randint(1, 3))
text, x = data[key]
print(f"Kiválasztott JSON kulcs '{key}': szöveg='{text}', X={x}")

# 3. Küldés és fogadás
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.connect(SERVER_ADDR)
    sock.sendall(packer.pack(text.encode('utf-8')[:20], x))
    
    response = sock.recv(x).decode('utf-8')
    print(f"Válasz a szervertől: {response}")
