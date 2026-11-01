import socket
import struct
import sys

USERS = {
    0: "vendég",
    1: "Anna",
    2: "Bence",
    3: "Csilla",
    4: "Dávid",
    5: "Emese",
    6: "Ferenc",
    7: "Gréta",
    8: "Henrik",
    9: "Ilona",
    10: "János",
}

packer = struct.Struct("12s i")  # egyelore csak a 'Hello server' uzenet
server_addr = ("localhost", int(sys.argv[1]))  # pl. python server.py 10000

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind(server_addr)
    sock.listen(1)

    try:
        while True:
            try:
                client, client_addr = sock.accept()
                print(f"Connected: {client_addr[0]}:{client_addr[1]}")
                with client:
                    (greeting, user_id) = packer.unpack(client.recv(packer.size))
                    print(f"Received: {greeting.decode()} from user {user_id}")
                    name = USERS.get(user_id, "ismeretlen")
                    client.sendall(f"Hello {name}".encode())
            except socket.timeout:  # 1 mp alatt nem jott kliens: varunk tovabb
                pass
    except KeyboardInterrupt:
        print("Server stopped")
