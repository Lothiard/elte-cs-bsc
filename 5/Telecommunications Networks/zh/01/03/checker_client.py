import socket
import struct

TCP_ADDR = ('localhost', 10000)
UDP_ADDR = ('localhost', 10001)

tcp_packer = struct.Struct("4s i")
udp_req_packer = struct.Struct("5s i")
udp_rep_packer = struct.Struct("i")

# 1. TCP Szerver lekérdezése
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as tcp_sock:
    tcp_sock.connect(TCP_ADDR)
    tcp_sock.sendall(tcp_packer.pack(b"INCR", 0))
    tcp_val = int(tcp_sock.recv(1024).decode('utf-8'))

# 2. UDP Szerver lekérdezése
with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as udp_sock:
    udp_sock.settimeout(2.0)
    udp_sock.sendto(udp_req_packer.pack(b"PLUS ", 0), UDP_ADDR)
    data, _ = udp_sock.recvfrom(1024)
    udp_val, = udp_rep_packer.unpack(data)

print(f"TCP érték: {tcp_val} | UDP érték: {udp_val}")

# 3. Összehasonlítás
if tcp_val == udp_val:
    print("Eredmény: Az UDP szerver HIBÁTLANUL működött!")
else:
    print(f"Eredmény: AZ UDP SZERVER HIBÁZOTT! (Eltérés: {udp_val - tcp_val})")
