import socket
import threading

def receive_messages(client_socket):
    try:
        while True:
            message = client_socket.recv(1024).decode()
            print(message)
    except Exception as e:
        print(f"Error: {e}")
    finally:
        client_socket.close()

def send_messages(client_socket):
    try:
        while True:
            message = input()
            client_socket.send(message.encode())
    except Exception as e:
        print(f"Error: {e}")
    finally:
        client_socket.close()

def main():
    username = input("Enter your username: ")
    server_ip = input("Enter the server IP: ")
    server_port = 8080

    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect((server_ip, server_port))
    
    # Enviar o nome de usuário para o servidor
    client.send(username.encode())

    # Thread para receber mensagens
    receive_thread = threading.Thread(target=receive_messages, args=(client,))
    receive_thread.start()

    # Thread para enviar mensagens
    send_thread = threading.Thread(target=send_messages, args=(client,))
    send_thread.start()

if __name__ == "__main__":
    main()
