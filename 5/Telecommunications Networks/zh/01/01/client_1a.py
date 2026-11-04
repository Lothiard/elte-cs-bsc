import socket
import struct
import random

SERVER_ADDR = ('localhost', 10000)
packer = struct.Struct("20s i")

# 1. Beolvasás konzolról
text = input("Adja meg a szöveget: ")
x = random.randint(1, len(text))
print(f"Generált véletlen szám (X): {x}")

# 2. Csomagolás és küldés
encoded_text = text.encode('utf-8')[:20]
packed_data = packer.pack(encoded_text, x)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.connect(SERVER_ADDR)
    sock.sendall(packed_data)
    
    # X bájt válasz fogadása
    response = sock.recv(x).decode('utf-8')
    print(f"Válasz a szervertől: {response}")
