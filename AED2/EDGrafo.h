

GRAFO *criaGrafo (int v);                       
bool criaAresta (GRAFO *gr, int vi, int vf, TIPOPESO peso);
void imprimeGrafo (GRAFO *gr);
void imprimeNumVertices (GRAFO *pGrafo);
void imprimeNumArestas (GRAFO *pGrafo);
int *dijkstra(GRAFO *, int s);
void imprimeMenorCaminho(GRAFO *,int *);
void kruskalMST(int numVertices);
int juncaoParent(int i,int j);
int buscaParent(int i);
