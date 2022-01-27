/* 						Mathaus Corrêa Huber - 16201045
 * 		Algoritmos e Estrutura de Dados II - Universidade Federal de Pelotas
 * 
 *	Descrição de variáveis:
 * 		  v - número de vértices do gŕafo
 		  gr - Grafo
		  vi - vertice inicial
		  vf - vertice final
		  peso - peso 
 *  Descrição da estrutura:
 * 		  Um grafo consiste de um conjunto finito (e, possivelmente, mutável) de vértices ou nós.
 * 		  Na nossa estrutura de grafo, permitimos o armazenamento de até 20 vértices
 * 		  Efetuamos a leitura dos pesos das arestas de cada vértice
 * 		  Considerando sempre vértices positivos
 * 		  Mostrando os dados armazenados, número de vértices e arestas
 * 		  Mostrando o caminho mínimo entre dois vértices
 * 		  Mostrando a Árvore Geradora Mínima resultante da execução do Algoritmos de Kruskal.
*/

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main() {
	int numVertices, escolha, verticeInicial, verticeFinal, pesoAresta;
	printf("Quantos vértices você deseja? ");
	scanf("%d", &numVertices);
	GRAFO *estruturaGrafo = criaGrafo(numVertices);
	if(numVertices > 20){
		printf("Opção não disponível, 20 é o limite máximo de vértices, tente novamente mais tarde!");
		exit(1);
	}
	
	 do{
            printf("---------Menu---------");
            printf("\n\t1. Criar Aresta");
            printf("\n\t2. Imprimir Grafo");
            printf("\n\t3. Imprimir Número de Vértices");
            printf("\n\t4. Imprimir Número de Arestas");
            printf("\n\t5. Menor caminho possível");
            printf("\n\t6. Árvore Geradora Mínima");
            printf("\n\t7. Sair");
            printf("\n\tDigite sua escolha: ");
            scanf("%d", &escolha);
            switch(escolha){
            case 1:
				printf(" Vértice inicial: ");
				scanf("%d", &verticeInicial);
				printf(" Vértice final: ");
				scanf("%d", &verticeFinal);
				printf(" Peso da Aresta: ");
				scanf("%d", &pesoAresta);
                criaAresta(estruturaGrafo, verticeInicial, verticeFinal, pesoAresta);
                break;
            case 2:
                imprimeGrafo(estruturaGrafo);
                break;
            case 3:
                imprimeNumVertices(estruturaGrafo);
                break;
            case 4:
                imprimeNumArestas(estruturaGrafo);
                break;
            case 5:;
				int *s = dijkstra(estruturaGrafo,0);
				imprimeMenorCaminho(estruturaGrafo,s);
			case 6:
				kruskalMST(numVertices);
				break;
            case 7:
				free(estruturaGrafo);
                exit(0);
                break;
            default:
                printf("Opção inválida");
                break;
            }
    }while(escolha != EOF);


	return 0;
}
