import socket
import threading
import os

class PeerServer:
    def __init__(self, endereco, porta):
        self.endereco = endereco
        self.porta = porta
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.arquivos_compartilhados = {}
        self.clientes_conectados = []

    def iniciar_servidor(self):
        self.socket.bind((self.endereco, self.porta))
        self.socket.listen(5)

        print(f"Servidor P2P iniciado em {self.endereco}:{self.porta}")

        while True:
            conexao, endereco_cliente = self.socket.accept()
            threading.Thread(target=self.lidar_com_cliente, args=(conexao, endereco_cliente)).start()

    def lidar_com_cliente(self, conexao, endereco_cliente):
        print(f"Conexão estabelecida com {endereco_cliente}")

        self.clientes_conectados.append(conexao)

        while True:
            mensagem = conexao.recv(1024).decode('utf-8')

            if not mensagem:
                print(f"Conexão com {endereco_cliente} encerrada.")
                self.clientes_conectados.remove(conexao)
                conexao.close()
                break

            partes = mensagem.split()
            comando = partes[0]

            if comando == "LISTAR":
                lista_arquivos = "\n".join(self.arquivos_compartilhados.keys())
                conexao.send(lista_arquivos.encode('utf-8'))
            elif comando == "BAIXAR":
                arquivo_solicitado = partes[1]
                if arquivo_solicitado in self.arquivos_compartilhados:
                    tamanho_arquivo = os.path.getsize(arquivo_solicitado)
                    conexao.send(str(tamanho_arquivo).encode('utf-8'))
                    with open(arquivo_solicitado, 'rb') as arquivo:
                        dados = arquivo.read(1024)
                        while dados:
                            conexao.send(dados)
                            dados = arquivo.read(1024)
                else:
                    conexao.send("ARQUIVO_NAO_EXISTE".encode('utf-8'))

    def compartilhar_arquivo(self, nome_arquivo):
        self.arquivos_compartilhados[nome_arquivo] = True

if __name__ == "__main__":
    endereco_servidor = 'localhost'
    porta_servidor = 5000

    servidor_p2p = PeerServer(endereco_servidor, porta_servidor)

    threading.Thread(target=servidor_p2p.iniciar_servidor).start()

    while True:
        comando = input("Digite 'compartilhar <nome_arquivo>' para compartilhar um arquivo: ")
        partes = comando.split()

        if len(partes) == 2 and partes[0] == "compartilhar":
            arquivo_a_compartilhar = partes[1]
            servidor_p2p.compartilhar_arquivo(arquivo_a_compartilhar)
        else:
            print("Comando inválido.")
