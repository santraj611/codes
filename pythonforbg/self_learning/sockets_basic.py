import socket


def main():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    s.bind(('127.0.0.1', 8888))
    s.listen()

    while True:
        client, addr = s.accept()
        print(f"Accepted a connection from {addr}")

        bytes_send: int = client.send("You are connected\n".encode())
        print(f"{bytes_send} bytes send to {addr}")

        client.close()

if __name__ == "__main__":
    main()
