import socket
import threading
import os

class PeerClient:
    def __init__(self, endereco_servidor, porta_servidor):
        self.endereco_servidor = endereco_servidor
        self.porta_servidor = porta_servidor
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.arquivos_locais = []

    def conectar_servidor(self):
        self.socket.connect((self.endereco_servidor, self.porta_servidor))

    def listar_arquivos_servidor(self):
        self.socket.send("LISTAR".encode('utf-8'))
        lista_arquivos = self.socket.recv(1024).decode('utf-8')
        print(f"Arquivos disponíveis no servidor:\n{lista_arquivos}")

    def baixar_arquivo(self, nome_arquivo):
        self.socket.send(f"BAIXAR {nome_arquivo}".encode('utf-8'))

        resposta = self.socket.recv(1024).decode('utf-8')

        if resposta == "ARQUIVO_NAO_EXISTE":
            print(f"O arquivo '{nome_arquivo}' não existe no servidor.")
            return

        tamanho_arquivo = int(resposta)
        dados_recebidos = 0

        with open(nome_arquivo, 'wb') as arquivo:
            while dados_recebidos < tamanho_arquivo:
                dados = self.socket.recv(1024)
                arquivo.write(dados)
                dados_recebidos += len(dados)

        print(f"Arquivo '{nome_arquivo}' baixado com sucesso.")

    def menu(self):
        while True:
            comando = input("Digite 'listar' para ver os arquivos disponíveis ou 'baixar <nome_arquivo>' para baixar um arquivo: ")
            partes = comando.split()

            if partes[0] == "listar":
                self.listar_arquivos_servidor()
            elif partes[0] == "baixar" and len(partes) == 2:
                arquivo_a_baixar = partes[1]
                self.baixar_arquivo(arquivo_a_baixar)
            else:
                print("Comando inválido.")

if __name__ == "__main__":
    endereco_servidor = 'localhost'
    porta_servidor = 5000

    cliente_p2p = PeerClient(endereco_servidor, porta_servidor)

    threading.Thread(target=cliente_p2p.menu).start()
    cliente_p2p.conectar_servidor()
