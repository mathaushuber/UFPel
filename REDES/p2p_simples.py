import socket
import threading

class Peer:
    def __init__(self, endereco, porta):
        self.endereco = endereco
        self.porta = porta
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.amigos = []

    def conectar(self, endereco_destino, porta_destino):
        try:
            self.socket.connect((endereco_destino, porta_destino))
            threading.Thread(target=self.receber_mensagens).start()
            return True
        except Exception as e:
            print(f"Erro ao conectar: {e}")
            return False

    def receber_mensagens(self):
        while True:
            try:
                mensagem = self.socket.recv(1024).decode('utf-8')
                if not mensagem:
                    break
                print(f"[{self.endereco}:{self.porta}] Recebido: {mensagem}")
            except Exception as e:
                print(f"Erro ao receber mensagem: {e}")
                break

    def enviar_mensagem(self, mensagem, endereco_destino, porta_destino):
        try:
            self.socket.send(f"{mensagem}".encode('utf-8'))
        except Exception as e:
            print(f"Erro ao enviar mensagem para {endereco_destino}:{porta_destino}: {e}")

    def desconectar(self):
        self.socket.close()

if __name__ == "__main__":
    endereco_peer1 = 'localhost'
    porta_peer1 = 5001

    endereco_peer2 = 'localhost'
    porta_peer2 = 5002

    peer1 = Peer(endereco_peer1, porta_peer1)
    peer2 = Peer(endereco_peer2, porta_peer2)

    if peer1.conectar(endereco_peer2, porta_peer2):
        peer2.conectar(endereco_peer1, porta_peer1)

        while True:
            mensagem = input(f"[{peer1.endereco}:{peer1.porta}] Digite uma mensagem para enviar (ou 'exit' para sair): ")
            if mensagem.lower() == 'exit':
                break

            peer1.enviar_mensagem(mensagem, endereco_peer2, porta_peer2)

        peer1.desconectar()
        peer2.desconectar()
