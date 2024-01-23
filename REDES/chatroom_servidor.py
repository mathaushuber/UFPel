import socket
import threading

clients = {}

def broadcast(message, sender_username):
    for client_socket, username in clients.items():
        if username != sender_username:
            try:
                client_socket.send(message)
            except socket.error:
                # Remove clientes que não estão mais respondendo
                del clients[client_socket]
                print(f"[*] {username} disconnected.")

def handle_client(client_socket, username):
    try:
        while True:
            message = client_socket.recv(1024)
            if not message:
                break

            if message.startswith(b'/list'):
                user_list = "\n".join([f"- {user}" for user in clients.values()])
                client_socket.send(f"[Server] Connected users:\n{user_list}\n".encode())
            elif message.startswith(b'/pm'):
                # TODO: Implementar a lógica para mensagens privadas
                pass
            else:
                broadcast(f"[{username}] {message}", username)
    except Exception as e:
        print(f"Error: {e}")
    finally:
        client_socket.close()
        del clients[client_socket]
        print(f"[*] {username} disconnected.")

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(('0.0.0.0', 8080))
    server.listen(5)
    print("[*] Server listening on 0.0.0.0:8080")

    while True:
        client, addr = server.accept()
        print(f"[*] Accepted connection from: {addr[0]}:{addr[1]}")

        username = client.recv(1024).decode()
        clients[client] = username

        broadcast(f"[Server] {username} joined the chat.", username)

        client_handler = threading.Thread(target=handle_client, args=(client, username))
        client_handler.start()

if __name__ == "__main__":
    main()
