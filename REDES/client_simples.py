import socket

def iniciar_cliente(porta):
    cliente = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    cliente.connect(('localhost', porta))

    while True:
        mensagem = input("Digite uma mensagem para enviar ao servidor (ou 'exit' para sair): ")
        cliente.send(mensagem.encode('utf-8'))

        if mensagem.lower() == 'exit':
            break

    cliente.close()

if __name__ == "__main__":
    porta_servidor = 12345
    iniciar_cliente(porta_servidor)
