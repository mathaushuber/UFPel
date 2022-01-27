#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include "EDGrafo.h"

#define true 1
#define false 0

int parent[10];
typedef int bool;
typedef int TIPOPESO;

typedef struct adjacencia{
	int vertice;
	TIPOPESO peso;
	struct adjacencia *prox;
} ADJACENCIA;

typedef struct vertice {
	ADJACENCIA *partida;
} VERTICE;

typedef struct grafo {
	int vertices;
	int arestas;
	VERTICE *adj;
} GRAFO;

/* Alocando memória para o Grafo
@ entradas: numVertices - número de vértices do grafo
*/
GRAFO *criaGrafo(int numVertices) 
{
	int i;
	GRAFO *gr = (GRAFO*)malloc(sizeof(GRAFO));
	
	gr->arestas = 0; // Grafo inicial começa sem arestas
	gr->vertices = numVertices; // Estrutura do grafo recebe o número de vértices
	gr->adj = (VERTICE *)malloc(numVertices*sizeof(VERTICE)); // Alocando memória para a quantidade de vértices

	for (i=0; i<numVertices; i++) {
		gr->adj[i].partida = NULL;
	}

	return(gr);
}


/* Cria elemento da lista de adjacência com seu respectivo peso e coordenada
@ entradas: v - vértice final peso - valor atribuído à adjacência (peso)
*/
static ADJACENCIA *criaAdjacencia(int v, int peso) 
{
	ADJACENCIA *aux = (ADJACENCIA *)malloc(sizeof(ADJACENCIA));
	aux->vertice = v;
	aux->peso = peso;
	aux->prox = NULL;

	return(aux);
}

/* Cria aresta com seu vértice inicial, vértice final e seu peso respectivo
@entradas: pGrafo - estrutura do grafo vi - vértice inicial vf - vértice final peso - peso
*/
bool criaAresta(GRAFO *pGrafo, int vi, int vf, TIPOPESO peso) 
{
	if (!pGrafo) return (false);
	if ((vf<0) || (vf >= pGrafo->vertices)) return (false);
	if ((vi<0)||(vi >= pGrafo->vertices)) return (false);
	ADJACENCIA *novo = criaAdjacencia(vf,peso);
	novo->prox = pGrafo->adj[vi].partida;
	pGrafo->adj[vi].partida = novo;
	pGrafo->arestas++;
	return (true);
}

/* Imprimindo número de vértices do Grafo
@ entradas: pGrafo - estrutura do grafo
*/
void imprimeNumVertices (GRAFO *pGrafo)
{
	printf("Numero de Vertices: %d \n", pGrafo->vertices);
}

/* Imprimindo número de arestas do Grafo
@ entradas: pGrafo - estrutura do grafo
*/
void imprimeNumArestas (GRAFO *pGrafo)
{
	printf("Numero de Arestas:  %d \n", pGrafo->arestas);
}

/* Mostrando o Grafo
@ entradas: pGrafo - estrutura do grafo
*/
void imprimeGrafo(GRAFO *pGrafo) 
{
	int i;
	
	for (i=0; i<pGrafo->vertices; i++) {
		printf("v%d: ",i);
		
		ADJACENCIA *adjc = pGrafo->adj[i].partida;
		
		while(adjc) {
			printf("v%d(%d) ",adjc->vertice,adjc->peso);
			adjc = adjc->prox;
		}
		printf("\n");
	}	
}

static void inicializaD(GRAFO *g, int *d, int *p, int s)
{
	int v;
	for (v=0;v<g->vertices;v++) {
		d[v] = INT_MAX/2;
		p[v] = -1;
	}
	d[s] = 0;
} 

static void relaxa(GRAFO *g, int *d, int *p, int u, int v) 
{
	ADJACENCIA *ad = g->adj[u].partida;
	while (ad && ad->vertice != v) {
		ad = ad->prox;
	}
	if (ad) {
		if (d[v] > d[u] + ad->peso) {
			d[v] = d[u] + ad->peso;
			p[v] = u;
		}
	}
}

static bool existeAberto(GRAFO *g, int *aberto)
{
	int i;
	for (i=0;i<g->vertices;i++)
		if (aberto[i]) return true;
	return false;
	
}

static int menorDist(GRAFO *g, int *aberto, int *d)
{
	int i;
	for (i=0;i<g->vertices;i++)
		if (aberto[i]) break;
	if (i==g->vertices) return (-1);
	int menor = i;
	for (i=menor+1; i<g->vertices; i++)
		if (aberto[i] && (d[menor]>d[i]))
			menor = i;
	return (menor);
}

int *dijkstra(GRAFO *g, int s) 
{
	int *d = (int*)malloc(g->vertices*sizeof(int));
	int p[g->vertices];
	bool aberto[g->vertices];

	inicializaD(g,d,p,s);

	int i;

	for (i=0;i<g->vertices;i++) {
		aberto[i] = true;
	}

	while(existeAberto(g,aberto)) {
		int u = menorDist(g,aberto,d);
		aberto[u] = false;
		ADJACENCIA *ad = g->adj[u].partida;
		while(ad) {
			relaxa(g,d,p,u,ad->vertice);
			ad = ad->prox;
		}
	}
	return (d);
}

void imprimeMenorCaminho (GRAFO *pGrafo, int *s)
{
	int i;
	for (i=0;i<pGrafo->vertices;i++) {
		printf("v0 -> v%d = %d\n",i,s[i]);
	}

}

void kruskalMST(int numVertices)
{
    int cost[10][10];
    int u,v,i,j,minIte,a,b;
    int minCost=0;
    int nIte=1;
    
    printf("Matriz de adjacência:\n");
    for(i=1;i<=numVertices;i++)
    {
        for(j=1;j<=numVertices;j++)
        {
            scanf("%d",&cost[i][j]);
        }
    }
    
    while(nIte<numVertices)
    {
        minIte=999;
        for(i=1;i<=numVertices;i++)
        {
            for(j=1;j<=numVertices;j++)
            {
                if(cost[i][j]<minIte)
                {
                    minIte=cost[i][j];
                    a=u=i;
                    b=v=j;
                }
            }
        }
        
        u=buscaParent(u);
        v=buscaParent(v);
        if(juncaoParent(u,v))
        {
            printf("\n%d Borda(%d -> %d)=%d",nIte++,a,b,minIte);
            minCost += minIte;
        }
        cost[a][b]=cost[b][a]=999;
    }
    
    printf("\nCusto mínimo da árvore geradora: %d\n", minCost);
}

int buscaParent(int i)
{
    while(parent[i])
    {
        i=parent[i];
    }
    return i;
}

int juncaoParent(int i,int j)
{
    if(i!=j)
    {
        parent[j]=i;
        return 1;
    }
    return 0;
}
