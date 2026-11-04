import socket
import struct

SERVER_ADDR = ('', 10000)
packer = struct.Struct("20s i")

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server:
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind(SERVER_ADDR)
    server.listen(5)
    print("TCP Szerver (1. feladat) fut a 10000 porton...")

    while True:
        client, addr = server.accept()
        with client:
            data = client.recv(packer.size)
            if not data or len(data) < packer.size:
                continue

            text_bytes, x = packer.unpack(data)
            # Nullbájtok levágása és dekódolás
            text = text_bytes.rstrip(b'\x00').decode('utf-8')

            # Első X karakter levágása és megfordítása
            sliced_and_reversed = text[:x][::-1]
            response = sliced_and_reversed.encode('utf-8')[:x]

            client.sendall(response)
