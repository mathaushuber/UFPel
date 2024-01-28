import socket

def iniciar_servidor(porta):
    servidor = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    servidor.bind(('localhost', porta))
    servidor.listen(1)

    print(f"Servidor esperando por conexões na porta {porta}...")

    conexao, endereco_cliente = servidor.accept()
    print(f"Conexão estabelecida com {endereco_cliente}")

    while True:
        mensagem = conexao.recv(1024)
        if not mensagem:
            break
        print(f"Cliente diz: {mensagem.decode('utf-8')}")

    conexao.close()
    servidor.close()

if __name__ == "__main__":
    porta_servidor = 12345
    iniciar_servidor(porta_servidor)
